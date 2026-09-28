document.addEventListener('click', e => {
  const a=e.target.closest('[data-screen]');
  if(!a) return;
  localStorage.setItem('lastScreen', a.dataset.screen);
});
