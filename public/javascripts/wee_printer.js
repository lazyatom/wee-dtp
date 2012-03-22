var sendContent = function() {
  var makeAbsolute = function(path) {
    if (isRelative(path)) {
      return window.location.origin + path;
    } else {
      return path;
    }
  }

  var isRelative = function(path) {
    return !path.match(/^http/);
  }

  $("img").each(function(x, i) {
    if (i.src)  { i.src = makeAbsolute(i.src) }
  });
  $("script").each(function(x,e) {
    if (e.src) { e.src = makeAbsolute(e.src) }
  });
  $("link[rel=stylesheet]").each(function(x, s) {
    if (s.href != "data:text/css," && isRelative($($("link[rel=stylesheet]")[0]).attr("href"))) {
      $.get(s.href, function(data) {
        console.log("replacing", s);
        var styles = $("<style></style>").append(data);
        $(s).replaceWith(styles);
      })
    }
  });
  //return $.post("http://wee-printer.gofreerange.com/preview", {content: $("html").html()}, function(data) { window.location = data.location }, 'json');
}