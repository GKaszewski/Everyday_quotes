import 'package:html/parser.dart';
import 'dart:convert';

class Quotation{
  final String quote;

  Quotation({this.quote});

  factory Quotation.fromJson(dynamic json){
    var doc = parse(json['quote']['body']);
    String rawQuote = parse(doc.body.text).documentElement.text;
    var authorRaw = utf8.encode(json['quote']['author']);
    var author = utf8.decode(authorRaw);
    return Quotation(
      quote: '\t$author\n\n$rawQuote',
    );
  }
} 