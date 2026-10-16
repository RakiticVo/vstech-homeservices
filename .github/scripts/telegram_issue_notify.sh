#!/usr/bin/env bash
# Sends a GitHub issue / issue-comment event to a Telegram chat (optionally a forum topic).
#
# All event data arrives through environment variables set by the workflow — never interpolated
# into this script — so issue titles / bodies cannot inject shell commands.
#
# Required: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID, EVENT_NAME, ACTION, REPO, ISSUE_NUMBER,
#           ISSUE_TITLE, ISSUE_URL, ACTOR
# Optional: TELEGRAM_MESSAGE_THREAD_ID (forum topic), ISSUE_BODY, ISSUE_LABELS, ISSUE_ASSIGNEES,
#           ISSUE_STATE_REASON, ASSIGNEE, COMMENT_BODY, COMMENT_URL
# DRY_RUN=1 prints the Telegram payload instead of sending it.
set -euo pipefail

MAX_BODY_CHARS="${MAX_BODY_CHARS:-1200}"

# Telegram HTML mode only needs &, < and > escaped.
escape_html() {
  local text="${1-}"
  text="${text//&/&amp;}"
  text="${text//</&lt;}"
  text="${text//>/&gt;}"
  printf '%s' "$text"
}

# Collapses runs of blank lines and cuts long text so the message stays well under 4096 chars.
excerpt() {
  local text
  text="$(printf '%s' "${1-}" | tr -d '\r' | cat -s)"
  if [ "${#text}" -gt "$MAX_BODY_CHARS" ]; then
    text="${text:0:$MAX_BODY_CHARS}…"
  fi
  printf '%s' "$text"
}

case "${EVENT_NAME}:${ACTION}" in
  issues:opened) header="🆕 Issue mới" ;;
  issues:reopened) header="🔄 Issue mở lại" ;;
  issues:closed)
    if [ "${ISSUE_STATE_REASON-}" = "not_planned" ]; then
      header="⛔ Issue đóng (không xử lý)"
    else
      header="✅ Issue đã xong"
    fi
    ;;
  issues:assigned) header="👤 Issue được giao" ;;
  issue_comment:created) header="💬 Bình luận mới" ;;
  *)
    echo "Ignoring ${EVENT_NAME}:${ACTION}"
    exit 0
    ;;
esac

title="$(escape_html "${ISSUE_TITLE}")"
repo="$(escape_html "${REPO}")"
actor="$(escape_html "${ACTOR}")"
link="${ISSUE_URL}"

lines=()
lines+=("<b>${header}</b> · ${repo}")
lines+=("<a href=\"${link}\">#${ISSUE_NUMBER} ${title}</a>")

case "${EVENT_NAME}:${ACTION}" in
  issues:assigned)
    lines+=("Giao cho: <b>$(escape_html "${ASSIGNEE:-${ISSUE_ASSIGNEES-}}")</b> · bởi ${actor}")
    ;;
  issue_comment:created)
    lines+=("Bởi: ${actor}")
    if [ -n "${COMMENT_BODY-}" ]; then
      lines+=("" "<blockquote>$(escape_html "$(excerpt "${COMMENT_BODY}")")</blockquote>")
    fi
    if [ -n "${COMMENT_URL-}" ]; then link="${COMMENT_URL}"; fi
    ;;
  *)
    lines+=("Bởi: ${actor}")
    [ -n "${ISSUE_LABELS-}" ] && lines+=("Nhãn: $(escape_html "${ISSUE_LABELS}")")
    [ -n "${ISSUE_ASSIGNEES-}" ] && lines+=("Người xử lý: $(escape_html "${ISSUE_ASSIGNEES}")")
    if [ "${ACTION}" = "opened" ] && [ -n "${ISSUE_BODY-}" ]; then
      lines+=("" "<blockquote>$(escape_html "$(excerpt "${ISSUE_BODY}")")</blockquote>")
    fi
    ;;
esac

text="$(printf '%s\n' "${lines[@]}")"

payload="$(
  jq -n \
    --arg chat_id "${TELEGRAM_CHAT_ID}" \
    --arg thread_id "${TELEGRAM_MESSAGE_THREAD_ID-}" \
    --arg text "${text}" \
    --arg url "${link}" \
    '{
      chat_id: $chat_id,
      text: $text,
      parse_mode: "HTML",
      link_preview_options: {is_disabled: true},
      reply_markup: {inline_keyboard: [[{text: "Mở trên GitHub", url: $url}]]}
    }
    + (if $thread_id == "" then {} else {message_thread_id: ($thread_id | tonumber)} end)'
)"

if [ "${DRY_RUN-}" = "1" ]; then
  printf '%s\n' "${payload}"
  exit 0
fi

: "${TELEGRAM_BOT_TOKEN:?TELEGRAM_BOT_TOKEN is not set}"
response="$(
  curl -sS -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    -H 'Content-Type: application/json' \
    --data "${payload}"
)"
if [ "$(printf '%s' "${response}" | jq -r '.ok')" != "true" ]; then
  echo "::error::Telegram sendMessage failed: $(printf '%s' "${response}" | jq -r '.description // "unknown error"')"
  exit 1
fi
echo "Sent to Telegram (message_id $(printf '%s' "${response}" | jq -r '.result.message_id'))"
