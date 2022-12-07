import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elibrary_digital/auth/component/accountcheck.dart';
import 'package:elibrary_digital/auth/component/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_digital/pages/home.dart';
import 'package:elibrary_digital/auth/login.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // editing Controller
  final usernameeditController = new TextEditingController();
  final emaileditController = new TextEditingController();
  final passwordeditController = new TextEditingController();
  //final confirmPasswordEditingController = new TextEditingController();

  // our form key
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  bool _checkBoxVal = false;
  void _toggle() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;
    });
  }

  int index = 0;
  final String font = 'Glory-Bold';

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 80, bottom: 36),
              child: Text(
                "E-LIBRARY",
                style: TextStyle(
                    fontFamily: "Glory-Bold",
                    fontWeight: FontWeight.w600,
                    fontSize: 35),
              )),
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
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 19),
            child: Text(
              "Register",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Silahkan Masukkan Email, Username dan Password Anda",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 37, top: 39, bottom: 36, right: 37),
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: emaileditController,
                    style: TextStyle(fontFamily: "Glory-Bold"),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontFamily: "Glory-Bold",
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emaileditController.text = value!;
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: usernameeditController,
                    style: TextStyle(fontFamily: "Glory-Bold"),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        fontFamily: "Glory-Bold",
                      ),
                    ),
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("Username cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      usernameeditController.text = value!;
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: passwordeditController,
                    style: TextStyle(fontFamily: "Glory-Bold"),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: "Glory-Bold"),
                    ),
                    validator: (value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                    },
                    onSaved: (value) {
                      passwordeditController.text = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.only(left: 37, right: 37),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: Text(
                "Daftar",
                style: TextStyle(fontFamily: "Glory-Bold", fontSize: 20),
              ),
              onPressed: () {
                signUp(emaileditController.text, passwordeditController.text);
              },
            ),
          ),
          const SizedBox(height: 20),
          AccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Powered By E-Library Team",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential myUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //     .then((value) => {postDetailsToFirestore()})
        //     .catchError((e) {
        //   Fluttertoast.showToast(msg: e!.message);
        // });
        await myUser.user!.sendEmailVerification();
        Get.defaultDialog(
            title: "Email Verifikasi",
            middleText: "Kami telah mengirimkan email verifikasi ke $email",
            onConfirm: () {
              postDetailsToFirestore();
              Get.back();
              Get.back();
            },
            textConfirm: "Ya saya akan cek email");
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    // UserModel userModel = UserModel();

    // writing all the values

    //userModel.uid = user?.uid;

    // userModel.uid = user?.uid;

    // userModel.username = usernameeditController.text;
    // userModel.email = user!.email;

    // userModel.password = passwordeditController.text;

    // await firebaseFirestore
    //     .collection("users")
    //     .doc(user.uid)
    //     .set(userModel.toMap());
    // Fluttertoast.showToast(msg: "Account created successfully :) ");

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //     (route) => false);
  }
}
