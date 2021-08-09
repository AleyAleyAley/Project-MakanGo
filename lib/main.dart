import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makangoagain/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'detail.dart';
import 'menu.dart';
import 'session.dart';
import 'package:intl/intl.dart';
import 'startup.dart';
import 'studentdrawer.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// final navKey = new GlobalKey<NavigatorState>();
DocumentSnapshot current;
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
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();

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

//   // // int undonetodolength = undoneTodos.length;
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

//   //   Duration differenceindatetime = orderdatetime.difference(currentDateTime1);
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

Future<void> archiver() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('first check');
  final prefs = await SharedPreferences.getInstance();

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
      // final notifications = GlobalKey<_NotifsState>();
      Duration differenceindatetime =
          orderdatetime.difference(currentDateTime1);
      var expirytime = const Duration(hours: -1);
      print('LOL DOING ON NDP HOLIS BE LIKE');
      if (differenceindatetime <= expirytime) {
        // _todosCollection.doc(doc.id).update({'isarchived': true});
        _todosCollection
            .doc((doc['title'] + "   " + doc['user']).toString())
            .update({'isarchived': true});
      }

      var expirytime2 = const Duration(minutes: 30);
      var expirytime3 = const Duration(minutes: 0);
      read();
      print('about to check');
      // print(differenceindatetime.toString());
      print(doc['user']);
      usernameVal = prefs.getString('username');
      print(usernameVal);
      print(differenceindatetime <= expirytime2);
      print(differenceindatetime >= expirytime3);
      if (differenceindatetime <= expirytime2 &&
          doc['isNotified'] == false &&
          doc['user'] == usernameVal &&
          differenceindatetime >= expirytime3) {
        print('need notif here');
        // notifications.currentState.showNotification(differenceindatetime.toString());
        String changeddifferenceindatetime =
            differenceindatetime.inMinutes.toString();
        showNotification(changeddifferenceindatetime.toString(),
            differenceindatetime.inMinutes);
        print("got past this or not");
        current = doc;
        print('is current null');
        print(current == null);
        FirebaseFirestore.instance
            .collection('todos')
            .doc((doc['title'] + '   ' + doc['user']).toString())
            .update({'isNotified': true});
        print('can get past here pls');
      }

      print('ran for this doc');
    });
  });
}

