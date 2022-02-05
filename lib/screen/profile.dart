import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:design_project_loginpage/screen/edit_contact.dart';
import 'package:design_project_loginpage/screen/add_contacts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<Profile> {
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
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: 20,),

                  Image.asset(
                    'assets/images/Profile.png',
                    width: 200.0,
                    height: 50.0,
                    scale: 1,
                  ),

                  //first box image and personal information
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit:  BoxFit.fitWidth,
                        image: AssetImage('assets/images/rectangle5.png'),
                      ),

                    ),
                    width: 300,
                    height: 100,
                    child:
                    Row(
                      children: [
                        Container(
                          width: 140,
                          height: 100,
                          child: Image.asset('assets/images/logo1.png'),
                        ),
                        Container(
                          width: 140,
                          height: 100,
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Adriana Ahmad'),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('57083101577'),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Sabah'),
                              ),
                              SizedBox(height: 5,),
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('QUARANTINE'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  //band status
                  Container(
                      decoration: BoxDecoration(
                          /*border: Border.all(
                            //color: Colors.grey[500],
                          ),*/
                        image: DecorationImage(
                          fit:  BoxFit.fitWidth,
                          image: AssetImage('assets/images/rectangle10.png'),
                        ),
                          //borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    width: 300,
                    height: 20,
                    child: Row(
                      children: [
                        SizedBox(width: 15,),
                        Text('Band Status:',
                        )
                      ],
                    )
                  ),


                  SizedBox(
                    height: 5,
                  ),


                  //Days Left (if in quarantine)
                  Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit:  BoxFit.fitWidth,
                          image: AssetImage('assets/images/rec6.png'),
                        ),
                      ),
                      width: 300,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Days Left'),
                          SizedBox(width: 15,),

                          Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit:  BoxFit.fitWidth,
                                  image: AssetImage('assets/images/ellipse2.png'),
                                ),
                                //borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              width: 40,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('5'),
                                ],
                              )
                          ),
                        ],
                      )
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit:  BoxFit.fitWidth,
                        image: AssetImage('assets/images/rec8.png'),
                      ),
                      //borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    width: 300,
                    height: 150,
                    child: Column(
                      children: [
                        Text('DAILY REPORT:'),
                        Text('DAILY REPORT:'),
                        Text('DAILY REPORT:'),
                        Text('DAILY REPORT:'),
                        Text('DAILY REPORT:'),
                        Text('DAILY REPORT:'),
                      ],
                    ),
                  ),

                  Image.asset(
                    'assets/images/logo1.png',
                    width: 200.0,
                    height: 130.0,
                    scale: 1.5,
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
