import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:background_fetch/background_fetch.dart';
import 'detail.dart';

class StartUpView extends StatefulWidget {
  _StartUpViewState createState() => _StartUpViewState();
}

Future<void> archiver2() async {
  print('first check');
  // await Firebase.initializeApp();

  // print('RUNNNN');
  // final _todosCollection = FirebaseFirestore.instance.collection('todos');
  // Future<QuerySnapshot> _getTodos;
  // _getTodos = FirebaseFirestore.instance.collection('todos').get();
  // // Future<QuerySnapshot> _getTodos;
  // AsyncSnapshot<QuerySnapshot> snapshot;

  // print('checker1');

  // final _todosCollection = FirebaseFirestore.instance.collection('todos');
  // AsyncSnapshot<QuerySnapshot> snapshot;
  // final undoneTodos = snapshot.data.docs
  //     .where(
  //         (DocumentSnapshot document) => document.data()['isarchived'] == false)
  //     .toList();
  // print('pls work');
  // int undonetodolength = undoneTodos.length;
  // for (int j = 0; j < undonetodolength; j++) {
  //   var currentDateTime = new DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //     DateTime.now().hour,
  //     DateTime.now().minute,
  //   );
  //   DateTime currentDateTime1 = currentDateTime.toLocal();
  //   // print('DEBUG TIME');
  //   // print('\n');
  //   // print('CurrentDateTime1:');
  //   // print('$currentDateTime1');
  //   // print('\n');

  //   var datetimeofloopedthroughthing = undoneTodos[j].data()["title"];
  //   // print('\n');
  //   // print('title of document snapshot');
  //   // print(datetimeofloopedthroughthing);
  //   // print('\n');
  //   DateTime orderdatetime =
  //       DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
  //   // print('\n');
  //   // print('orderdatetimeformatted');
  //   // print(orderdatetime);
  //   // print('\n');
  //   var orderdatetimeformatted = new DateTime(
  //     orderdatetime.year,
  //     orderdatetime.month,
  //     orderdatetime.day,
  //     orderdatetime.hour,
  //     orderdatetime.minute,
  //   );
  //   // print('\n');
  //   // print('orderdatetimeformatted:');
  //   // print(orderdatetimeformatted);
  //   // print('\n');
  //   DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
  //   // print('ordertitledatetimeformatted2');
  //   // print(ordertitleformatted2);

  //   Duration differenceindatetime = orderdatetime.difference(currentDateTime1);
  //   var expirytime = const Duration(hours: -1);
  //   if (differenceindatetime <= expirytime) {
  //     _todosCollection.doc(undoneTodos[j].id).update({'isarchived': true});
  //     print('archived successful');
  //   }
  //   // print(differenceindatetime);
  // }
  // print('ARCHIVER RAN TILL THE END');

  final _todosCollection = FirebaseFirestore.instance.collection('todos');
  // Future<QuerySnapshot> _getTodos;
  Future<QuerySnapshot> _getTodos;
  _getTodos = FirebaseFirestore.instance.collection('todos').get();

  AsyncSnapshot<QuerySnapshot> snapshot;
  QuerySnapshot snapshoter;
  var undoneTodos;
  // print('is this new snapper null');
  // print(snapshot == null);
  // undoneTodos = snapshot.data.docs
  //     .where(
  //         (DocumentSnapshot document) => document.data()['isarchived'] == false)
  //     .toList();
  FirebaseFirestore.instance
      .collection('todos')
      .where('isarchived', isEqualTo: false)
      .get()
      .then((QuerySnapshot snapshoter) {
    // print('pls pass this check');
    snapshoter.docs.forEach((doc) {
      var currentDateTime = new DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
      );
      DateTime currentDateTime1 = currentDateTime.toLocal();
      // print('DEBUG TIME');
      // print('\n');
      // print('CurrentDateTime1:');
      // print('$currentDateTime1');
      // print('\n');
      print('checkpoint0');

      var datetimeofloopedthroughthing = doc["title"];
      // print('\n');
      // print('title of document snapshot');
      // print(datetimeofloopedthroughthing);
      // print('\n');
      print('checkpoint1');
      DateTime orderdatetime =
          DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
      // print('\n');
      // print('orderdatetimeformatted');
      // print(orderdatetime);
      // print('\n');
      var orderdatetimeformatted = new DateTime(
        orderdatetime.year,
        orderdatetime.month,
        orderdatetime.day,
        orderdatetime.hour,
        orderdatetime.minute,
      );
      // print('\n');
      // print('orderdatetimeformatted:');
      // print(orderdatetimeformatted);
      // print('\n');
      DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
      // print('ordertitledatetimeformatted2');
      // print(ordertitleformatted2);

      Duration differenceindatetime =
          orderdatetime.difference(currentDateTime1);
      var expirytime = const Duration(hours: -1);
      print('LOL DOING ON NDP HOLIS BE LIKE');
      if (differenceindatetime <= expirytime) {
        // _todosCollection.doc(doc.id).update({'isarchived': true});
        _todosCollection
            .doc((doc['title'] + doc['user']).toString())
            .update({'isarchived': true});
      }
      print('ran for this doc');
    });
  });
  // FutureBuilder<QuerySnapshot>(
  //     future: _getTodos,
  //     builder:
  //         // ignore: missing_return
  //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       print('futurebuider');
  //       if (snapshot.hasError) {
  //         print('lol snapshot error sadz');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         print('lol patience, snapshot still connecting');
  //       }
  //       print('is this new snapper null');
  //       print(snapshot == null);
  //       undoneTodos = snapshot.data.docs
  //           .where((DocumentSnapshot document) =>
  //               document.data()['isarchived'] == false)
  //           .toList();
  //     });

  // int undonetodolength = undoneTodos.length;
  // var undonetodolength = 0;
  // for (int j = 0; j < undonetodolength; j++) {
  //   var currentDateTime = new DateTime(
  //     DateTime.now().year,
  //     DateTime.now().month,
  //     DateTime.now().day,
  //     DateTime.now().hour,
  //     DateTime.now().minute,
  //   );
  //   DateTime currentDateTime1 = currentDateTime.toLocal();
  //   // print('DEBUG TIME');
  //   // print('\n');
  //   // print('CurrentDateTime1:');
  //   // print('$currentDateTime1');
  //   // print('\n');

  //   var datetimeofloopedthroughthing = undoneTodos[j].data()["title"];
  //   // print('\n');
  //   // print('title of document snapshot');
  //   // print(datetimeofloopedthroughthing);
  //   // print('\n');
  //   DateTime orderdatetime =
  //       DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
  //   // print('\n');
  //   // print('orderdatetimeformatted');
  //   // print(orderdatetime);
  //   // print('\n');
  //   var orderdatetimeformatted = new DateTime(
  //     orderdatetime.year,
  //     orderdatetime.month,
  //     orderdatetime.day,
  //     orderdatetime.hour,
  //     orderdatetime.minute,
  //   );
  //   // print('\n');
  //   // print('orderdatetimeformatted:');
  //   // print(orderdatetimeformatted);
  //   // print('\n');
  //   DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
  //   // print('ordertitledatetimeformatted2');
  //   // print(ordertitleformatted2);

  //   Duration differenceindatetime =
  //       orderdatetime.difference(currentDateTime1);
  //   var expirytime = const Duration(hours: -1);
  //   if (differenceindatetime <= expirytime) {
  //     _todosCollection.doc(undoneTodos[j].id).update({'isarchived': true});
  //   }
  //   // if (1 == 1) {
  //   //   BackgroundFetch.start().then((int status) {
  //   //     print('[BackgroundFetch] start success: $status');
  //   //   }).catchError((e) {
  //   //     print('[BackgroundFetch] start FAILURE: $e');
  //   //   });
  //   // }
  //   // print(differenceindatetime);
  // }
  print('it worked at last for startup');
}

