import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_digital/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/user_model.dart';

final String font = 'Glory-Bold';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var user =
                snapshot.data!.docs.map((e) => Users.fromSnapshot(e)).toList();
            return Scaffold(
              body: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 400,
                            color: Colors.orange,
                            //margin: EdgeInsets.only(top: 15),
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                'E-Library',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40.0,
                                  fontFamily: font,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 250,
                            // margin: EdgeInsets.only(top: 15),
                            color: Colors.orange,
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 80, right: 80, bottom: 10),
                              height: 80,
                              width: 10,
                              child: ClipOval(
                                child: Image(
                                    image: AssetImage('assets/images/Adib.jpg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 100,
                            // margin: EdgeInsets.only(top: 50),
                            color: Colors.orange,
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                user[index].username,
                                style: TextStyle(
                                    fontFamily: "Glory-Bold", fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              top: 15,
                              right: 20,
                            ),
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.person,
                                      color: Color.fromRGBO(1, 180, 220, 1)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    user[index].username,
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 80),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              top: 15,
                              right: 20,
                            ),
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.email_outlined,
                                      color: Color.fromRGBO(1, 180, 220, 1)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    user[index].email,
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 80),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              top: 15,
                              right: 20,
                            ),
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Icon(Icons.lock,
                                      color: Color.fromRGBO(1, 180, 220, 1)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    user[index].password,
                                    style: TextStyle(
                                      fontFamily: font,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 0, 0, 80),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 50, thickness: 2),
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            height: 45,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                logout(context);
                              },
                              child: Text(
                                "Keluar",
                                style: TextStyle(
                                  fontFamily: "Baloo 2",
                                  fontSize: 20,
                                  color: Color.fromRGBO(0, 0, 0, 80),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Build By ",
                                style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "E-Library",
                                style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: user.length),
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

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}

// Widget _drawerHeader() {
//   return Container(
//     alignment: Alignment.topCenter,
//     margin: EdgeInsets.only(top: 70),
//     child: Column(
//       children: [
        
//       ],
//     ),
//   );
// }

// Widget _drawerItem({
//   required IconData icon,
// }) {
//   return Container(
//     child: 
//   );
// }
