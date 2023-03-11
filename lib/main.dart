import 'package:flutter/material.dart';
import 'package:quotes_app/views/screens/Quotes_of_the_day_page.dart';
import 'package:quotes_app/views/screens/home_page.dart';
import 'package:quotes_app/views/screens/quotes_category_page.dart';
import 'package:quotes_app/views/screens/quotes_detail_page.dart';

void main() {
  runApp(
    MaterialApp(

      debugShowCheckedModeBanner: false,
      initialRoute: "Home_Page",
      routes: {
        "/": (context) => const Homepage(),
        "Quotes_Description_Page": (context) => const QuoteDetailPage(),
        "Category_Page": (context) => const Category_Page(),
        "Quotes_of_the_day_page": (context) => const Quotes_of_the_day_page(),
      },
    ),
  );
}