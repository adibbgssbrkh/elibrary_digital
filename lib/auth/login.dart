import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elibrary_digital/pages/home.dart';
import 'package:elibrary_digital/auth/register.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextEditingController user = TextEditingController();
  // TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController user = new TextEditingController();
  final TextEditingController pass = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  String? errorMessage;

  // List<Widget> widgets = [];
  // _Login() {}

  // Future Login() async {
  //   var url = Uri.http("192.168.1.14", '/login/login.php', {'q': '{http}'});
  //   var response = await http.post(url, body: {
  //     "username": user.text,
  //     "password": pass.text,
  //   });
  //   var data = json.decode(response.body);
  //   if (data.toString() == "Succes") {
  //     Fluttertoast.showToast(
  //       msg: 'Login Successful',
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Home(),
  //       ),
  //     );
  //   } else {
  //     Fluttertoast.showToast(
  //       msg: 'Username and password invalid',
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       toastLength: Toast.LENGTH_SHORT,
  //     );
  //   }
  // }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.center,
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
            alignment: Alignment.center,
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
              "Log In",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 30),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Silahkan Masukkan Username dan Password Anda",
              style: TextStyle(fontFamily: "Glory-Bold", fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 37, top: 39, bottom: 36, right: 37),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //username
                  Container(
                    child: TextFormField(
                      controller: user,
                      decoration: InputDecoration(
                        labelText: 'Username',
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
                        user.text = value!;
                      },
                    ),
                  ),
                  //password
                  Container(
                    child: TextFormField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontFamily: "Glory-Bold"),
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 45, maxWidth: 46),
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                              size: 22,
                            ),
                          )),
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for login");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Enter Valid Password(Min. 6 Character)");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        pass.text = value!;
                      },
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Belum punya akun?",
                            style: TextStyle(fontFamily: "Glory-Bold"),
                          ),
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Register();
                                  },
                                ));
                              },
                              child: Text(
                                "Daftar",
                                style: TextStyle(fontFamily: "Glory-Bold"),
                              )),
                        )
                      ])
                ],
              ),
            ),
          ),
          Container(
            width: 300,
            height: 50,
            margin: EdgeInsets.only(right: 37, left: 37),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: Text(
                "Log In",
                style: TextStyle(fontFamily: "Glory-Bold", fontSize: 20),
              ),
              onPressed: () {
                signIn(user.text, pass.text);
              },
            ),
          ),
          SizedBox(
            height: 45,
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

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home())),
                });
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
}
