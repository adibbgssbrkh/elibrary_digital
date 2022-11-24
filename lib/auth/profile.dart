import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_digital/pages/home.dart';
import 'package:elibrary_digital/auth/login.dart';
import 'package:elibrary_digital/main.dart';
import 'package:dialog_alert/dialog_alert.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
        children: <Widget>[
          Container(
            width: 400,
            height: 300,
            color: Colors.orange,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 65, top: 5),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ));
                          },
                          icon: Icon(Icons.arrow_back_rounded),
                          iconSize: 35,
                        ),
                      ),
                      Container(
                        child: Text(
                          "E-LIBRARY",
                          style:
                              TextStyle(fontFamily: "Glory-Bold", fontSize: 30),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person_outlined),
                    iconSize: 150,
                  ),
                ),
                Container(
                    child: Text(
                  "Nama Pengguna",
                  style: TextStyle(fontFamily: "Glory-Bold", fontSize: 20),
                ))
              ],
            ),
          ),
          Container(
            height: 600,
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Container(
                  width: 350,
                  height: 550,
                  margin: EdgeInsets.only(top: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 350,
                        height: 20,
                        color: Colors.orange,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 70, left: 20),
                              child: Text(
                                "Username",
                                style: TextStyle(
                                    fontFamily: "Glory-Bold", fontSize: 20),
                              ),
                            ),
                            Container(
                              child: Text(
                                "Username Pengguna",
                                style: TextStyle(
                                    fontFamily: "Glory-Bold", fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 70),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    fontFamily: "Glory-Bold", fontSize: 20),
                              ),
                            ),
                            Container(
                              child: Text(
                                "@@@@@@@@@",
                                style: TextStyle(
                                    fontFamily: "Glory-Bold", fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 50),
                        child: Text(
                          "Deskripsi",
                          style:
                              TextStyle(fontFamily: "Glory-Bold", fontSize: 20),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                          child: TextField()),
                      Container(
                        width: 300,
                        height: 50,
                        margin: EdgeInsets.only(top: 100, left: 25),
                        child: ElevatedButton(
                            onPressed: () async {
                              final result = await showDialogAlert(
                                  context: context,
                                  title: "Log Out",
                                  message: "Apakah anda yakin ingin Log out ?",
                                  actionButtonTitle: "Ya",
                                  cancelButtonTitle: "Tidak");
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) {
                              //     return Login();
                              //   },
                              // ));
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange),
                            child: Text(
                              "Log Out",
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
