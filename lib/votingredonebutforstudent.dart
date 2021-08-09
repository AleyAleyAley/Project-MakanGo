import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makangoagain/studentdrawer.dart';
import 'vendorDrawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'loginpage.dart';
import 'session.dart';
import 'detail.dart';

class VotingRedoneButForStudents extends StatefulWidget {
  @override
  _VotingRedoneButForStudentsState createState() =>
      _VotingRedoneButForStudentsState();
}

class _VotingRedoneButForStudentsState
    extends State<VotingRedoneButForStudents> {
  Future<QuerySnapshot> _getTodos;
  void _refreshTodos() {
    setState(() {
      _getTodos = FirebaseFirestore.instance.collection('voting').get();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getTodos = FirebaseFirestore.instance.collection('voting').get();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff7a939f),
          title: Text("Stall Ratings",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xffddf3ff),
              )),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              color: Color(0xffddf2ff),
              onPressed: _refreshTodos,
            ),
            IconButton(
                icon: Icon(Icons.exit_to_app),
                color: Color(0xffddf2ff),
                onPressed: () async {
                  await remove();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                }),
          ],
        ),
        drawer: StudentDrawer(),
        body: FutureBuilder<QuerySnapshot>(
            future: _getTodos,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //issue likely before this
              print('checkpoint 1');

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              print('ALL IS WELL TILL HERE');
              //Issue not after this
              final _todosCollection =
                  FirebaseFirestore.instance.collection('voting').get;

              final _undoneTodos = snapshot.data.docs
                  .where((DocumentSnapshot document) =>
                      document.data()['name'] != null &&
                      document.data()["name"] != null &&
                      document.data()['stars'] != null)
                  .toList();
              print('THNIGS ARE STILL WELL');
              if (_undoneTodos.isEmpty == false) {
                return ListView(children: [
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Chicken Rice: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[0].data()["stars"] /
                                  _undoneTodos[0].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Drinks: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[1].data()["stars"] /
                                  _undoneTodos[1].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Economic Rice: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[2].data()["stars"] /
                                  _undoneTodos[2].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Japanese and Korean Stall: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[3].data()["stars"] /
                                  _undoneTodos[3].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Muslim Stall: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[4].data()["stars"] /
                                  _undoneTodos[4].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Noodles Stall: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[5].data()["stars"] /
                                  _undoneTodos[5].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Pasta Stall: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[6].data()["stars"] /
                                  _undoneTodos[6].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Spinach Soup: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[7].data()["stars"] /
                                  _undoneTodos[7].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                  ListTile(
                      title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Western Stall: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: (_undoneTodos[8].data()["stars"] /
                                  _undoneTodos[8].data()["responses"])
                              .toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.star,
                              size: 20, color: Color(0xff7a939f)),
                          alignment: PlaceholderAlignment.middle,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
                ]);
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.80),
                            BlendMode.dstATop),
                        child: const Image(
                          image: (AssetImage('assets/icon/pwlogonobg.png')),
                        ),
                      ),
                      Text('Nothing found',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff7a939f),
                              fontSize: 24)),
                    ],
                  ),
                );
              }
            }));
  }
}
