import 'package:flutter/material.dart';
import 'quotation.dart';
import 'package:http/http.dart' as http;
import 'package:everyday_quotes/quotation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';

void main() {
  runApp(new EverydayQuotesApp());
}

class EverydayQuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Everyday quotes",
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Quotation quote;
  String quoteText = "";
  String url =
      'http://quotesondesign.com/wp-json/posts?filter[orderby]=rand&filter[posts_per_page]=1';

  void copyQuote(BuildContext context) {
    var data = new ClipboardData(text: quoteText);
    Clipboard.setData(data);
    var flushbar = new Flushbar(
      message: "Copied to clipboard!",
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
    );

    flushbar.show(context);
  }

  Future fetchQuote() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      quote = Quotation.fromJson(json.decode(response.body));
      setState(() {
        quoteText = quote.actualQuote;
      });
    } else
      throw Exception('Failed to load data...');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.8;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Everyday quotes"),
        backgroundColor: new Color(0xFF27ae60),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            new Text("Press a button below to get a quote."),
            new RaisedButton(
              onPressed: fetchQuote,
              textColor: Colors.white,
              color: new Color(0xFF27ae60),
              child: new Text("Get"),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
            ),
            new Container(
              width: screenWidth,
              child: new Column(
                children: <Widget>[
                  new Text(
                    quoteText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            new RaisedButton(
              onPressed: () => copyQuote(context),
              textColor: Colors.white,
              color: new Color(0xFF27ae60),
              child: new Text("Copy"),
            ),
          ],
        ),
      ),
    );
  }
}
