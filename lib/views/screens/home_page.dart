import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Helper/api_helper.dart';
import '../../Model/global.dart';
import '../../Model/quotes_data.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<dynamic> api;

  @override
  void initState() {
    super.initState();
    api = QuoteAPIHelper.quoteAPIHelper.fetchRandomQuote();
    QuoteAPIHelper.quoteAPIHelper.fetchQuotes();
  }

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Life Quotes and ...",
          style: GoogleFonts.habibi(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notification_add),
                color: Colors.amber,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pushNamed("Favorite_Page");
                },
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        width: _width * 0.77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
               color: Colors.blueGrey
              ),
              alignment: Alignment.center,
              child: Text(
                "Life Quotes and Sayings",
                textAlign: TextAlign.center,
                style: GoogleFonts.abel(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
            drawerItems(
              name: "By Topic",
              color: Colors.purple,
              icon: const Icon(Icons.topic),
            ),
            drawerItems(
              name: "By Auther",
              color: Colors.red,
              icon: const Icon(Icons.people_alt),
            ),
            drawerItems(
              name: "Favourites",
              color: Colors.amber,
              icon: const Icon(Icons.star),
            ),
            drawerItems(
              name: "Quotes of the day",
              color: Colors.red,
              icon: const Icon(Icons.bubble_chart),
            ),
            drawerItems(
              name: "Favourite Pictures",
              color: Colors.amber,
              icon: const Icon(Icons.star),
            ),
            drawerItems(
              name: "Videos",
              color: Colors.red,
              icon: const Icon(Icons.videocam_sharp),
            ),
            Divider(
              color: Colors.black.withOpacity(0.2),
              height: 40,
              thickness: 2,
            ),
            Text(
              "    Communicate",
              style: GoogleFonts.habibi(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            drawerItems(
              name: "Settings",
              color: Colors.black,
              icon: const Icon(Icons.settings),
            ),
            drawerItems(
              name: "Share",
              color: Colors.black,
              icon: const Icon(Icons.share),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: api,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR : ${snapshot.error}");
          } else if (snapshot.hasData) {
            List<Quotes> data = snapshot.data;

            List slider = [
              Globle.imagesRendom[1]["image"],
              Globle.imagesRendom[2]["image"],
              Globle.imagesRendom[3]["image"],
              Globle.imagesRendom[4]["image"],
              Globle.imagesRendom[5]["image"],
            ];

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration:
                    const Duration(milliseconds: 700),
                    autoPlayCurve: Curves.easeInOut,
                    autoPlayInterval: const Duration(seconds: 10),
                    scrollPhysics: const BouncingScrollPhysics(),
                    viewportFraction: 0.97,
                    initialPage: currentindex,
                    onPageChanged: (val, _) {
                      setState(() {
                        currentindex = val;
                      });
                    },
                    enlargeCenterPage: true,
                  ),
                  items: slider.map((i) {
                    int index = slider.indexOf(i);

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(i),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 270,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Text(
                                  Globle.quotesCategory[index].content,
                                  textAlign: TextAlign.center,
                                  maxLines: 4,
                                  style: GoogleFonts.habibi(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15,),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentindex,
                    count: 5,
                    effect: const SlideEffect(
                      dotColor: Colors.blueGrey,
                      activeDotColor: Colors.black,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Quotes_Description_Page");
                      },
                      child: SizedBox(
                        height: 70,
                        width: 85,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1),
                              ),
                              child: Icon(
                                Icons.category,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Category',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.habibi(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Quotes_Description_Page");
                      },
                      child: SizedBox(
                        height: 70,
                        width: 85,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1),
                              ),
                              child: Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Pick Quote',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.habibi(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Quotes_Description_Page");
                      },
                      child: SizedBox(
                        height: 70,
                        width: 85,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.pinkAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1),
                              ),
                              child: Icon(
                                Icons.article_outlined,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Article',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.habibi(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("Quotes_Description_Page");
                      },
                      child: SizedBox(
                        height: 70,
                        width: 85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.indigo.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 0.1),
                              ),
                              child: Icon(
                                Icons.open_in_new,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Latest',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.habibi(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Most Popluar Quotes
                Text(
                  "Most Popular",
                  style: GoogleFonts.habibi(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Sports Quotes", i: 1),
                    mostPopular(width: _width, name: "Learning Quotes", i: 2),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Love Quotes", i: 3),
                    mostPopular(width: _width, name: "Truth Quotes", i: 4),
                  ],
                ),
                const SizedBox(height: 20),
                // Categories By Quotes
                Row(
                  children: [
                    Text(
                      "Quotes By Category",
                      style: GoogleFonts.habibi(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("Category_Page");
                      },
                      child: Text(
                        "View All >",
                        style: TextStyle(
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(
                        width: _width, name: "Inspirational Quotes", i: 5),
                    mostPopular(width: _width, name: "Famous Quotes", i: 6),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    mostPopular(width: _width, name: "Wisdom Quotes", i: 7),
                    mostPopular(width: _width, name: "War Quotes", i: 8),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Quotes By Authors",
                      style: GoogleFonts.habibi(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("Authors_Page");
                      },
                      child: Text(
                        "View All >",
                        style: TextStyle(
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 400,
                  width: _width,
                  child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing:8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.9
                      ),
                      itemCount: 4,
                      itemBuilder: (context, i){
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("Quotes_Description_Page");
                            setState(() {
                              api = QuoteAPIHelper.quoteAPIHelper.fetchRandomQuote();
                            });
                          },
                          child: Container(
                            height: 190,
                            width: _width * 0.45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 0.5,
                                ),
                              ],
                            ),
                            child: Text(
                              Globle.authoresList[i].author,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.habibi(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  mostPopular({required double width, required String name, required int i}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed("Quotes_Description_Page");
            setState(() {
              api = QuoteAPIHelper.quoteAPIHelper.fetchRandomQuote();
            });
          },
          child: Container(
            height: 110,
            width: width * 0.45,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 0.5,
                ),
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Globle.imagesRendom[i]["image"]),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: GoogleFonts.habibi(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  drawerItems(
      {required String name, required Color color, required Icon icon}) {
    return InkWell(
      onTap: () {
        if (name == "By Topic") {
          Navigator.of(context).pushNamed("Category_Page");
        } else if (name == "By Auther") {
          Navigator.of(context).pushNamed("Authors_Page");
        } else if (name == "Favourites") {
          Navigator.of(context).pushNamed("Favorite_Page");
        }
        else if (name == "Quotes of the day") {
          Navigator.of(context).pushNamed("Quotes_of_the_day_page");
        }
      },
      child: Row(
        children: [
          IconButton(
            icon: icon,
            color: color,
            onPressed: () {},
          ),
          const SizedBox(width: 5),
          Text(
            name,
            style: GoogleFonts.habibi(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

}