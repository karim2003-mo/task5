import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task5/httpdata/getdata.dart';
import 'package:task5/httpdata/product.dart';
import 'package:task5/responsivesize/responsivedesign.dart';
import 'package:task5/screens/homepage.dart';
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
                              alignment: Alignment(0, 0.9),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromRGBO(
                                    94,
                                    207,
                                    202,
                                    0.753,
                                  ),
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
                                    color: Colors.white,
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