class _StartUpViewState extends State<StartUpView> {
  // var checkPresent = false;

  // Future<void> startuplogic() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey("username")==true){
  //     checkPresent = true;
  // }
  // Future<void> archiver() async {
  //   print('first check');
  //   // await Firebase.initializeApp();

  //   // print('RUNNNN');
  //   // final _todosCollection = FirebaseFirestore.instance.collection('todos');
  //   // Future<QuerySnapshot> _getTodos;
  //   // _getTodos = FirebaseFirestore.instance.collection('todos').get();
  //   // // Future<QuerySnapshot> _getTodos;
  //   // AsyncSnapshot<QuerySnapshot> snapshot;

  //   // print('checker1');

  //   // final _todosCollection = FirebaseFirestore.instance.collection('todos');
  //   // AsyncSnapshot<QuerySnapshot> snapshot;
  //   // final undoneTodos = snapshot.data.docs
  //   //     .where(
  //   //         (DocumentSnapshot document) => document.data()['isarchived'] == false)
  //   //     .toList();
  //   // print('pls work');
  //   // int undonetodolength = undoneTodos.length;
  //   // for (int j = 0; j < undonetodolength; j++) {
  //   //   var currentDateTime = new DateTime(
  //   //     DateTime.now().year,
  //   //     DateTime.now().month,
  //   //     DateTime.now().day,
  //   //     DateTime.now().hour,
  //   //     DateTime.now().minute,
  //   //   );
  //   //   DateTime currentDateTime1 = currentDateTime.toLocal();
  //   //   // print('DEBUG TIME');
  //   //   // print('\n');
  //   //   // print('CurrentDateTime1:');
  //   //   // print('$currentDateTime1');
  //   //   // print('\n');

