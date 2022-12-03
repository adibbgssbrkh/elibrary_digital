import 'package:elibrary_digital/auth/login.dart';
import 'package:elibrary_digital/pages/home.dart';
import 'package:elibrary_digital/pages/splashscreen.dart';
import 'package:elibrary_digital/restapi/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseAuth _auth = FirebaseAuth.instance;
Stream<User?> get streamAuthStatus => _auth.authStateChanges();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data);
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.data != null && snapshot.data!.emailVerified == true
                ? Home()
                : Login(),
            //initialRoute: snapshot.data != null ? const Home() : const Login1(),
          );
        }
        return Loading();
      },
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, child) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }
