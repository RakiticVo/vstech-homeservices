# HomeService — Concept 02 / Contemporary Folk Utility

Bộ bàn giao này được dựng trực tiếp từ concept hình ảnh đã chốt.

## Cấu trúc

- `index.html` — presentation board, hiển thị reference 1:1 và gallery.
- `screens.html` — gallery 14 màn hình.
- `screens/*.html` — trang HTML riêng cho từng màn hình.
- `assets/reference-concept02.png` — ảnh concept gốc.
- `assets/screens/*.png` — crop từng màn hình từ ảnh nguồn.
- `assets/screens/*@3x.png` — bản phóng 3x để xem rõ hơn.
- `assets/brand/*.png` — các vùng brand/illustration/palette tách từ board.
- `css/tokens.css` — design tokens.
- `css/app.css` — CSS cho gallery/prototype.
- `docs/DESIGN_SPEC.md` — đặc tả visual và mapping màn hình.

## Độ giống hình gốc

`index.html` sử dụng chính `assets/reference-concept02.png`, vì vậy phần presentation reference là 1:1 pixel với ảnh nguồn. Các màn hình riêng cũng được crop trực tiếp từ ảnh nguồn, không redraw nên giữ nguyên bố cục/hình ảnh của concept.

Bản `@3x` được upscale + sharpen nhẹ để thuận tiện zoom; nó không thể tạo thêm chi tiết vốn không có trong raster gốc.

## Chạy local

Có thể mở trực tiếp `index.html`, hoặc chạy một HTTP server đơn giản:

```bash
python -m http.server 8000
```

Sau đó mở `http://localhost:8000/`.