  //   //   var datetimeofloopedthroughthing = undoneTodos[j].data()["title"];
  //   //   // print('\n');
  //   //   // print('title of document snapshot');
  //   //   // print(datetimeofloopedthroughthing);
  //   //   // print('\n');
  //   //   DateTime orderdatetime =
  //   //       DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
  //   //   // print('\n');
  //   //   // print('orderdatetimeformatted');
  //   //   // print(orderdatetime);
  //   //   // print('\n');
  //   //   var orderdatetimeformatted = new DateTime(
  //   //     orderdatetime.year,
  //   //     orderdatetime.month,
  //   //     orderdatetime.day,
  //   //     orderdatetime.hour,
  //   //     orderdatetime.minute,
  //   //   );
  //   //   // print('\n');
  //   //   // print('orderdatetimeformatted:');
  //   //   // print(orderdatetimeformatted);
  //   //   // print('\n');
  //   //   DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
  //   //   // print('ordertitledatetimeformatted2');
  //   //   // print(ordertitleformatted2);

  //   //   Duration differenceindatetime = orderdatetime.difference(currentDateTime1);
  //   //   var expirytime = const Duration(hours: -1);
  //   //   if (differenceindatetime <= expirytime) {
  //   //     _todosCollection.doc(undoneTodos[j].id).update({'isarchived': true});
  //   //     print('archived successful');
  //   //   }
  //   //   // print(differenceindatetime);
  //   // }
  //   // print('ARCHIVER RAN TILL THE END');
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();

  //   final _todosCollection = FirebaseFirestore.instance.collection('todos');
  //   // Future<QuerySnapshot> _getTodos;
  //   Future<QuerySnapshot> _getTodos;
  //   _getTodos = FirebaseFirestore.instance.collection('todos').get();

  //   AsyncSnapshot<QuerySnapshot> snapshot;
  //   QuerySnapshot snapshoter;
  //   var undoneTodos;
  //   print('is this new snapper null');
  //   print(snapshot == null);
  //   // undoneTodos = snapshot.data.docs
  //   //     .where(
  //   //         (DocumentSnapshot document) => document.data()['isarchived'] == false)
  //   //     .toList();
  //   FirebaseFirestore.instance
  //       .collection('todos')
  //       .where('isarchived', isEqualTo: false)
  //       .get()
  //       .then((QuerySnapshot snapshoter) {
  //     print('pls pass this check');
  //     snapshoter.docs.forEach((doc) {
  //       var currentDateTime = new DateTime(
  //         DateTime.now().year,
  //         DateTime.now().month,
  //         DateTime.now().day,
  //         DateTime.now().hour,
  //         DateTime.now().minute,
  //       );
  //       DateTime currentDateTime1 = currentDateTime.toLocal();
  //       // print('DEBUG TIME');
  //       // print('\n');
  //       // print('CurrentDateTime1:');
  //       // print('$currentDateTime1');
  //       // print('\n');
  //       print('checkpoint0');

  //       var datetimeofloopedthroughthing = doc["title"];
  //       // print('\n');
  //       // print('title of document snapshot');
  //       // print(datetimeofloopedthroughthing);
  //       // print('\n');
  //       print('checkpoint1');
  //       DateTime orderdatetime =
  //           DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
  //       // print('\n');
  //       // print('orderdatetimeformatted');
  //       // print(orderdatetime);
  //       // print('\n');
  //       var orderdatetimeformatted = new DateTime(
  //         orderdatetime.year,
  //         orderdatetime.month,
  //         orderdatetime.day,
  //         orderdatetime.hour,
  //         orderdatetime.minute,
  //       );
  //       // print('\n');
  //       // print('orderdatetimeformatted:');
  //       // print(orderdatetimeformatted);
  //       // print('\n');
  //       DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
  //       // print('ordertitledatetimeformatted2');
  //       // print(ordertitleformatted2);

