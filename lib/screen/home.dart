import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:design_project_loginpage/screen/edit_contact.dart';
import 'package:design_project_loginpage/screen/add_contacts.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController status = TextEditingController();
  TextEditingController value = TextEditingController();
  final fbda = FirebaseDatabase(
          databaseURL:
              "https://fir-flutterlogin-bfc07-default-rtdb.asia-southeast1.firebasedatabase.app")
      .ref();

  late Query _ref;
  late Query _ref2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_idController = TextEditingController();
    //_distanceController = TextEditingController();
    _ref = fbda.child('hand_band').orderByChild('id');
    _ref2 = fbda.child('hand_band_beacon').orderByChild('inzone');
  }

  Widget _buildItem({required Map contact}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:  BoxFit.fill,
            image: AssetImage('assets/images/rectangle5.png'),
          ),
          //borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        //color: Colors.blue[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(

              width: 500,
              height: 100,
              child:
              Container(
                padding: EdgeInsets.only(left: 9.0),
                child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        contact['key'],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                      Row(
                        children: [
                          Text(
                            "Distance: ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            contact['distance'],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "meter",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "Status : ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            contact['status'],
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditContact(
                                        contactKey: contact['key'],
                                      )));
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text('Edit',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDeleteDialog(contact: contact);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red[700],
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text('Delete',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red[700],
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
              )
            )
          ],
        ));
  }

  Widget _buildWarning({required Map warning}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit:  BoxFit.fill,
            image: AssetImage('assets/images/rectangleRed.png'),
          ),
        ),

        //color: Colors.blue[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              //borderRadius: BorderRadius.all(Radius.circular(20)),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    warning['key'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(width: 10,),
                  Text(
                    "is missing",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10,
                  ),

                ],
              ),

            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final ref = fbda.child('hand_band_distance');

    return Scaffold(
      backgroundColor: Colors.blue[100],
      /*appBar: AppBar(
        title: Text("Hand Band settings"),
      ),*/
      body: Column(
        children: [
          Column(
            children: [

              SizedBox(height: 50,),

              Container(
                height: 340,
                child: FirebaseAnimatedList(
                  query: _ref,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map contact = snapshot.value as Map;
                    contact['key'] = snapshot.key;
                    return _buildItem(contact: contact);
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),

              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return AddContacts();
                    }),
                  );
                },
                child: Image.asset(
                  'assets/images/addnewdevice.png',
                  fit: BoxFit.fill,
                  width: 260.0,
                  height: 50.0,
                  scale: 1,),

              ),

              SizedBox(
                height: 100,
              ),

              Container(
                height: 300,
                alignment: Alignment.bottomCenter,
                child: FirebaseAnimatedList(
                  query: _ref2,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map warning = snapshot.value as Map;
                    warning['key'] = snapshot.key;

                    if (warning['inzone'] == 0){
                      return _buildWarning(warning: warning);
                    }else{
                      return Container(
                        child: Text('No Warning',
                          style: TextStyle(color: Colors.blue[100]),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              FlatButton(
                onPressed: _signOut,
                child: Image.asset(
                  'assets/images/logout.png',
                  fit: BoxFit.fill,
                  width: 260.0,
                  height: 50.0,
                  scale: 1,),
              ),

              SizedBox(width: 8,),
              /*ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      )
                  );
                },
                child: Text("Profile"),
              ),*/
            ],
          )
        ],
      ),
    );
  }

  Widget buildInsertButton() => ElevatedButton(
        onPressed: () {},
        child: Text(
          'Insert New Device',
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600),
        ),
      );

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  _showDeleteDialog({required Map contact}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${contact['id']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () {
                    fbda
                        .child('hand_band')
                        .child(contact['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }
}
