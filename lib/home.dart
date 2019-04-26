import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:everyday_quotes/quotation.dart';
import 'package:flutter/services.dart';
import 'package:flushbar/flushbar.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Quotation quote;
  String quoteText = "";
  String url = 'https://favqs.com/api/qotd';

  void copyQuote(BuildContext context) {
    var data = new ClipboardData(text: quoteText);
    Clipboard.setData(data);
    var flushbar = new Flushbar(
      message: "Copied to clipboard!",
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Color(0xFF27ae60),
    );

    flushbar.show(context);
  }

  void shareQuote(String quote) {
    Share.share(quote);
  }

  Future<void> fetchQuote() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      quote = Quotation.fromJson(json.decode(response.body));
      setState(() {
        quoteText = quote.quote;
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
        elevation: 0.0,
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
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
            ),
            Expanded(
              child: new Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                color: Colors.white24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RawMaterialButton(
                      shape: CircleBorder(),
                      onPressed: fetchQuote,
                      fillColor: new Color(0xFF2ecc71),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(Icons.library_add, color: Colors.white,),
                      ),
                    ),
                    new RawMaterialButton(
                      shape: CircleBorder(),
                      onPressed: () => copyQuote(context),
                      fillColor: new Color(0xFF2ecc71),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Icon(Icons.content_copy, color: Colors.white,),
                      ),
                    ),
                    new RawMaterialButton(
                      shape: CircleBorder(),
                      onPressed: () => shareQuote(quoteText),
                      fillColor: new Color(0xFF2ecc71),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}