  //       Duration differenceindatetime =
  //           orderdatetime.difference(currentDateTime1);
  //       var expirytime = const Duration(hours: -1);
  //       if (differenceindatetime <= expirytime) {
  //         // _todosCollection.doc(doc.id).update({'isarchived': true});
  //         _todosCollection
  //             .doc((doc['title'] + doc['user']).toString())
  //             .update({'isarchived': true});
  //       }
  //       print('ran for this doc');
  //     });
  //   });
  //   // FutureBuilder<QuerySnapshot>(
  //   //     future: _getTodos,
  //   //     builder:
  //   //         // ignore: missing_return
  //   //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //   //       print('futurebuider');
  //   //       if (snapshot.hasError) {
  //   //         print('lol snapshot error sadz');
  //   //       }

  //   //       if (snapshot.connectionState == ConnectionState.waiting) {
  //   //         print('lol patience, snapshot still connecting');
  //   //       }
  //   //       print('is this new snapper null');
  //   //       print(snapshot == null);
  //   //       undoneTodos = snapshot.data.docs
  //   //           .where((DocumentSnapshot document) =>
  //   //               document.data()['isarchived'] == false)
  //   //           .toList();
  //   //     });
  //   print('is snapshot null');
  //   print(snapshot == null);

  //   // int undonetodolength = undoneTodos.length;
  //   // var undonetodolength = 0;
  //   // for (int j = 0; j < undonetodolength; j++) {
  //   //   var currentDateTime = new DateTime(
  //   //     DateTime.now().year,
  //   //     DateTime.now().month,
  //   //     DateTime.now().day,
  //   //     DateTime.now().hour,
  //   //     DateTime.now().minute,
  //   //   );
  //   //   DateTime currentDateTime1 = currentDateTime.toLocal();
  //   //   // print('DEBUG TIME');
  //   //   // print('\n');
  //   //   // print('CurrentDateTime1:');
  //   //   // print('$currentDateTime1');
  //   //   // print('\n');

  //   //   var datetimeofloopedthroughthing = undoneTodos[j].data()["title"];
  //   //   // print('\n');
  //   //   // print('title of document snapshot');
  //   //   // print(datetimeofloopedthroughthing);
  //   //   // print('\n');
  //   //   DateTime orderdatetime =
  //   //       DateFormat('dd-MM-yyyy - H:mm').parse(datetimeofloopedthroughthing);
  //   //   // print('\n');
  //   //   // print('orderdatetimeformatted');
  //   //   // print(orderdatetime);
  //   //   // print('\n');
  //   //   var orderdatetimeformatted = new DateTime(
  //   //     orderdatetime.year,
  //   //     orderdatetime.month,
  //   //     orderdatetime.day,
  //   //     orderdatetime.hour,
  //   //     orderdatetime.minute,
  //   //   );
  //   //   // print('\n');
  //   //   // print('orderdatetimeformatted:');
  //   //   // print(orderdatetimeformatted);
  //   //   // print('\n');
  //   //   DateTime ordertitleformatted2 = orderdatetimeformatted.toLocal();
  //   //   // print('ordertitledatetimeformatted2');
  //   //   // print(ordertitleformatted2);

  //   //   Duration differenceindatetime =
  //   //       orderdatetime.difference(currentDateTime1);
  //   //   var expirytime = const Duration(hours: -1);
  //   //   if (differenceindatetime <= expirytime) {
  //   //     _todosCollection.doc(undoneTodos[j].id).update({'isarchived': true});
  //   //   }
  //   //   // if (1 == 1) {
  //   //   //   BackgroundFetch.start().then((int status) {
  //   //   //     print('[BackgroundFetch] start success: $status');
  //   //   //   }).catchError((e) {
  //   //   //     print('[BackgroundFetch] start FAILURE: $e');
  //   //   //   });
  //   //   // }
  //   //   // print(differenceindatetime);
  //   // }
  //   print('it worked at last');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 600,
              height: 200,
              child: Image.asset('assets/icon/pwlogonobg.png'),
            ),
            // CircularProgressIndicator(
            //   strokeWidth: 3,
            //   valueColor: AlwaysStoppedAnimation(Color(0xff19c7c1))
            // ),
            Text("PROJECT MAKANGO",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Color(0xff7a939f),
                )),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xff7a939f)),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 60.0),
                      primary: Colors.white,
                      textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color(0xffddf2ff)),
                    ),
                    onPressed: () {
                      // archiver();
                      archiver2();
                      print('hi from aley');
                      check(context);
                      print('check from session has run');
                      // if (current != null) {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         DetailPage(todo: current, vendorName: "nil"),
                      //   ));
                      //   current = null;
                      // }
                    },
                    child: Text(
                      'Enter',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
