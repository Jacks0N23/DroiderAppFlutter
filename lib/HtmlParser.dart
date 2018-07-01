import 'package:html/parser.dart';

class HtmlParser {
  final String articleHtml;
  String parsedHtml = """<html><body>hello</body></html>""";

  HtmlParser(this.articleHtml);

  String parseHtml() {
    final document = parse(articleHtml);
    final articles = document.querySelectorAll("article[id^=post]");
    if (articles.isNotEmpty) {
      final articleBody = articles[0].querySelectorAll(".article-body");
      var _articleHtml = _setupHtml(articleBody[0].outerHtml);
      print(_articleHtml);
      parsedHtml = _articleHtml;
      return _articleHtml;
    } else
      return "";
  }

  String _setupHtml(String html) {
    final head = """<head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href='https://fonts.googleapis.com/css?family=Roboto:300,700italic,300italic' rel='stylesheet' type='text/css'>""" +
        _style() +
        """</head>""";

    return """<html>$head<body><div class="container">$html</div></body></html>""";
  }

  String _style() {
    return "<style>" +
        "body { " +
        "margin:0; padding-top:8dp; " +
        "font-family:Roboto, sans-serif; " +
        "font-size: 18px; " +
        "color:" +
        "#000" +
        "}" +
        ".container { " +
        "padding-left:10px; padding-right:10px; padding-bottom:10px;" +
        "}" +
        ".article_image { " +
        "margin-left:-16px;margin-right:-16px;" +
        "}" +
        ".iframe_container { " +
        "margin-left:-16px; margin-right:-16px; " +
        "position:relative; overflow:hidden;" +
        "}" +
        "a { " +
        "color:" +
        "#00f" +
        ";" +
        "}" +
        "iframe { " +
        "max-width: 100%; width: 100%; height: 260px; allowfullscreen; " +
        "}" +
        "img { " +
        "max-width: 100%; width: 100vW; height: auto; margin-bottom:10px; " +
        "}" +
        "table { " +
        "border-collapse: collapse;" +
        "overflow: hidden" +
        "}" +
        "td { " +
        "padding: 3px;" +
        "}" +
        ".article-gallery__photos .article-gallery__photos__list { " +
        "list-style-type: none; padding:0;margin:0; " +
        "}" +
        ".article-gallery__thumb { " +
        "display: none; " +
        "}" +
        ".article-table { " +
        "position: relative;" +
        "background:" +
        "#ddd" +
        ";" +
        "}" +
        ".article-table__table { " +
        "width: 100%;" +
        "background: " +
        "#ddd" +
        ";" +
        "}" +
        ".article-table__head { " +
        "background: " +
        "#eee" +
        ";" +
        "}" +
        ".article-table__head__cell {" +
        "font-weight: bold;" +
        "}" +
        ".article-tech__header {" +
        "background: " +
        "#eee" +
        ";" +
        "padding-top: 55px;" +
        "padding-bottom: 15px;" +
        "}" +
        ".article-tech__header__picture {" +
        "background: no-repeat 50% 50%/cover;" +
        "position: absolute;" +
        "}" +
        ".article-tech__header__title {" +
        "font-size: 23px;" +
        "padding-left: 5px;" +
        "}" +
        ".article-tech__info { " +
        "background: " +
        "#ddd" +
        ";" +
        "padding: 10px 5px;" +
        "}" +
        ".article-tech__info__title {" +
        "font-weight: bold;" +
        "font-size: 22px;" +
        "}" +
        ".article-tech__info__content__key {" +
        "font-size: 17px;" +
        "margin-left: 5px;" +
        "font-weight: bold;" +
        "}" +
        ".article-tech__info__content__value {" +
        "margin-left: 5px;" +
        "padding-left: 0;" +
        "float: none;" +
        "}" +
        "</style>";
  }
}
