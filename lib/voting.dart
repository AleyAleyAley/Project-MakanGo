import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makangoagain/studentdrawer.dart';
import 'package:makangoagain/votingredonebutforstudent.dart';
import 'vendorDrawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'session.dart';
import 'loginpage.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  void votingdone() async {
    // await FirebaseFirestore.instance
    //     .collection("voting")
    //     .doc(widget.vendorFirebase)
    //     .update({
    //   "responses": currentResponses + 1,
    //   "stars": currentStars + _rating
    // });
    // expansionTile.currentState.collapse();
  }
  void _refreshTodos() {
    setState(() {
      Future<QuerySnapshot> _getTodos;
      _getTodos = FirebaseFirestore.instance.collection('voting').get();
      //@asher come and add the get values query snapshot to this place
    });
  }

  Future<QuerySnapshot> _getTodos =
      FirebaseFirestore.instance.collection('voting').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff7a939f),
          title: Text("Voting",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xffddf3ff),
              )),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                color: Color(0xffddf2ff),
                onPressed: _refreshTodos),
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
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                print('bruh ig up to here is fine');
                final unarchivedTodos = snapshot.data.docs
                    .where((DocumentSnapshot document) =>
                        document.data()['name'] != null &&
                        document.data()['stars'] != null)
                    .toList();
                print('is this empty?');
                print(unarchivedTodos.isEmpty);
                print('does this work');
                return (Container(
                    child: ListView(
                  children: [
                    BuildVotingTile(
                        vendorFirebase: "Drinks",
                        vendorName: "Drinks Stall",
                        rating: unarchivedTodos[1].data()['stars'] /
                            unarchivedTodos[1].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "ChickenRice",
                        vendorName: "Chicken Rice Stall",
                        rating: unarchivedTodos[0].data()['stars'] /
                            unarchivedTodos[0].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "EconomicRice",
                        vendorName: "Economic Rice Stall",
                        rating: unarchivedTodos[2].data()['stars'] /
                            unarchivedTodos[2].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "JapKorean",
                        vendorName: "Japanese & Korean Stall",
                        rating: unarchivedTodos[3].data()['stars'] /
                            unarchivedTodos[3].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "Muslim",
                        vendorName: "Muslim Stall",
                        rating: unarchivedTodos[4].data()['stars'] /
                            unarchivedTodos[4].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "Noodles",
                        vendorName: "Noodles Stall",
                        rating: unarchivedTodos[5].data()['stars'] /
                            unarchivedTodos[5].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "Western",
                        vendorName: "Western Stall",
                        rating: unarchivedTodos[8].data()['stars'] /
                            unarchivedTodos[8].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "Pasta",
                        vendorName: "Pasta Stall",
                        rating: unarchivedTodos[6].data()['stars'] /
                            unarchivedTodos[6].data()['responses']),
                    BuildVotingTile(
                        vendorFirebase: "Spinach",
                        vendorName: "Spinach Soup Stall",
                        rating: unarchivedTodos[7].data()['stars'] /
                            unarchivedTodos[7].data()['responses']),
                  ],
                )));
              }
            }));
  }
}

class BuildVotingTile extends StatefulWidget {
  final vendorFirebase;
  final vendorName;
  final rating;
  BuildVotingTile({Key key, this.vendorFirebase, this.vendorName, this.rating})
      : super(key: key);
  @override
  _BuildVotingTileState createState() => _BuildVotingTileState();
}

class _BuildVotingTileState extends State<BuildVotingTile> {
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating = 2.0;
  bool _isRTLMode = false;
  bool _isVertical = false;
  double _rating = 0.0;