void showNotification(String timeDiff, int itimeDiff) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    ('your channel id'),
    'your channel name',
    'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    styleInformation: BigTextStyleInformation(''),
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    itimeDiff,
    'Food Order',
    'Your food is ready to be collected in about $timeDiff minutes.',
    platformChannelSpecifics,
    payload: 'Default_Sound',
    // variable: hi,
  );
  print('small yee');
}

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print('[BackgroundFetch] Headless event received.');
  // Do your work here...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('ARCHIVER ABOUT TO RUN');
  await archiver();
  print('ARCHIVER() RAN');
  BackgroundFetch.finish(taskId);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Future onSelectNotification(String payload) async {
    print('on select notif');
    // if (current != null) {
    //   BuildContext context;
    //   await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => DetailPage(todo: current, vendorName: "nil"),
    //   ));
    //   current = null;
    // }
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String title, String body, String payload) async {},
  );
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification

      //      ((String payload) async {
      //   // print('ONSELECTNOTIFACTION');
      //   // if (current != null) {
      //   //   print('attempted to go to detailpage');
      //   //   BuildContext context;
      //   //   await Navigator.of(context).push(MaterialPageRoute(
      //   //     builder: (context) => DetailPage(todo: current, vendorName: "nil"),
      //   //   ));
      //   // print('YEE');
      //   // navKey.currentState.push(MaterialPageRoute(
      //   //     builder: (context) => DetailPage(todo: current, vendorName: 'nil')));
      //   // print('bigger yee');
      //   if (payload != null) {
      //     debugPrint('notification payload: ' + payload);
      //   }
      // })
      );

  // await Firebase.initializeApp();
  runApp(MyApp());
  BackgroundFetch.start();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [
    DateTime.now(),
  ];

  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: true,
            startOnBoot: true,
            forceAlarmManager: false,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) async {
      // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      setState(() {
        // _events.insert(0, new DateTime.now());
      });
      print('SERIOUSLY bruh, still not here');
      archiver();
      print('pls do work');
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch] configure success: $status');
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project MakanGo',
      home: StartUpView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// This widget is the root of your application.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<QuerySnapshot> _getTodos;

  DateTime currentDate = DateTime.now();
  DateTime formatedDate = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond));

  // DateTime firstdatetimelimiter= new DateTime(currentDate.year, );
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialdatetry = (DateTime.now().add(const Duration(days: 1)));
    print(initialdatetry.weekday);
    if (initialdatetry.weekday == 6) {
      initialdatetry = initialdatetry.add(const Duration(days: 2));
      print(initialdatetry);
    }
    if (initialdatetry.weekday == 7) {
      initialdatetry = initialdatetry.add(const Duration(days: 1));
      print('added 1 day due to sunday');
      print(initialdatetry);
    }
    print(initialdatetry);
    final DateTime pickedDate = await showDatePicker(
        selectableDayPredicate: (DateTime val) =>
            val.weekday == 6 || val.weekday == 7 ? false : true,
        context: context,
        initialDate: initialdatetry,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime.now().add(
          const Duration(days: 14),
        ));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  DateTime currenthour = new DateTime(DateTime.now().hour);
  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().toLocal().hour + 3, minute: 00);
  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getTodos = FirebaseFirestore.instance.collection('todos').get();
  }

  void _refreshTodos() {
    archiver2();
    setState(() {
      _getTodos = FirebaseFirestore.instance.collection('todos').get();
    });
  }

  final _todosCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Widget build(BuildContext context) {
    BackgroundFetch.start();

    // if (current != null) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => DetailPage(todo: current, vendorName: "nil"),
    //   ));
    //   current = null;
    // }

    read();
    return new WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          // backgroundColor: Color(0xffddf2ff),
          appBar: AppBar(
            backgroundColor: Color(0xff7a939f),
            // title:Text('PROJECT MAKANGO\nORDERS'),

            title: RichText(
              // textAlign: TextAlign.right,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "\nOrders\n",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xffddf2ff),
                    ),
                  ),
                ],
              ),
            ),
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xff7a939f),
            foregroundColor: Color(0xffddf2ff),
            onPressed: () async {
              var _cancelled = 1;
              // final titleController = TextEditingController();
              // final descriptionController = TextEditingController();
              reset();

              final completed = await showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(
                      'Send Order',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        color: Color(0xff7a939f),
                      ),
                    ),
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff7a939f)),
                          child: Text(
                            'Date',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xffddf2ff),
                            ),
                          ),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff7a939f)),
                            child: Text('Time',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xffddf2ff))),
                            onPressed: () => _selectTime()),
                      ),

                      const Divider(
                        height: 20,
                        thickness: 5,
                        indent: 20,
                        endIndent: 20,
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Drinks
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Drinks.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Drinks",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showDrinksSelect(
                                  context, drinksItem, drinksMenu),
                            ),

                            //Spinach Soup
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Spinach.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Spinach Soup",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showSpinachSelect(
                                  context, spinachItem, spinachMenu),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Drinks
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Mixed.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Economic Rice",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showEconomicSelect(
                                  context, economicItem, economicRiceMenu),
                            ),

                            //Spinach Soup
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Noodles.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Noodles",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showNoodlesSelect(
                                  context, noodlesItem, noodlesMenu),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Drinks
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Chicken.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Chicken Rice",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showChickenSelect(
                                  context, chickenRiceItem, chickenRiceMenu),
                            ),

                            //Spinach Soup
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Jap.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Japanese & Korean",
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showJapKorSelect(
                                  context, japKoreanItem, japKoreanMenu),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Drinks
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/western.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Western",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showWesternSelect(
                                  context, westernItem, westernMenu),
                            ),

                            //Spinach Soup
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Pasta.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Pasta",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showPastaSelect(
                                  context, pastaItem, pastaMenu),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Drinks
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/icon/Muslim.png'),
                                              fit: BoxFit.fill),
                                          border: Border.all(
                                            color: Color(0xff7a939f),
                                            width: 2,
                                          ))),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 100,
                                    child: Text(
                                      "Muslim",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7a939f)),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () => showMuslimSelect(
                                  context, muslimItem, muslimMenu),
                            ),
                          ],
                        ),
                      ),

                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Drinks Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () =>
                      //       showDrinksSelect(context, drinksItem, drinksMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Spinach Soup Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showSpinachSelect(
                      //       context, spinachItem, spinachMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Economic Rice Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showEconomicSelect(
                      //       context, economicItem, economicRiceMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Noodles Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showNoodlesSelect(
                      //       context, noodlesItem, noodlesMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Chicken Rice Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showChickenSelect(
                      //       context, chickenRiceItem, chickenRiceMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Japanese and Korean Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showJapKorSelect(
                      //       context, japKoreanItem, japKoreanMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Western Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () => showWesternSelect(
                      //       context, westernItem, westernMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Pasta Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () =>
                      //       showPastaSelect(context, pastaItem, pastaMenu),
                      // ),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //       primary: Color(0xff7a939f)),
                      //   child: Text("Muslim Menu",
                      //       style: GoogleFonts.poppins(
                      //           fontWeight: FontWeight.normal,
                      //           color: Color(0xffddf2ff))),
                      //   onPressed: () =>
                      //       showMuslimSelect(context, muslimItem, muslimMenu),
                      // ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff7a939f)),
                          child: Text('Done',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffddf2ff))),
                          onPressed: () {
                            Navigator.pop(context, true);
                            _cancelled = 0;
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff7a939f)),
                          child: Text('Cancel',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffddf2ff))),
                          onPressed: () {
                            Navigator.pop(context, true);
                            _cancelled = 1;
                          },
                        ),
                      )
                    ],
                  );
                },
              );
              var chosendates = currentDate.toLocal();
              var chosendatetime = new DateTime(
                chosendates.year,
                chosendates.month,
                chosendates.day,
                _time.hour,
                _time.minute,
              );

              String formattedDate2 = DateFormat('dd-MM-yyyy - H:mm')
                  .format(chosendatetime)
                  .toString();

              if ((completed == true) && (_cancelled != 1)) {
                await FirebaseFirestore.instance
                    .collection('todos')
                    .doc('$formattedDate2   $usernameVal')
                    .set({
                  "title": ('$formattedDate2'),
                  // "description": descriptionController.text,
                  "ChickenRice": chickenRice,
                  "Drinks": drinks,
                  "EconomicRice": economicRice,
                  "JapKorean": japKorean,
                  "Muslim": muslim,
                  "Noodles": noodles,
                  "Pasta": pasta,
                  "Spinach": spinach,
                  "Western": western,
                  "isDone": false,
                  "user": usernameVal,
                  "isarchived": false,
                  "isNotified": false,
                });
                _refreshTodos();
              }
            },
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: _getTodos,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final undoneTodos = snapshot.data.docs
                  .where((DocumentSnapshot document) =>
                      document.data()['user'] == usernameVal &&
                      document.data()['isarchived'] == false)
                  .toList();
              int undonetodolength = undoneTodos.length;
              for (int j = 0; j < undonetodolength; j++) {
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

                var datetimeofloopedthroughthing =
                    undoneTodos[j].data()["title"];
                // print('\n');
                // print('title of document snapshot');
                // print(datetimeofloopedthroughthing);
                // print('\n');
                DateTime orderdatetime = DateFormat('dd-MM-yyyy - H:mm')
                    .parse(datetimeofloopedthroughthing);
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
                DateTime ordertitleformatted2 =
                    orderdatetimeformatted.toLocal();
                // print('ordertitledatetimeformatted2');
                // print(ordertitleformatted2);

                Duration differenceindatetime =
                    orderdatetime.difference(currentDateTime1);
                var expirytime = const Duration(hours: -1);
                if (differenceindatetime <= expirytime) {
                  _todosCollection
                      .doc(undoneTodos[j].id)
                      .update({'isarchived': true});
                }
                // print(differenceindatetime);
              }
              if (undoneTodos.isEmpty != true) {
                return ListView.separated(
                  itemCount: undoneTodos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        undoneTodos[index].data()["title"],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          color: Color(0xff7a939f),
                        ),
                      ),
                      trailing:
                          Icon(Icons.arrow_forward, color: Color(0xff7a939f)),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(
                              todo: undoneTodos[index], vendorName: "nil"),
                        ));
                        _refreshTodos();
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                );
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
            },
          ),
        ));
  }
}

