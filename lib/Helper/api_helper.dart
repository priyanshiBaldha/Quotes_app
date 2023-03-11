import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/global.dart';
import '../Model/quotes_data.dart';

class QuoteAPIHelper {
  QuoteAPIHelper._();
  static final QuoteAPIHelper quoteAPIHelper = QuoteAPIHelper._();

  Future fetchRandomQuote() async {

    List<Quotes> quote = [];

    for (int i = 0; i < 10; i++) {
      http.Response res =
      await http.get(Uri.parse("https://api.quotable.io/random"));

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);

        Quotes randomQuote = Quotes.fromMap(data: data);

        quote.add(randomQuote);
      }
    }

    for (int i = 0; i < 100; i++) {
      Map<String, dynamic> demo = {
        "image":
        "https://source.unsplash.com/random/${i + 1}?background,love,dark",
        "id": i,
      };

      Globle.imagesRendom.add(demo);
    }
    Globle.quotesCategory = quote;
    return quote;
  }

  Future fetchQuotes() async {
    http.Response res =
    await http.get(Uri.parse("https://api.quotable.io/quotes"),);

    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);

      List results = data["results"];

      List<Quotes> quotesAll =
      results.map((e) => Quotes.fromMap(data: e)).toList();

      Globle.authoresList = quotesAll;

      return quotesAll;
    }
  }
}