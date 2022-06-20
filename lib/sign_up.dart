import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:student_wallet/login_page.dart';

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
              return const Signup();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //login Function
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
    //create the textfield controller
    TextEditingController _namecontroller = TextEditingController();
    TextEditingController _surnamecontroller = TextEditingController();
    TextEditingController _idnumbercontroller = TextEditingController();
    TextEditingController _studentnumbercontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SignUp',
            style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          const Text("SignUp your Account",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 44,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 44),
          TextField(
              controller: _namecontroller,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 26),
          TextField(
              controller: _surnamecontroller,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: "Surname",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 26),
          TextField(
              controller: _idnumbercontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "ID Number",
                prefixIcon: Icon(
                  Icons.numbers,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 26),
          TextField(
              controller: _studentnumbercontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Student Number",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 26),
          TextField(
              controller: _passwordcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 88),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
                onPressed: () async {
                  User? user = await loginUsingEmailPassword(
                      email: _namecontroller.text,
                      password: _passwordcontroller.text,
                      context: context);
                  print(user);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  }
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ],
      ),
    );
  }
}