class archive extends StatefulWidget {
  @override
  _archiveState createState() => _archiveState();
}

class _archiveState extends State<archive> {
  Future<QuerySnapshot> _getTodos;

  @override
  void initState() {
    super.initState();
    _getTodos = FirebaseFirestore.instance.collection('todos').get();
  }

  void _refreshTodos() {
    setState(() {
      _getTodos = FirebaseFirestore.instance.collection('todos').get();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff7a939f),
        title: Text("Order History",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Color(0xffddf2ff),
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
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('is current null');
          print(current == null);
          // if (current != null) {
          //   print('stinky');
          //   Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) =>
          //         DetailPage(todo: current, vendorName: "nil"),
          //   ));
          //   current = null;
          // }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // final archivedTodos = snapshot.data.docs
          //     .where((DocumentSnapshot document) =>
          //         document.data()['user'] == usernameVal &&
          //         document.data()['isarchived'] == true)
          //     .toList();
          final archivedTodos = snapshot.data.docs
              .where((DocumentSnapshot document) =>
                  document.data()['user'] == usernameVal &&
                  document.data()['isarchived'] == true)
              .toList();

          // print(archivedTodos.isEmpty);
          if (archivedTodos.isEmpty == false) {
            return ListView.separated(
              itemCount: archivedTodos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    archivedTodos[index].data()["title"],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal,
                      color: Color(0xff7a939f),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Color(0xff7a939f)),
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailPage(
                          todo: archivedTodos[index], vendorName: "nil"),
                    ));
                    _refreshTodos();
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
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
        },
      ),
    );
  }
}

// class Notifs extends StatefulWidget {
//   @override
//   _NotifsState createState() => _NotifsState();
// }

// class _NotifsState extends State<Notifs> {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   get onSelectNotificationPlugin => null;
//   @override
//   initState() {
//     super.initState();
//     var initializationSettingsAndroid =
//         new AndroidInitializationSettings('app_icon');

//     var initializationSettingsIOS = new IOSInitializationSettings();

//     var initializationSettings = new InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//     flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Future showNotification(String timeDiff) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Food Order',
//       'Your food is ready to be collected in $timeDiff minutes.',
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }

//   Future selectNotification(String payload) async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => HomePage()),
//     );
//   }
// }