  IconData _selectedIcon;
  // = IconButton(
  //       icon: Icon(icon),
  //       onPressed: () => Navigator.pop(context, icon),
  //       splashColor: Colors.amberAccent,
  //       color: Colors.amber,
  //     );
  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: false,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 30.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            _selectedIcon ?? Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );

      default:
        return Container();
    }
  }

  Future<double> _ratingO(hi) async {
    Future<QuerySnapshot> _getTodos =
        FirebaseFirestore.instance.collection('voting').get();
    AsyncSnapshot<QuerySnapshot> snapshot;
    double currentResponses = 10;
    double currentStars = 2;

    // await FirebaseFirestore.instance
    //     .collection("voting")
    //     .doc(hi)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   currentResponses = documentSnapshot.get("responses");
    //   currentStars = documentSnapshot.get("stars");
    // });
    double lmao = 1.0;
    lmao = currentResponses / currentStars;
    return (lmao);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference votes = FirebaseFirestore.instance.collection('voting');

    // double currentResponses = 10;
    // double currentStars = 2;
    // Future<QuerySnapshot> _getTodos =
    //     FirebaseFirestore.instance.collection('voting').get();
    AsyncSnapshot<QuerySnapshot> snapshot;
    print('b4 error occurs');
    print(snapshot == null);
    //ISSUE HERE

    //
    var thisannoyingthing = _ratingO(widget.vendorFirebase);
    var lOLOL = thisannoyingthing.toString();
    var haiz = lOLOL;
    //  double yee=thisannoyingthing,y
    // Future<double> ratingget(String hi) async {
    //   double currentResponses = 10;
    //   double currentStars = 2;

    //   await FirebaseFirestore.instance
    //       .collection("voting")
    //       .doc(hi)
    //       .get()
    //       .then((DocumentSnapshot documentSnapshot) {
    //     currentResponses = documentSnapshot.get("responses");
    //     // currentStars = documentSnapshot.get("stars");
    //   });
    //   double ratingofthestall =
    //       currentResponses.toDouble() / currentStars.toDouble().toDouble();
    //   return (ratingofthestall);
    // }

    // double ratingofthisstall = currentResponses / currentStars;

    return Card(
      child: ExpansionTile(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.vendorName + ' ',
                style: GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff7a939f),
                ),
              ),
              WidgetSpan(
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Color(0xff7a939f),
                  ),
                  style: GoogleFonts.poppins(
                    // fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xff7a939f),
                  ),
                  alignment: PlaceholderAlignment.middle),
              TextSpan(
                text: widget.rating.toStringAsFixed(1),
                style: GoogleFonts.poppins(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff7a939f),
                ),
              ),
            ],
          ),
        ),
        //  Text(
        //   (widget.vendorName) + (Icons.star) + (ratingofthisstall).toString(),
        //   style: GoogleFonts.poppins(
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //     color: Color(0xff7a939f),
        //   ),
        // ),
        // childre
        //nPadding: EdgeInsets.all(0
        // ),
        expandedAlignment: Alignment.center,
        children: [
          // Text.rich(
          //   TextSpan(
          //     style: GoogleFonts.poppins(
          //       fontWeight: FontWeight.normal,
          //       fontSize: 15,
          //       color: Color(0xff7a939f),
          //     ),
          //     children: [
          //       // TextSpan(text: "Click the stars to vote: "),
          //       // WidgetSpan(
          //       //   child: GestureDetector(
          //       //     child: Icon(Icons.star, color: _starColor1),
          //       //     onTap: () {
          //       //       setState(() => {
          //       //             if (_starColor1 == Colors.black)
          //       //               {
          //       //                 _starColor1 = Colors.yellow,
          //       //                 totalStars += 1,
          //       //               }
          //       //             else
          //       //               {_starColor1 = Colors.black, totalStars -= 1}
          //       //           });
          //       //     },
          //       //   ),
          //       // ),
          //       // WidgetSpan(
          //       //   child: GestureDetector(
          //       //     child: Icon(Icons.star, color: _starColor2),
          //       //     onTap: () {
          //       //       setState(() => {
          //       //             if (_starColor2 == Colors.black)
          //       //               {
          //       //                 _starColor2 = Colors.yellow,
          //       //                 totalStars += 1,
          //       //               }
          //       //             else
          //       //               {_starColor2 = Colors.black, totalStars -= 1}
          //       //           });
          //       //     },
          //       //   ),
          //       // ),
          //       // WidgetSpan(
          //       //   child: GestureDetector(
          //       //     child: Icon(Icons.star, color: _starColor3),
          //       //     onTap: () {
          //       //       setState(() => {
          //       //             if (_starColor3 == Colors.black)
          //       //               {
          //       //                 _starColor3 = Colors.yellow,
          //       //                 totalStars += 1,
          //       //               }
          //       //             else
          //       //               {_starColor3 = Colors.black, totalStars -= 1}
          //       //           });
          //       //     },
          //       //   ),
          //       // ),
          //       // WidgetSpan(
          //       //   child: GestureDetector(
          //       //     child: Icon(Icons.star, color: _starColor4),
          //       //     onTap: () {
          //       //       setState(() => {
          //       //             if (_starColor4 == Colors.black)
          //       //               {
          //       //                 _starColor4 = Colors.yellow,
          //       //                 totalStars += 1,
          //       //               }
          //       //             else
          //       //               {_starColor4 = Colors.black, totalStars -= 1}
          //       //           });
          //       //     },
          //       //   ),
          //       // ),
          //       // WidgetSpan(
          //       //   child: GestureDetector(
          //       //     child: Icon(Icons.star, color: _starColor5),
          //       //     onTap: () {
          //       //       setState(() => {
          //       //             if (_starColor5 == Colors.black)
          //       //               {
          //       //                 _starColor5 = Colors.yellow,
          //       //                 totalStars += 1,
          //       //               }
          //       //             else
          //       //               {_starColor5 = Colors.black, totalStars -= 1}
          //       //           });
          //       //     },
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
          Text(
            'Rate this stall:',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Color(0xff7a939f),
            ),
          ),

          _ratingBar(1),
          SizedBox(
            height: 5.0,
          ),
          RaisedButton(
            shape: (RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            color: Color(0xff7a939f),
            child: Text(
              'Submit',
              style: GoogleFonts.poppins(
                color: Color(0xffddf2ff),
              ),
            ),
            onPressed: () async {
              print('press raised button to submit');
              int currentResponses = 0;
              int currentStars = 0;
              await FirebaseFirestore.instance
                  .collection("voting")
                  .doc(widget.vendorFirebase)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                currentResponses = documentSnapshot.get("responses");
                currentStars = documentSnapshot.get("stars");
              });
              int rating = (_rating.toInt());
              await FirebaseFirestore.instance
                  .collection("voting")
                  .doc(widget.vendorFirebase)
                  .update({
                "responses": currentResponses + 1,
                "stars": currentStars + (rating)
              });
              setState(() {});
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VotingRedoneButForStudents(),
              ));
            },
          )
        ],

        initiallyExpanded: false,
        onExpansionChanged: (isExpanded) {
          bool isExpanded = true;
        },
        // onExpansionChanged: (isExpanded) async {
        //   int currentResponses = 0;
        //   int currentStars = 0;

        //   await FirebaseFirestore.instance
        //       .collection("voting")
        //       .doc(widget.vendorFirebase)
        //       .get()
        //       .then((DocumentSnapshot documentSnapshot) {
        //     currentResponses = documentSnapshot.get("responses");
        //     currentStars = documentSnapshot.get("stars");
        //   });
        //   print('$currentStars');
        //   print('$currentResponses');
        //   await FirebaseFirestore.instance
        //       .collection("voting")
        //       .doc(widget.vendorFirebase)
        //       .update({
        //     "responses": currentResponses + 1,
        //     "stars": currentStars + _rating
        //   });
        // }
        //     var doubleRating = (currentStars / currentResponses) * 2;
        //     rating = (doubleRating.round()) / 2;
        //     // fixedStar(double rating, int starNumber, star) {
        //     //     if (rating == 0.5 || rating == 1.5 || rating == 2.5 || rating == 3.5 || rating == 4.5){
        //     //       if (starNumber == rating-0.5){
        //     //         star = Icon(
        //     //           Icons.star_half,
        //     //           color: Colors.yellow,
        //     //         );
        //     //       } else if (starNumber < rating-0.5){
        //     //         star =  Icon(
        //     //           Icons.star,
        //     //           color:Colors.yellow,
        //     //         );
        //     //       } else{
        //     //         star = Icon(
        //     //           Icons.star,
        //     //           color:Colors.black,
        //     //         );
        //     //       }
        //     //     } else if (rating == 0 || rating == 1|| rating ==2 ||rating==3||rating==4||rating==5){
        //     //       if (starNumber <= rating){
        //     //         star =  Icon(
        //     //           Icons.star,
        //     //           color:Colors.yellow
        //     //         );
        //     //       } else if (starNumber > rating){
        //     //         star =  Icon(
        //     //           Icons.star,
        //     //           color:Colors.black
        //     //         );
        //     //       }
        //     //     }
        //     // }

        //     // fixedStar(rating, 1, fixedStar1);
        //     // fixedStar(rating, 2, fixedStar2);
        //     // fixedStar(rating, 3, fixedStar3);
        //     // fixedStar(rating, 4, fixedStar4);
        //     // fixedStar(rating, 5, fixedStar5);

        //     if (totalStars != 0) {
        //       await FirebaseFirestore.instance
        //           .collection("voting")
        //           .doc(widget.vendorFirebase)
        //           .update({
        //         "responses": currentResponses + 1,
        //         "stars": currentStars + _rating
        //       });
        //     }

        //     // _starColor1 = Colors.black;
        //     // _starColor2 = Colors.black;
        //     // _starColor3 = Colors.black;
        //     // _starColor4 = Colors.black;
        //     // _starColor5 = Colors.black;

        //   }

        //   if (isExpanded) {
        //     await FirebaseFirestore.instance
        //         .collection("voting")
        //         .doc(widget.vendorFirebase)
        //         .get()
        //         .then((DocumentSnapshot documentSnapshot) {
        //       currentResponses = documentSnapshot.get("responses");
        //       currentStars = documentSnapshot.get("stars");
        //     });

        //     print(rating);
        //     // print(fixedStar1);
        //     print(totalStars);
        //   }
        // },
      ),
    );
  }
}
