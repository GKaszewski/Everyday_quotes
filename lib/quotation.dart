import 'package:html/parser.dart';
import 'dart:convert';

class Quotation{
  final int id;
  final String title;
  final String content;
  final String link;
  final String actualQuote;

  Quotation({this.id, this.title, this.content, this.link, this.actualQuote});

  factory Quotation.fromJson(List<dynamic> json){
    var document = parse(json[0]['content']);
    String rawQuote = parse(document.body.text).documentElement.text;
    var authorRaw = utf8.encode(json[0]["title"]);
    var author = utf8.decode(authorRaw);
    return Quotation(
      id: json[0]['ID'],
      title: json[0]['title'],
      content: json[0]['content'],
      link: json[0]['link'],
      actualQuote: '\t$author\n\n$rawQuote',
    );
  }

 
} 