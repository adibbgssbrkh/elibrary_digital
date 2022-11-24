import 'package:elibrary_digital/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_digital/auth/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80, bottom: 36, left: 37, right: 37),
            child: Text(
              "Selamat Datang di E-LIBRARY",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 300,
            height: 200,
            margin: EdgeInsets.only(bottom: 37),
            child: Image(
              image: AssetImage("assets/images/splash01.png"),
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.only(top: 150),
            child: Text(
              "Aplikasi yang membantu anda dalam mencari ilmu dan bahan bacaan lainnya",
              style: TextStyle(
                fontFamily: "Glory-Bold",
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.only(top: 34),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: Text(
                "Masuk",
                style: TextStyle(fontFamily: "Glory-Bold", fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ));
              },
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            child: Text(
              "Powered By E-Library Team",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
