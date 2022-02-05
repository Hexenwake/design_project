import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class sign_up extends StatefulWidget {
  const sign_up({Key? key}) : super(key: key);

  @override
  _signupstate createState() => _signupstate();
}

class _signupstate extends State<sign_up> {
  late String _email;
  late String _password;

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      print("user: $userCredential");
    } on FirebaseAuthException catch (e) {
      //print("Error: $e");
    } catch (e) {
      //_error = "Error: $e";
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/images/logo1.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/createaccount.png',
                    width: 200.0,
                    height: 130.0,
                    scale: 1,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Name",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Sex",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "I/C Number",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "State",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Phone Number",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Username",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      onChanged: (value) {
                        _email = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Password",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _password = value;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          hintText: "Confirm Password",
                          fillColor: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: _createUser,
                        child: Image.asset(
                          'assets/images/singupblack.png',
                          //fit: BoxFit.cover,
                          width: 280.0,
                          height: 50.0,
                          scale: 1,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo1.png',
                        width: 200.0,
                        height: 130.0,
                        scale: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
