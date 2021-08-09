import 'dart:async';

import 'package:flutter/material.dart';
import 'package:makangoagain/main.dart';
import 'package:makangoagain/session.dart';
import 'exceptions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vendor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  bool isHidden = false;
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String wrongcredentials = '';
  final vendorUsernames = {};
  final vendorPasswords = {};
  void getData() {
    FirebaseFirestore.instance
        .collection("vendorNames")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        vendorUsernames[result.data()['title']] = result.data()['username'];
        vendorPasswords[result.data()['title']] = result.data()['password'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff7a939f),
              automaticallyImplyLeading: false,
              title: Text(
                '\nPROJECT MAKANGO\n',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xffddf2ff),
                ),
              ),
            ),
            body: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    // Container(
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.all(10),
                    // ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: !isHidden,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _togglePasswordView(),
                            icon: Icon(isHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                    ),
                    RoundedLoadingButton(
                        child: Text('Login',
                            style: TextStyle(color: Color(0xffddf2ff))),
                        color: Color(0xff7a939f),
                        controller: _btnController1,
                        onPressed: () async {
                          if (nameController.text ==
                              vendorUsernames['Drinks']) {
                            if (passwordController.text ==
                                vendorPasswords['Drinks']) {
                              save('Drinks');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['ChickenRice']) {
                            if (passwordController.text ==
                                vendorPasswords['ChickenRice']) {
                              save('ChickenRice');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['EconomicRice']) {
                            if (passwordController.text ==
                                vendorPasswords['EconomicRice']) {
                              save('EconomicRice');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['JapKorean']) {
                            if (passwordController.text ==
                                vendorPasswords['JapKorean']) {
                              save('JapKorean');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['Muslim']) {
                            if (passwordController.text ==
                                vendorPasswords['Muslim']) {
                              save('Muslim');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['Noodles']) {
                            if (passwordController.text ==
                                vendorPasswords['Noodles']) {
                              save('Noodles');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['Pasta']) {
                            if (passwordController.text ==
                                vendorPasswords['Pasta']) {
                              save('Pasta');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['Spinach']) {
                            if (passwordController.text ==
                                vendorPasswords['Spinach']) {
                              save('Spinach');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          } else if (nameController.text ==
                              vendorUsernames['Western']) {
                            if (passwordController.text ==
                                vendorPasswords['Western']) {
                              save('Western');
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SummarisedOrders()));
                            }
                          }

                          try {
                            final session = await Session.create(
                                nameController.text,
                                passwordController
                                    .text); // program that might throw an exception
                            await save(nameController.text.toLowerCase());
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                          } on InvalidCredentialsException {
                            _btnController1.reset();
                            wrongcredentials = 'Wrong username or password!';
                            setState(() {});
                            print(wrongcredentials);
                            await Future.delayed(Duration(seconds: 2));
                            print('Wrong Credentials');
                            wrongcredentials = '';
                            setState(() {});
                          }
                        }),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(wrongcredentials,
                            style: GoogleFonts.poppins(
                              color: Colors.red.withOpacity(1.0),
                            ))),

                    // await Future.delayed(Duration(seconds: 1), () {
                    //   print('Its ok so far');
                    // }).then((value) {
                    //   Navigator.pop(context);
                    // }).catchError((InvalidCredentialsException) {
                    //   print('Invalid Credentials');
                    //   wrongcredentials = 'Wrong username or password!';
                    //   setState(() {});
                    //   Future.delayed(
                    //       const Duration(seconds: 1), () => "1");

                    //   wrongcredentials = '';
                    //   setState(() {});
                    // }).whenComplete(() {
                    //   print('Clean-up done');
                    // });

                    // try {
                    //   Navigator.pop(context);
                    // } on InvalidCredentialsException {
                    //   print('Invalid Credentials');
                    //   wrongcredentials = 'Wrong username or password!';
                    //   setState(() {});
                    //   await Future.delayed(Duration(seconds: 1));
                    //   wrongcredentials = '';
                    //   setState(() {});
                    // } finally {
                    //   print('Clean-up done');
                    // }

                    // async {
                    //   print('Submit Button Pressed');
                    //   print(nameController.text);
                    //   print(passwordController.text);
                    //   final Session session = Session.fromCookie(
                    //       'ASP.NET_SessionId=(ohw1bpa5msidmy1qjz4jclk5); AuthenticationToken=(538ca867-dfa7-448e-81ac-1bbe89e568f2);');
                    //   // final Session session = Session.fromCookie('');
                    //   sessioncreator() async {
                    //     await Session.create(
                    //         nameController.text, passwordController.text);
                    //   }

                    //   sessioncreator();

                    //   // final String _sessionId = '';
                    //   // final String _authToken = '';

                    //   final bool isSessionValid = await session.validate();
                    //   if (isSessionValid == true) {
                    //     // Navigator.pop(context);
                    //   } else {
                    //     wrongcredentials = 'Wrong username or password!';
                    //     setState(() {});
                    //     print(wrongcredentials);
                    //     await Future.delayed(Duration(seconds: 1));
                    //     print('Wrong Credentials');
                    //     wrongcredentials = '';
                    //     setState(() {});
                    //   }
                    //   //   bool validating = await Session.validate();
                    //   // }
                    // }
                  ],
                ))));
  }

  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
    setState(() {});
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
