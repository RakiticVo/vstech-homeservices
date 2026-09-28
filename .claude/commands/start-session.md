# /start-session

Khởi động phiên làm việc mới trên dự án `vstech_home_services`.

Thực hiện theo quy trình chuẩn đã định nghĩa tại `.claude/skills/start-session/SKILL.md`:
1. Đọc và tuân thủ các quy tắc trong `CLAUDE.md`, `docs/design/MASTER_SPEC_V9.md`, và `docs/reference/PHASE1_SCOPE.md`.
2. Kiểm tra tình trạng git (`git status`, `git log -n 5 --oneline`).
3. Chạy kiểm tra tĩnh và kiểm thử: `flutter analyze` và `flutter test`.
4. Quét hiện trạng các modules trong `lib/features/` đối chiếu ma trận 16 màn hình trong `MASTER_SPEC_V9.md`.
5. Trả về báo cáo phiên làm việc ngắn gọn và gợi ý bước tiếp theo.
