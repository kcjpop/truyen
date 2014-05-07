$(function() {
  $('.popup').popup();
  $('.ui.dropdown').dropdown();
  $('.ui.sidebar.chapters').sidebar({
    overlay: true
  }).sidebar('attach events', '.toc').sidebar('attach events', '.ui.sidebar.chapters .close.button');
  return $('.ui.sidebar.navbar').sidebar({
    overlay: true
  }).sidebar('attach events', '.menu.item');
});
