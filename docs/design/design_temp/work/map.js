const MAP = (() => {
  const st = (d, w, c) => '<path d="' + d + '" stroke="' + c + '" stroke-width="' + w + '" fill="none" stroke-linecap="round"/>';
  let s = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 210"><rect width="350" height="210" fill="#EEE8DA"/>';
  s += '<path d="M0 168 C70 150 130 190 220 176 S320 140 350 150 L350 210 L0 210Z" fill="#CFE3EA"/>';
  s += '<rect x="96" y="112" width="62" height="40" rx="6" fill="#DCE9D2"/><rect x="214" y="18" width="48" height="30" rx="6" fill="#DCE9D2"/>';
  ['M0 40 H350','M0 100 H350','M60 0 V210','M180 0 V160','M280 0 V150','M0 150 L120 60 L220 0'].forEach(d => s += st(d, 11, '#FFFFFF'));
  ['M0 70 H350','M120 0 V160','M235 0 V150','M0 125 H300'].forEach(d => s += st(d, 5, '#F8F4EC'));
  s += '<path d="M60 40 V100 H180 V60 H280" stroke="#0F766E" stroke-width="6" fill="none" stroke-linecap="round" stroke-linejoin="round"/>';
  s += '<circle cx="60" cy="40" r="13" fill="#0F766E" fill-opacity=".18"/><circle cx="60" cy="40" r="7" fill="#0F766E" stroke="#FFFFFF" stroke-width="2.5"/>';
  s += '<path d="M280 38 c-9 0-15 7-15 15 0 11 15 24 15 24 s15-13 15-24 c0-8-6-15-15-15z" fill="#F59E0B" stroke="#FFFFFF" stroke-width="2.5"/><circle cx="280" cy="53" r="5" fill="#FFFFFF"/>';
  return 'data:image/svg+xml,' + encodeURIComponent(s + '</svg>');
})();
const OST = [['Đã nhận việc','Accepted'],['Thợ đang đến','On the way'],['Thợ đã đến','Arrived'],['Đang thực hiện','In progress'],['Chờ nghiệm thu','Awaiting sign-off'],['Chờ thanh toán','Awaiting payment'],['Hoàn tất','Completed']];
