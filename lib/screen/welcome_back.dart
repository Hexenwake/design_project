import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class wlc_back_page extends StatefulWidget {
  const wlc_back_page({Key? key}) : super(key: key);

  @override
  _wlc_page createState() => _wlc_page();
}

class _wlc_page extends State<wlc_back_page> {

  late String _email;
  late String _password;

  Future<void> _createUser() async {
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      print("user: $userCredential");
    }on FirebaseAuthException catch (e) {
      //print("Error: $e");
    }catch (e){
      //_error = "Error: $e";
      print("Error: $e");
    }
  }

  Future<void> _login() async {
    try{
      UserCredential userCredential = await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      print("user: $userCredential");
    }on FirebaseAuthException catch (e) {
      //print("Error: $e");
    }catch (e){
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/logo.png',
              //fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
              scale: 1,),

            SizedBox(height: 200,),

            Image.asset(
              'assets/images/welcomeback.png',
              //fit: BoxFit.cover,
              width: 200.0,
              height: 200.0,
              scale: 1,),
            SizedBox(height: 50,),

            Column(
              children: [

                Container(
                  width: 300,
                  height: 80,
                  child:  TextField(
                    onChanged: (value){
                      _email = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500],),
                        hintText: "Username/Email",
                        fillColor: Colors.white70),
                  ) ,
                ),

                Container(
                  width: 300,
                  height: 80,
                  child:  TextField(
                    onChanged: (value){
                      _password = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500],),
                        hintText: "Password",
                        fillColor: Colors.white70),
                  ) ,
                ),

                FlatButton(
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    //fit: BoxFit.cover,
                    width: 280.0,
                    height: 80.0,
                    scale: 1,),
                  onPressed: () {
                    _login;
                    Navigator.push(context,
                        MaterialPageRoute(
                        builder:(context) => LandingPage()
                    ));
                  },
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
