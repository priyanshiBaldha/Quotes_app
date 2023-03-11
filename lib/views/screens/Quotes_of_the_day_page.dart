import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/global.dart';

class Quotes_of_the_day_page extends StatefulWidget {
  const Quotes_of_the_day_page({Key? key}) : super(key: key);

  @override
  State<Quotes_of_the_day_page> createState() => _Quotes_of_the_day_pageState();
}

class _Quotes_of_the_day_pageState extends State<Quotes_of_the_day_page> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes of the Day"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemCount: Globle.quotesCategory.length,
        separatorBuilder: (context, i) => const SizedBox(height: 25),
        itemBuilder: (context, i) {
          return Container(
            height: _height * 0.66,
            width: _width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            Globle.imagesRendom[Globle.imagesRendom[i]["id"]]
                            ["image"],
                          ),
                        )),
                    alignment: Alignment.center,
                    child: Text(
                      Globle.quotesCategory[i].content,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.brown,
                        ),
                        onPressed: () {
                          setState(() {
                            if (Globle.imagesRendom[i]["id"] <
                                Globle.imagesRendom.length - 5) {
                              Globle.imagesRendom[i]["id"] += 5;
                            } else {
                              Globle.imagesRendom[i]["id"] = 1;
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.copy_rounded,
                          color: Colors.blue.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.red.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.download,
                          color: Colors.green.shade800,
                          size: 30,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Globle.quotesCategory[i].favoriteCheck
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.blue,
                          size: 30,
                        ),
                        onPressed: () {
                          Globle.favoriteList
                              .add(Globle.quotesCategory[i].content);

                          for (int a = 0; a < Globle.favoriteList.length; a++) {
                            if (Globle.quotesCategory[i].content ==
                                Globle.favoriteList[a]) {
                              setState(() {
                                Globle.quotesCategory[i].favoriteCheck = true;
                              });
                            } else {
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
