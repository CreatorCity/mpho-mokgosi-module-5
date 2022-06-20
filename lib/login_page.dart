import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_wallet/profile_edit.dart';
import 'package:student_wallet/sign_up.dart';
import 'dashboard.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _MyHomePageState(),
    );
  }
}

class _MyHomePageState extends StatefulWidget {
  const _MyHomePageState({Key? key}) : super(key: key);

  @override
  State<_MyHomePageState> createState() => __MyHomePageStateState();
}

class __MyHomePageStateState extends State<_MyHomePageState> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const LoginScreen();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 183.0, 0.0, 0.0),
                child: const Text('Student',
                    style:
                        TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                child: const Text('Welcome',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(260.0, 175.0, 0.0, 0.0),
                child: const Text('.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  obscureText: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Container(
            alignment: const Alignment(0.9, 0.0),
            padding: const EdgeInsets.only(top: 15.0, left: 20.0),
            child: const InkWell(
              child: Text(
                'Forgot password',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Container(
            height: 40.0,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.green,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () async {
                  User? user = await loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ProfileEdit()));
                  }
                },
                child: const Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            height: 40.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'New Student?',
                style: TextStyle(fontFamily: 'Montserret'),
              ),
              const SizedBox(width: 5.0),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ]));
  }
}
