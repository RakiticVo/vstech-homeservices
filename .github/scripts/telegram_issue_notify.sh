#!/usr/bin/env bash
# Sends a GitHub issue / issue-comment event to a Telegram chat (optionally a forum topic) as plain
# text, in the team's format:
#
#   🐛 Issue #100 closed (V-STECH/home_services_mobile)
#   <issue title>
#   by <actor>
#   <issue url>
#
# All event data arrives through environment variables set by the workflow — never interpolated
# into this script — so issue titles / comments cannot inject shell commands.
#
# Required: TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID, EVENT_NAME, ACTION, REPO, ISSUE_NUMBER,
#           ISSUE_TITLE, ISSUE_URL, ACTOR
# Optional: TELEGRAM_MESSAGE_THREAD_ID (forum topic), COMMENT_BODY
# DRY_RUN=1 prints the Telegram payload instead of sending it.
set -euo pipefail

MAX_COMMENT_CHARS="${MAX_COMMENT_CHARS:-300}"

if [ "${EVENT_NAME}" = "issue_comment" ]; then
  comment="${COMMENT_BODY-}"
  if [ "${#comment}" -gt "${MAX_COMMENT_CHARS}" ]; then
    comment="${comment:0:${MAX_COMMENT_CHARS}}…"
  fi
  text="💬 Comment mới trên #${ISSUE_NUMBER} (${REPO})
${ISSUE_TITLE}
by ${ACTOR}:
${comment}
${ISSUE_URL}"
else
  text="🐛 Issue #${ISSUE_NUMBER} ${ACTION} (${REPO})
${ISSUE_TITLE}
by ${ACTOR}
${ISSUE_URL}"
fi

payload="$(
  jq -n \
    --arg chat_id "${TELEGRAM_CHAT_ID}" \
    --arg thread_id "${TELEGRAM_MESSAGE_THREAD_ID-}" \
    --arg text "${text}" \
    '{chat_id: $chat_id, text: $text, link_preview_options: {is_disabled: true}}
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
