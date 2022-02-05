import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:design_project_loginpage/screen/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late String _email;
  late String _password;

  final FirebaseAuth auth = FirebaseAuth.instance;

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

      final User? user = auth.currentUser;
      final uid = user!.uid;
      print(uid);
    }on FirebaseAuthException catch (e) {
      //print("Error: $e");
    }catch (e){
      print("Error: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              //fit: BoxFit.cover,
              width: 200.0,
              height: 130.0,
              scale: 1,),

            Image.asset(
              'assets/images/covid19band.png',
              //fit: BoxFit.cover,
              width: 300.0,
              height: 100.0,
              scale: 1,),

            SizedBox(height: 1,),


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
                obscureText: true,
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


            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: _login,
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    //fit: BoxFit.cover,
                    width: 280.0,
                    height: 80.0,
                    scale: 1,),
                ),
                FlatButton(
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => sign_up(),
                    )
                    );
                  } ,
                  //_createUser,
                  child: Image.asset(
                    'assets/images/image_1.png',
                    //fit: BoxFit.cover,
                    width: 280.0,
                    height: 80.0,
                    scale: 1,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
