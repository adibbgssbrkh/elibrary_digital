import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_digital/auth/component/navbar.dart';
import 'package:elibrary_digital/pages/bookmodel.dart';
import 'package:elibrary_digital/pages/bookview.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_digital/pages/bookmark.dart';
import 'package:elibrary_digital/auth/login.dart';
import 'package:elibrary_digital/auth/profile.dart';
import 'package:easy_search_bar/easy_search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchValue = '';
  final List<String> _suggestions = [
    'API connection',
    'Albania',
    'Algeria',
    'Australia',
    'Brazil',
    'German',
    'Indonesia',
    'Madagascar',
    'Mozambique',
    'Portugal',
    'Zambia'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('book').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var book =
                snapshot.data!.docs.map((e) => Book.fromSnapshot(e)).toList();
            return Scaffold(
              appBar: EasySearchBar(
                  title: const Text('E-LIBRARY'),
                  backgroundColor: Colors.orange,
                  onSearch: (value) => setState(() => searchValue = value),
                  asyncSuggestions: (value) async =>
                      await _fetchSuggestions(value)),
              drawer: const DrawerWidget(),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 400,
                            height: 150,
                            // margin: EdgeInsets.only(bottom: 25),
                            color: Colors.orange,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          "E-LIBRARY",
                                          style: TextStyle(
                                              fontFamily: "Glory-Bold",
                                              fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 42),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 129),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.home),
                                          iconSize: 35,
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Bookamark();
                                            }));
                                          },
                                          icon: Icon(Icons.bookmark_border),
                                          iconSize: 35,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 800,
                            color: Colors.grey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        height: 360,
                                        color: Colors.white,
                                        margin:
                                            EdgeInsets.only(top: 25, left: 24),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                height: 204,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                        book[index].image)
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                  left: 5,
                                                  top: 4,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 10),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return Bookview();
                                                        }));
                                                      },
                                                      child: Text(
                                                          book[index].judul),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].author,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Glory-Bold",
                                                            fontSize: 11,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].halaman,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Glory-Bold",
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            // child: LikeButton(
                                                            //   size: 30,
                                                            //   circleColor: CircleColor(
                                                            //       start: Color(0xff00ddff),
                                                            //       end: Color(0xff0099cc)),
                                                            //   bubblesColor: BubblesColor(
                                                            //     dotPrimaryColor:
                                                            //         Color(0xff33b5e5),
                                                            //     dotSecondaryColor:
                                                            //         Color(0xff0099cc),
                                                            //   ),
                                                            //   likeBuilder: (bool isLiked) {
                                                            //     return Icon(
                                                            //       Icons.home,
                                                            //       color: isLiked
                                                            //           ? Colors
                                                            //               .deepPurpleAccent
                                                            //           : Colors.grey,
                                                            //       size: 30,
                                                            //     );
                                                            //   },
                                                            //   likeCount: 665,
                                                            //   countBuilder: (int count,
                                                            //       bool isLiked, String text) {
                                                            //     var color = isLiked
                                                            //         ? Colors.deepPurpleAccent
                                                            //         : Colors.grey;
                                                            //     Widget result;
                                                            //     if (count == 0) {
                                                            //       result = Text(
                                                            //         "love",
                                                            //         style: TextStyle(
                                                            //             color: color),
                                                            //       );
                                                            //     } else
                                                            //       result = Text(
                                                            //         text,
                                                            //         style: TextStyle(
                                                            //             color: color),
                                                            //       );
                                                            //     return result;
                                                            //   },
                                                            // ),
                                                            // LikeButton(
                                                            //   onTap: onLikeButtonTapped,
                                                            // ),
                                                            // Future<bool> onLikeButtonTapped(bool isLiked) async{
                                                            //   /// send your request here
                                                            //   // final bool success= await sendRequest();

                                                            //   /// if failed, you can do nothing
                                                            //   // return success? !isLiked:isLiked;

                                                            //   return !isLiked;
                                                            // }
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .favorite_border),
                                                              iconSize: 30,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: Text(
                                                              "495",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Glory-Bold",
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .bookmark_border),
                                                              iconSize: 30,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        )),
                                    Container(
                                        width: 150,
                                        height: 360,
                                        color: Colors.white,
                                        margin: EdgeInsets.only(
                                          top: 25,
                                          left: 40,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                height: 204,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                        book[index].image2)
                                                  ],
                                                )),
                                            Container(
                                                margin: EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 10),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return Bookview();
                                                        }));
                                                      },
                                                      child: Text(
                                                          book[index].judul2),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].author2,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Glory-Bold",
                                                            fontSize: 11,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].halaman2,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Glory-Bold",
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .favorite_border),
                                                              iconSize: 30,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: Text(
                                                              "495",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Glory-Bold",
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .bookmark_border),
                                                              iconSize: 30,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ))
                                  ],
                                )),
                                Container(
                                    child: Row(
                                  children: <Widget>[
                                    Container(
                                        width: 150,
                                        height: 360,
                                        color: Colors.white,
                                        margin:
                                            EdgeInsets.only(top: 25, left: 24),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                height: 215,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                        book[index].image3)
                                                  ],
                                                )),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 7),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 10),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return Bookview();
                                                        }));
                                                      },
                                                      child: Text(
                                                          book[index].judul3),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].author3,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Glory-Bold",
                                                            fontSize: 11,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].halaman3,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Glory-Bold",
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 3),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .favorite_border),
                                                              iconSize: 30,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: Text(
                                                              "495",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Glory-Bold",
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .bookmark_border),
                                                              iconSize: 30,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        )),
                                    Container(
                                        width: 150,
                                        height: 360,
                                        color: Colors.white,
                                        margin: EdgeInsets.only(
                                          top: 25,
                                          left: 40,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                width: 150,
                                                height: 205,
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                        book[index].image4)
                                                  ],
                                                )),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 7),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 10),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return Bookview();
                                                        }));
                                                      },
                                                      child: Text(
                                                          book[index].judul4),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].author4,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Glory-Bold",
                                                            fontSize: 11,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5, left: 7),
                                                      child: Text(
                                                        book[index].halaman4,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Glory-Bold",
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .favorite_border),
                                                              iconSize: 30,
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 15),
                                                            child: Text(
                                                              "495",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Glory-Bold",
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(Icons
                                                                  .bookmark_border),
                                                              iconSize: 30,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ))
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: book.length),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              value: 0.20,
            ),
          );
        });
  }
}

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
      
//   }
// }
