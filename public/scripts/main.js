require.config({
  baseUrl: '/',
  paths: {
    'jquery': 'bower_components/jquery/jquery.min',
    'semantic-ui': 'bower_components/semantic-ui/build/packaged/javascript/semantic.min'
  }
});

require(['jquery', 'semantic-ui'], function($) {
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
});
