import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:makangoagain/votingredonebutforstudent.dart';
import 'dart:async';
import 'session.dart';
import 'main.dart';
import 'voting.dart';
import 'votingredone.dart';

class StudentDrawer extends StatelessWidget {
  final _todosCollection = FirebaseFirestore.instance.collection('todos');

  Future<QuerySnapshot> _getTodos =
      FirebaseFirestore.instance.collection('todos').get();
// Future<QuerySnapshot>(){}

  @override
  Widget build(BuildContext context) {
    //     CollectionReference users = FirebaseFirestore.instance.collection('todos');

    // int futureBuilder() {
    //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //   Future<QuerySnapshot> _getTodos;
    //   Stream<QuerySnapshot> hello =
    //       firebaseFirestore.collection('todos').snapshots();
    //   future:
    //   FirebaseFirestore.instance.collection('todos').snapshots();
    //   AsyncSnapshot<QuerySnapshot> snapshot; //ISSUE IS HERE!!!!!!!!!!!!

    //   final undoneTodos = snapshot.data.docs
    //       .where((DocumentSnapshot document) =>
    //           document.data()['user'] == usernameVal &&
    //           document.data()['isarchived'] == false)
    //       .toList();
    //   int undone = undoneTodos.length;
    //   return (undone);
    // }

    // print('healthy 19');
    // int undone = futureBuilder();
    // print('healthy 21');
    // String nullpreventor = '0';
    // if (undone == null || undone == 0) {
    //   nullpreventor = '0';
    // } else {
    //   nullpreventor = '$undone';
    // }
    // Future<QuerySnapshot> _getTodos;
    String placeholder = '1000';
    int maxr = 11 + 2 * (placeholder.length);
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      _createHeader(),
      FutureBuilder<QuerySnapshot>(
          future: _getTodos,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final archivedTodos = snapshot.data.docs
                .where((DocumentSnapshot document) =>
                    document.data()['user'] == usernameVal &&
                    document.data()['isarchived'] == true)
                .toList();
            final unarchivedTodos = snapshot.data.docs
                .where((DocumentSnapshot document) =>
                    document.data()['user'] == usernameVal &&
                    document.data()['isarchived'] == false)
                .toList();
            int width = 36;

            if (unarchivedTodos.length.toString().length > 3) {
              print('wierd numbers');
              print(unarchivedTodos.length.toString().length);
              width =
                  width + 4 * ((unarchivedTodos.length.toString().length) - 3);
            }
            return (Container(
                    child: ListTile(
                        leading: const Icon(Icons.assignment),
                        title: Text(
                          "Orders",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff7a939f),
                            fontSize: 16,
                          ),
                        ),
                        trailing: Container(
                            child: Center(
                              child: Text(unarchivedTodos.length.toString(),
                                  // '1000',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffddf2ff), fontSize: 12)),
                            ),
                            width: width.toDouble(),
                            height: 24,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Color(0xff7a939f),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()))
                        //ListTile bracket behind this
                        ))

                //Return bracket behind this
                );
          }),
      FutureBuilder<QuerySnapshot>(
          future: _getTodos,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final archivedTodos = snapshot.data.docs
                .where((DocumentSnapshot document) =>
                    document.data()['user'] == usernameVal &&
                    document.data()['isarchived'] == true)
                .toList();
            final unarchivedTodos = snapshot.data.docs
                .where((DocumentSnapshot document) =>
                    document.data()['user'] == usernameVal &&
                    document.data()['isarchived'] == true)
                .toList();
            int width = 36;
            if (unarchivedTodos.length.toString().length > 3) {
              width =
                  width + 4 * ((unarchivedTodos.length.toString().length) - 3);
            }
            return (Container(
                    child: ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(
                          "Order History",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff7a939f),
                            fontSize: 16,
                          ),
                        ),
                        trailing: Container(
                            child: Center(
                              child: Text(archivedTodos.length.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Color(0xffddf2ff), fontSize: 12)),
                            ),
                            width: width.toDouble(),
                            height: 24,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Color(0xff7a939f),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => archive()))
                        //ListTile bracket behind this
                        ))

                //Return bracket behind this
                );
          }),
      Container(
          child: ListTile(
              leading: const Icon(Icons.thumb_up_alt_sharp),
              title: Text(
                "Voting",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7a939f),
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Voting()))
              //ListTile bracket behind this
              )),
      Container(
          child: ListTile(
              leading: const Icon(Icons.leaderboard),
              title: Text(
                "Ratings",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7a939f),
                  fontSize: 16,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VotingRedoneButForStudents()))
              //ListTile bracket behind this
              )),
    ]));
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Color(0xff7a939f),
        // image: DecorationImage(
        //   fit:BoxFit.fill,
        //   image:AssetImage('assets/icon/pwlogonobg.png')
        // )
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Project MakanGo",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Color(0xffddf2ff),
              ),
            ),
          )
        ],
      ));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Color(0xff7a939f),
            ),
          ),
        ),
      ],
    ),
    onTap: onTap,
  );
}
