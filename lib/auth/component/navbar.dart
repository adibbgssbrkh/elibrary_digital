import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_digital/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'user_model.dart';

final String font = 'Glory-Bold';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  // UserModel loggedInUser = UserModel();

  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // _drawerHeader(),
          // const SizedBox(height: 15),
          // _drawerItem(
          //   icon: Icons.alternate_email,
          //   text: "${loggedInUser.email}",
          // ),
          // _drawerItem(
          //   icon: Icons.alternate_email,
          //   text: '${loggedInUser.username}',
          // ),
          Divider(height: 50, thickness: 2),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
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
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}

Widget _drawerHeader() {
  return Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.only(top: 70),
    child: Column(
      children: [
        Container(
          //margin: EdgeInsets.only(top: 15),
          child: Text(
            'E-Library',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
              fontFamily: font,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: 90,
          width: 90,
          child: ClipOval(
              // child: Image(
              //     image: NetworkImage(FirebaseAuth.instance.currentUser?.),
              //     fit: BoxFit.cover),

              ),
        ),
      ],
    ),
  );
}

Widget _drawerItem({
  required IconData icon,
  required String text,
}) {
  return Container(
    child: Container(
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
            child: Icon(icon, color: Color.fromRGBO(1, 180, 220, 1)),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              text,
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
  );
}
