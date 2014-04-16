$(function() {
    $('.popup').popup();

    var sidebarChapters = $('.ui.sidebar.chapters')
    .sidebar({overlay: true})
    .sidebar('attach events', '.toc')
    .sidebar('attach events', '.ui.sidebar.chapters .close.button');

    var navbar = $('.ui.sidebar.navbar')
    .sidebar({overlay: true})
    .sidebar('attach events', '.menu.item');

    $('.ui.dropdown').dropdown();
});