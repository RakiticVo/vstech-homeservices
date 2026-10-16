#!/usr/bin/env bash
# Posts the outcome of a release pipeline run to Telegram, in the same plain-text style as the
# issue notifications:
#
#   🚀 Release v1.0.0-uat (V-STECH/home_services_mobile)
#   UAT · version 1.0.0 (build 1)
#   by RakiticVo
#   🤖 Android: ✅ Firebase App Distribution
#   🍎 iOS: ✅ TestFlight
#   📦 Artifacts: <run url>
#
# Env (all from the workflow, never interpolated into the script):
#   TAG, REPO, ACTOR, RUN_URL, APP_VERSION (pubspec "1.0.0+1"),
#   TEST_RESULT, ANDROID_RESULT, IOS_RESULT — success | failure | cancelled | skipped
# Telegram settings and DRY_RUN: see telegram_send.sh.
set -euo pipefail

if [[ "${TAG}" == *-uat* ]]; then
  channel="UAT"
  android_target="Firebase App Distribution"
  ios_target="TestFlight"
else
  channel="Production"
  android_target="Google Play"
  ios_target="App Store Connect"
fi

version_name="${APP_VERSION%%+*}"
build_number="${APP_VERSION#*+}"
[ "${build_number}" = "${APP_VERSION}" ] && build_number="?"

status_icon() {
  case "$1" in
    success) echo "✅" ;;
    failure) echo "❌" ;;
    cancelled) echo "⏹" ;;
    *) echo "⏭" ;;
  esac
}

results=("${TEST_RESULT}" "${ANDROID_RESULT}" "${IOS_RESULT}")
if printf '%s\n' "${results[@]}" | grep -qx failure; then
  header="❌ Release ${TAG} lỗi"
elif printf '%s\n' "${results[@]}" | grep -qx cancelled; then
  header="⏹ Release ${TAG} đã huỷ"
else
  header="🚀 Release ${TAG}"
fi

lines=("${header} (${REPO})" "${channel} · version ${version_name} (build ${build_number})" "by ${ACTOR}")
# Tests only get a line when they did not pass (then the builds never ran).
if [ "${TEST_RESULT}" != "success" ]; then
  lines+=("🧪 Test: $(status_icon "${TEST_RESULT}")")
fi
if [ "${ANDROID_RESULT}" != "skipped" ]; then
  lines+=("🤖 Android: $(status_icon "${ANDROID_RESULT}") ${android_target}")
fi
if [ "${IOS_RESULT}" != "skipped" ]; then
  lines+=("🍎 iOS: $(status_icon "${IOS_RESULT}") ${ios_target}")
fi
lines+=("📦 Artifacts: ${RUN_URL}")

text="$(printf '%s\n' "${lines[@]}")"
bash "$(dirname "$0")/telegram_send.sh" "${text}"
