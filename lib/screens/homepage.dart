import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task5/cubit/cubitstate.dart';
import 'package:task5/cubit/widgetstate.dart';
import 'package:task5/httpdata/getdata.dart';
import 'package:task5/httpdata/product.dart';
import 'package:task5/responsivesize/responsivedesign.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static List allproducts = [];
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String capitalize(String s) {
    return s.isEmpty ? s : s.replaceFirst(s[0], s[0].toUpperCase());
  }

  String capitalizeEachWord(String s) {
    return s.split(" ").map((word) => capitalize(word)).join(" ");
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    StdFontSize fontsize = StdFontSize(screenwidth: screenwidth);
    print(screenwidth);
    print(screenheight);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          screenheight / 11,
        ),
        child: Align(
          child: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'BigShop',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: fontsize.large,
                ),
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => HttpCubitState()..fetchdata(),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: screenheight / 30),
              width: double.infinity,
              height: screenheight,
              decoration: BoxDecoration(),
              child: BlocBuilder<HttpCubitState, FetchData>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Loaded) {
                    Homepage.allproducts = state.data!;
                    return ListView.builder(
                      itemCount: state.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero),
                              ),
                              context: context,
                              builder: (context) {
                                return ProductDescription(
                                  description:
                                      (state.data![index] as Product)
                                          .description!,
                                  fontSize: fontsize.medium,
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenwidth / 50,
                            ),
                            margin: EdgeInsets.only(top: screenheight / 30),
                            width: double.infinity,
                            height: screenheight / 11,
                            color: Color.fromRGBO(232, 255, 247, 1),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: screenwidth * 0.25,
                                    ),
                                    child: Image.network(
                                      GetData.BASE_URL +
                                          (state.data![index] as Product)
                                              .imageUrl!,
                                    ),
                                  ),
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        capitalizeEachWord(
                                          (state.data![index] as Product).name!,
                                        ),
                                        style: GoogleFonts.poppins(
                                          fontSize: fontsize.medium,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      RatingBarIndicator(
                                        rating:
                                            state.data![index].rating!
                                                .toDouble(),
                                        itemBuilder: (context, index) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        itemCount: 5,
                                        itemSize: 15.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "price: ",
                                            style: GoogleFonts.poppins(
                                              fontSize: fontsize.medium,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Stack(
                                            children: [
                                              Text(
                                                ((state.data![index] as Product)
                                                            .offer !=
                                                        null)
                                                    ? "${((state.data![index] as Product).price! * ((100 + (state.data![index] as Product).offer!) / 100)).toStringAsFixed(2)}\$"
                                                    : "${(state.data![index] as Product).price}\$",
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      0.8 * fontsize.medium,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              ((state.data![index] as Product)
                                                          .offer !=
                                                      null)
                                                  ? Positioned.fill(
                                                    child: CustomPaint(
                                                      painter:
                                                          StrikeThroughPainter(),
                                                    ),
                                                  )
                                                  : SizedBox.shrink(),
                                            ],
                                          ),
                                          ((state.data![index] as Product)
                                                      .offer !=
                                                  null)
                                              ? Padding(
                                                padding: EdgeInsets.only(
                                                  left: screenwidth / 50,
                                                ),
                                                child: Text(
                                                  "${(state.data![index] as Product).price}\$",
                                                  style: GoogleFonts.poppins(
                                                    fontSize:
                                                        0.8 * fontsize.medium,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                              : SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            "connection error",
                            style: GoogleFonts.poppins(
                              fontSize: fontsize.large,
                            ),
                          ),
                           ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Color.fromRGBO(94, 207, 202, 0.753),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<HttpCubitState>(context)
                                      .fetchdata();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Retry",
                                  style: GoogleFonts.poppins(
                                    fontSize: fontsize.large,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment(0.9, 0.9),
              child: FloatingActionButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchScreen());
                },
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                child: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StrikeThroughPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.red
          ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.7),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ProductDescription extends StatelessWidget {
  final String description;
  final double fontSize;
  const ProductDescription({
    super.key,
    required this.description,
    required this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(description, style: GoogleFonts.poppins(fontSize: fontSize)),
          ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Color.fromRGBO(94, 207, 202, 0.753),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "BUY",
                                  style: GoogleFonts.poppins(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                                ),
                              ),
        ],
      ),
    );
  }
}

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    StdFontSize fontsize = StdFontSize(screenwidth: screenwidth);
    List results =
        Homepage.allproducts.where((product) {
          return (product as Product).name!.toLowerCase().contains(
            query.toLowerCase(),
          );
        }).toList();
    print(results.length);
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: screenheight / 20,
                      maxWidth: screenwidth / 5,
                    ),
                    child: Image.network(
                      GetData.BASE_URL + (results[index] as Product).imageUrl!,
                    ),
                  ),
                  Text((results[index] as Product).name!),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(232, 255, 247, 1),
                        ),
                        width: screenwidth * 0.7,
                        height: screenheight / 3,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(-0.95, 0),
                              child: SizedBox(
                                width: screenwidth * 0.25,
                                child: Image.network(
                                  GetData.BASE_URL +
                                      (results[index] as Product).imageUrl!,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, -1),
                              child: Text(
                                (results[index] as Product).category!,
                                style: GoogleFonts.poppins(
                                  fontSize: fontsize.large,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    (results[index] as Product).name!,
                                    style: GoogleFonts.poppins(
                                      fontSize: fontsize.medium,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenheight / 20,
                                    ),
                                    child: Text(
                                      "price:${(results[index] as Product).price}\$",
                                      style: GoogleFonts.poppins(
                                        fontSize: fontsize.medium,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(0,0.9),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Color.fromRGBO(94, 207, 202, 0.753),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "BUY",
                                  style: GoogleFonts.poppins(
                                    fontSize: fontsize.large,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions =
        Homepage.allproducts.where((product) {
          return (product as Product).name!.toLowerCase().contains(
            query.toLowerCase(),
          );
        }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text((suggestions[index] as Product).name!),
              onTap: () {
                query = (suggestions[index] as Product).name!;
                showResults(context);
              },
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
