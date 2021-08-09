import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:makangoagain/loginpage.dart';
import 'session.dart';
import 'detail.dart';
import 'vendorDrawer.dart';

class VendorView extends StatefulWidget {
  final vendor;
  VendorView({Key key, this.vendor}) : super(key: key);

  @override
  VendorViewState createState() => VendorViewState();
}

class VendorViewState extends State<VendorView> {
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

  @override
  Widget build(BuildContext context) {
    read();
    return new WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              backgroundColor: Color(0xff7a939f),
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
            drawer: AppDrawer(),
            // drawer: Drawer(
            //   child:ListView(
            //     children:<Widget>[
            //        ListTile(
            //         tileColor: Color(0xff7a939f),
            //         title: Text(
            //           "Change Details",
            //           style: GoogleFonts.poppins(
            //             fontWeight:FontWeight.w500,
            //             color:Color(0xffddf2ff)
            //           ),
            //         ),
            //         onTap:(){
            //           Navigator.of(context).pop();
            //           Navigator.push(context, MaterialPageRoute(
            //             builder: (BuildContext context) => ChangeDetails())
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),

            body: FutureBuilder<QuerySnapshot>(
                future: _getTodos,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  final _undoneTodos = snapshot.data.docs
                      .where((DocumentSnapshot document) =>
                          document.data()[usernameVal].isEmpty == false &&
                          document.data()['isarchived'] == false)
                      .toList();
                  print('THNIGS ARE STILL WELL');
                  if (_undoneTodos.isEmpty == false) {
                    return ListView.separated(
                      itemCount: _undoneTodos.length,
                      // ignore: missing_return
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            _undoneTodos[index].data()["title"] +
                                " " +
                                _undoneTodos[index].data()["user"],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff7a939f),
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Color(0xff7a939f)),
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  todo: _undoneTodos[index],
                                  vendorName: usernameVal),
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
                })));
  }
}

class ArchivedVendorView extends StatefulWidget {
  final vendor;
  ArchivedVendorView({Key key, this.vendor}) : super(key: key);

  @override
  ArchivedVendorViewState createState() => ArchivedVendorViewState();
}

class ArchivedVendorViewState extends State<ArchivedVendorView> {
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

  @override
  Widget build(BuildContext context) {
    read();
    return new WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              backgroundColor: Color(0xff7a939f),
              title: RichText(
                // textAlign: TextAlign.right,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "\nOrder History\n",
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
            drawer: AppDrawer(),
            // drawer: Drawer(
            //   child:ListView(
            //     children:<Widget>[
            //        ListTile(
            //         tileColor: Color(0xff7a939f),
            //         title: Text(
            //           "Change Details",
            //           style: GoogleFonts.poppins(
            //             fontWeight:FontWeight.w500,
            //             color:Color(0xffddf2ff)
            //           ),
            //         ),
            //         onTap:(){
            //           Navigator.of(context).pop();
            //           Navigator.push(context, MaterialPageRoute(
            //             builder: (BuildContext context) => ChangeDetails())
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),

            body: FutureBuilder<QuerySnapshot>(
                future: _getTodos,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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

                  final _undoneTodos = snapshot.data.docs
                      .where((DocumentSnapshot document) =>
                          document.data()[usernameVal].isEmpty == false &&
                          document.data()['isarchived'] == true)
                      .toList();
                  print('THNIGS ARE STILL WELL');
                  if (_undoneTodos.isEmpty == false) {
                    return ListView.separated(
                      itemCount: _undoneTodos.length,
                      // ignore: missing_return
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            _undoneTodos[index].data()["title"] +
                                " " +
                                _undoneTodos[index].data()["user"],
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff7a939f),
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward,
                              color: Color(0xff7a939f)),
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  todo: _undoneTodos[index],
                                  vendorName: usernameVal),
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
                })));
  }
}

class ChangeDetails extends StatefulWidget {
  @override
  _ChangeDetailsState createState() => _ChangeDetailsState();
}

class _ChangeDetailsState extends State<ChangeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xff7a939f),
            title: Text("Change Details",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xffddf2ff),
                ))),
        drawer: AppDrawer(),
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 30),
            SizedBox(
              width: 320,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 60.0),
                    primary: Color(0xff7a939f),
                    textStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Color(0xffddf2ff)),
                  ),
                  onPressed: () async {
                    final completed2 = await showDialog(
                        context: context,
                        builder: (context) {
                          return simpleDialog("Password", "password", context,
                              newPasswordController, confirmPasswordController);
                        });
                    if (completed2 == true) {
                      if (_isPasswordmatched == true) {
                        await FirebaseFirestore.instance
                            .collection("vendorNames")
                            .doc(usernameVal)
                            .update({
                          "password": newPasswordController.text,
                        });
                        newPasswordController.clear();
                        confirmPasswordController.clear();

                        _isPasswordmatchedText = "New password saved";
                        setState(() {});
                        await Future.delayed(Duration(seconds: 3));
                        _isPasswordmatchedText = "";
                        setState(() {});
                      } else {
                        newPasswordController.clear();
                        confirmPasswordController.clear();
                        _isPasswordmatchedText = "Passwords do not match";
                        setState(() {});
                        await Future.delayed(Duration(seconds: 3));
                        _isPasswordmatchedText = "";
                        setState(() {});
                      }
                    } else {
                      newPasswordController.clear();
                      confirmPasswordController.clear();
                    }
                  },
                  child: Text("Change Password",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color(0xffddf2ff)))),
            ),
            SizedBox(height: 10),
            Text(_isUsernamematchedText,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.red)),
            Text(_isPasswordmatchedText,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, color: Colors.red)),
          ],
        )));
  }
}

final newUsernameController = TextEditingController();
final confirmUsernameController = TextEditingController();
final newPasswordController = TextEditingController();
final confirmPasswordController = TextEditingController();
var _isUsernamematched = true;
var _isUsernamematchedText = "";

var _isPasswordmatched = true;
var _isPasswordmatchedText = "";

Widget simpleDialog(
    typeCap, typeLower, context, newController, confirmController) {
  return SimpleDialog(
    contentPadding: EdgeInsets.all(8.0),
    title: Text(
      'Change ' + typeCap,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        color: Color(0xff7a939f),
      ),
    ),
    children: [
      TextField(
        controller: newController,
        decoration: InputDecoration(
            labelText: "Enter a new " + typeLower,
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.normal, color: Color(0xff7a939f))),
      ),
      TextField(
        controller: confirmController,
        decoration: InputDecoration(
            labelText: "Confirm your new " + typeLower,
            labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.normal, color: Color(0xff7a939f))),
      ),
      TextButton(
          child: Text(
            "Done",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Color(0xff7a939f),
            ),
          ),
          onPressed: () {
            if (typeCap == "Username") {
              if (newController.text == confirmController.text &&
                  newController.text != "" &&
                  confirmController.text != "") {
                _isUsernamematched = true;
              } else {
                _isUsernamematched = false;
              }
            } else if (typeCap == "Password") {
              if (newController.text == confirmController.text &&
                  newController.text != "" &&
                  confirmController.text != "") {
                _isPasswordmatched = true;
              } else {
                _isPasswordmatched = false;
              }
            }
            Navigator.pop(context, true);
          }),
    ],
  );
}

class SummarisedOrders extends StatefulWidget {
  final vendor;
  SummarisedOrders({Key key, this.vendor}) : super(key: key);

  @override
  _SummarisedOrdersState createState() => _SummarisedOrdersState();
}

class _SummarisedOrdersState extends State<SummarisedOrders> {
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
    print(usernameVal);
  }

  @override
  @override
  Widget build(BuildContext context) {
    read();
    return new WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: Color(0xff7a939f),
            title: RichText(
              // textAlign: TextAlign.right,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "\nSummary\n",
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
          drawer: AppDrawer(),
          // drawer: Drawer(
          //   child:ListView(
          //     children:<Widget>[
          //        ListTile(
          //         tileColor: Color(0xff7a939f),
          //         title: Text(
          //           "Change Details",
          //           style: GoogleFonts.poppins(
          //             fontWeight:FontWeight.w500,
          //             color:Color(0xffddf2ff)
          //           ),
          //         ),
          //         onTap:(){
          //           Navigator.of(context).pop();
          //           Navigator.push(context, MaterialPageRoute(
          //             builder: (BuildContext context) => ChangeDetails())
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          body: FutureBuilder<QuerySnapshot>(
              future: _getTodos,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var muslimPrice = {
                  "Nasi Lemak": '2.50',
                  "Nasi Briyani": '3.50'
                };

                var noodlesPrice = {
                  'Minced Meat Noodes Dry - Mee Pok ': '2.80',
                  'Minced Meat Noodles Soup - Mee Pok': '2.80',
                  'Minced Meat Noodles Dry - Mee Kia': '2.80',
                  'Minced Meat Noodles Soup - Mee Kia': '2.80',
                  'Minced Meat Noodles Dry - Kuay Teow': '2.80',
                  'Minced Meat Noodles Soup - Kuay Teow': '2.80',
                  'Fishball Noodles Dry - Mee Pok': '2.80',
                  'Fishball Noodles Soup - Mee Pok': '2.80',
                  'Fishball Noodles Dry - Mee Kia': '2.80',
                  'Fishball Noodles Soup - Mee Kia': '2.80',
                  'Fishball Noodles Dry - Kuay Teow': '2.80',
                  'Fishball Noodles Soup - Kuay Teow': '2.80',
                  'Shanghai Noodles - Mee Pok': '2.80',
                  'Shanghai Noodles - Mee Kia': '2.80',
                  'Shanghai Noodles - Kuay Teow': '2.80',
                };

                var drinksPrice = {
                  'Red Bean Bun': '0.60',
                  'Coconut Bun': '0.60',
                  'Kaya Bun': '0.60',
                  'Cream Bun': '0.80',
                  'Homemade Soya Bean Curd': '1.20',
                  'Sandwich': '1.30',
                  'Kaya Toast (2pc)': '1.00',
                  'Breakfast Set (Milo)': '2.40',
                  'Breakfast Set (Coffee)': '2.20',
                  'Breakfast Set (Tea)': '2.20',
                };

                var spinachPrice = {
                  'Spinach Seafood Soup - Thin Bee Hoon': '4.50',
                  'Spinach Seafood Soup - Koka Noodle': '5.00',
                  'Spinach Seafood Soup - White Rice': '4.50',
                  'Spinach Yong Tau Foo Soup - Thin Bee Hoon': '4.00',
                  'Spinach Yong Tau Foo Soup - Koka Noodle': '4.50',
                  'Spinach Yong Tau Foo Soup - White Rice': '4.00',
                  'Spinach Century & Salted Egg Soup - Thin Bee Hoon': '4.00',
                  'Spinach Century & Salted Egg Soup - Koka Noodle': '4.50',
                  'Spinach Century & Salted Egg Soup - White Rice': '4.00',
                  'Signature Spinach Soup - Thin Bee Hoon': '5.50',
                  'Signature Spinach Soup - Koka Noodle': '6.00',
                  'Signature Spinach Soup - White Rice': '5.50',
                  'Sliced Fish Spinach Soup - Thin Bee Hoon': '4.50',
                  'Sliced Fish Spinach Soup - Koka Noodle': '5.00',
                  'Sliced Fish Spinach Soup - White Rice': '4.50',
                  'Meatball Spinach Soup - Thin Bee Hoon': '4.50',
                  'Meatball Spinach Soup - Koka Noodle': '5.00',
                  'Meatball Spinach Soup - White Rice': '4.50',
                };

                var economicRicePrice = {
                  '1菜 + 1肉 + 饭': '2.30',
                  '2菜 + 1肉 + 饭': '2.70',
                  '1菜 + 2肉 + 饭': '3.20',
                  '2菜 + 2肉 + 饭': '3.70',
                  '2菜 + 3肉 + 饭': '4.20',
                };

                var chickenRicePrice = {
                  'Steamed Chicken Rice': '2.70',
                  'Roasted Chicken Rice': '2.70',
                  'Chicken Char Siew Rice': '2.70',
                  'Black Pepper Chicken Rice': '2.70',
                  'Curry Chicken Rice': '2.70',
                  'Shredded Chicken Hor Fun': '2.70',
                  'Chicken Chop Noodle': '2.70',
                  'Chicken Char Siew Noodle': '2.70',
                };

                var japKoreanPrice = {
                  'Black Pepper Chicken Set': '3.80',
                  'Black Pepper Pork Set': '3.80',
                  'BBQ Chicken Set': '3.80',
                  'BBQ Pork Set': '3.80',
                  'BBQ Pork + Saba Fish Set': '4.30',
                  'BBQ Chicken + Saba Fish Set': '4.30',
                  'Saba Fish Set': '4.30',
                  'Salmon Teriyaki Set': '4.30',
                  'Chicken Ranyeon': '3.30',
                  'Seafood Ranyeon': '4.30',
                  'Korean Spicy Fried Noodle': '3.80',
                };

                var westernPrice = {
                  'Chicken Chop Set': '3.80',
                  'Fish and Chips Set': '3.80',
                  'Chicken Cutlet Set': '3.80',
                  'Beef Steak Set': '5.10',
                  'Chicken Chop Rice': '3.80',
                  'Chicken Cutlet Rice': '3.80',
                  'Fish Fillet Rice': '4.30',
                  'Beef Steak Rice': '5.10',
                  'Chicken Popcorn Rice': '3.80',
                  'Chicken Burger': '2.80',
                  'Fish Burger': '2.80',
                };

                var pastaPrice = {
                  'Aglio Olio': '2.80',
                  'Aglio Olio with Ham': '3.80',
                  'Aglio Olio with Hotdog': '3.80',
                  'Aglio Olio with Prawn': '4.30',
                  'Chicken Aglio': '3.80',
                  'Carbonara': '3.80',
                  'Creamy Chicken': '3.80',
                  'Meatball Pasta': '3.80',
                  'Chicken Cheese Sausage': '3.80',
                  'Chicken Chop Pasta': '4.30',
                  'Fish Pasta': '4.30',
                };
                final stallPrices = [
                  drinksPrice,
                  pastaPrice,
                  spinachPrice,
                  chickenRicePrice,
                  economicRicePrice,
                  japKoreanPrice,
                  muslimPrice,
                  noodlesPrice,
                  westernPrice,
                ];
                final stalls = [
                  'Drinks',
                  'Pasta',
                  'Spinach',
                  'ChickenRice',
                  'EconomicRice',
                  'JapKorean',
                  'Muslim',
                  'Noodles',
                  'Western'
                ];
                // final stallName = [
                //   'Drink Stall',
                //   'Pasta Stall',
                //   'Spinach Soup',
                //   'Chicken Rice',
                //   'Economic Rice',
                //   'Japanese and Korean',
                //   'Muslim Stall',
                //   'Noodle Stall',
                //   'Western Stall'
                // ];
                print('HELLO CHECKPOINT 1');
                var shortenedDate =
                    new DateTime.now().add((const Duration(days: 1)));
                var datetimenow =
                    DateFormat('dd-MM-yyyy').format(shortenedDate).toString();

                var shortenedDateToday = new DateTime.now();
                var datetimenowToday = DateFormat('dd-MM-yyyy')
                    .format(shortenedDateToday)
                    .toString();

                print(shortenedDateToday);
                print(datetimenowToday);
                final _undoneTodos = snapshot.data.docs
                    .where((DocumentSnapshot document) =>
                        document.data()['user'].isEmpty == false &&
                        document.data()['isarchived'] == false &&
                        (document.data()['title'].substring(0, 10) ==
                            datetimenow))
                    .toList();

                print(_undoneTodos);
                final _undoneTodosToday = snapshot.data.docs
                    .where((DocumentSnapshot document) =>
                        document.data()['user'].isEmpty == false &&
                        document.data()['isarchived'] == false &&
                        (document.data()['title'].substring(0, 10) ==
                            datetimenowToday))
                    .toList();

                print('Hello checkpoint 2');

                var noodlesMenuMap = {
                  'Minced Meat Noodes Dry - Mee Pok ': 0,
                  'Minced Meat Noodles Soup - Mee Pok': 0,
                  'Minced Meat Noodles Dry - Mee Kia': 0,
                  'Minced Meat Noodles Soup - Mee Kia': 0,
                  'Minced Meat Noodles Dry - Kuay Teow': 0,
                  'Minced Meat Noodles Soup - Kuay Teow': 0,
                  'Fishball Noodles Dry - Mee Pok': 0,
                  'Fishball Noodles Soup - Mee Pok': 0,
                  'Fishball Noodles Dry - Mee Kia': 0,
                  'Fishball Noodles Soup - Mee Kia': 0,
                  'Fishball Noodles Dry - Kuay Teow': 0,
                  'Fishball Noodles Soup - Kuay Teow': 0,
                  'Shanghai Noodles - Mee Pok': 0,
                  'Shanghai Noodles - Mee Kia': 0,
                  'Shanghai Noodles - Kuay Teow': 0,
                };

                var drinksMenuMap = {
                  'Red Bean Bun': 0,
                  'Coconut Bun': 0,
                  'Kaya Bun': 0,
                  'Cream Bun': 0,
                  'Homemade Soya Bean Curd': 0,
                  'Sandwich': 0,
                  'Kaya Toast (2pc)': 0,
                  'Breakfast Set (Milo)': 0,
                  'Breakfast Set (Coffee)': 0,
                  'Breakfast Set (Tea)': 0,
                };

                var spinachMenuMap = {
                  'Spinach Seafood Soup - Thin Bee Hoon': 0,
                  'Spinach Seafood Soup - Koka Noodle': 0,
                  'Spinach Seafood Soup - White Rice': 0,
                  'Spinach Yong Tau Foo Soup - Thin Bee Hoon': 0,
                  'Spinach Yong Tau Foo Soup - Koka Noodle': 0,
                  'Spinach Yong Tau Foo Soup - White Rice': 0,
                  'Spinach Century & Salted Egg Soup - Thin Bee Hoon': 0,
                  'Spinach Century & Salted Egg Soup - Koka Noodle': 0,
                  'Spinach Century & Salted Egg Soup - White Rice': 0,
                  'Signature Spinach Soup - Thin Bee Hoon': 0,
                  'Signature Spinach Soup - Koka Noodle': 0,
                  'Signature Spinach Soup - White Rice': 0,
                  'Sliced Fish Spinach Soup - Thin Bee Hoon': 0,
                  'Sliced Fish Spinach Soup - Koka Noodle': 0,
                  'Sliced Fish Spinach Soup - White Rice': 0,
                  'Meatball Spinach Soup - Thin Bee Hoon': 0,
                  'Meatball Spinach Soup - Koka Noodle': 0,
                  'Meatball Spinach Soup - White Rice': 0,
                };

                var economicRiceMenuMap = {
                  '1菜 + 1肉 + 饭': 0,
                  '2菜 + 1肉 + 饭': 0,
                  '1菜 + 2肉 + 饭': 0,
                  '2菜 + 2肉 + 饭': 0,
                  '2菜 + 3肉 + 饭': 0,
                };

                var chickenRiceMenuMap = {
                  'Steamed Chicken Rice': 0,
                  'Roasted Chicken Rice': 0,
                  'Chicken Char Siew Rice': 0,
                  'Black Pepper Chicken Rice': 0,
                  'Curry Chicken Rice': 0,
                  'Shredded Chicken Hor Fun': 0,
                  'Chicken Chop Noodle': 0,
                  'Chicken Char Siew Noodle': 0
                };

                var japKoreanMenuMap = {
                  'Black Pepper Chicken Set': 0,
                  'Black Pepper Pork Set': 0,
                  'BBQ Chicken Set': 0,
                  'BBQ Pork Set': 0,
                  'BBQ Pork + Saba Fish Set': 0,
                  'BBQ Chicken + Saba Fish Set': 0,
                  'Saba Fish Set': 0,
                  'Salmon Teriyaki Set': 0,
                  'Chicken Ranyeon': 0,
                  'Seafood Ranyeon': 0,
                  'Korean Spicy Fried Noodle': 0
                };
                var westernMenuMap = {
                  'Chicken Chop Set': 0,
                  'Fish and Chips Set': 0,
                  'Chicken Cutlet Set': 0,
                  'Beef Steak Set': 0,
                  'Chicken Chop Rice': 0,
                  'Chicken Cutlet Rice': 0,
                  'Fish Fillet Rice': 0,
                  'Beef Steak Rice': 0,
                  'Chicken Popcorn Rice': 0,
                  'Chicken Burger': 0,
                  'Fish Burger': 0,
                };

                var pastaMenuMap = {
                  'Aglio Olio': 0,
                  'Aglio Olio with Ham': 0,
                  'Aglio Olio with Hotdog': 0,
                  'Aglio Olio with Prawn': 0,
                  'Chicken Aglio': 0,
                  'Carbonara': 0,
                  'Creamy Chicken': 0,
                  'Meatball Pasta': 0,
                  'Chicken Cheese Sausage': 0,
                  'Chicken Chop Pasta': 0,
                  'Fish Pasta': 0,
                };

                var muslimMenuMap = {'Nasi Lemak': 0, 'Nasi Briyani': 0};

                var noodlesMenuMapToday = {
                  'Minced Meat Noodes Dry - Mee Pok ': 0,
                  'Minced Meat Noodles Soup - Mee Pok': 0,
                  'Minced Meat Noodles Dry - Mee Kia': 0,
                  'Minced Meat Noodles Soup - Mee Kia': 0,
                  'Minced Meat Noodles Dry - Kuay Teow': 0,
                  'Minced Meat Noodles Soup - Kuay Teow': 0,
                  'Fishball Noodles Dry - Mee Pok': 0,
                  'Fishball Noodles Soup - Mee Pok': 0,
                  'Fishball Noodles Dry - Mee Kia': 0,
                  'Fishball Noodles Soup - Mee Kia': 0,
                  'Fishball Noodles Dry - Kuay Teow': 0,
                  'Fishball Noodles Soup - Kuay Teow': 0,
                  'Shanghai Noodles - Mee Pok': 0,
                  'Shanghai Noodles - Mee Kia': 0,
                  'Shanghai Noodles - Kuay Teow': 0,
                };

                var drinksMenuMapToday = {
                  'Red Bean Bun': 0,
                  'Coconut Bun': 0,
                  'Kaya Bun': 0,
                  'Cream Bun': 0,
                  'Homemade Soya Bean Curd': 0,
                  'Sandwich': 0,
                  'Kaya Toast (2pc)': 0,
                  'Breakfast Set (Milo)': 0,
                  'Breakfast Set (Coffee)': 0,
                  'Breakfast Set (Tea)': 0,
                };

                var spinachMenuMapToday = {
                  'Spinach Seafood Soup - Thin Bee Hoon': 0,
                  'Spinach Seafood Soup - Koka Noodle': 0,
                  'Spinach Seafood Soup - White Rice': 0,
                  'Spinach Yong Tau Foo Soup - Thin Bee Hoon': 0,
                  'Spinach Yong Tau Foo Soup - Koka Noodle': 0,
                  'Spinach Yong Tau Foo Soup - White Rice': 0,
                  'Spinach Century & Salted Egg Soup - Thin Bee Hoon': 0,
                  'Spinach Century & Salted Egg Soup - Koka Noodle': 0,
                  'Spinach Century & Salted Egg Soup - White Rice': 0,
                  'Signature Spinach Soup - Thin Bee Hoon': 0,
                  'Signature Spinach Soup - Koka Noodle': 0,
                  'Signature Spinach Soup - White Rice': 0,
                  'Sliced Fish Spinach Soup - Thin Bee Hoon': 0,
                  'Sliced Fish Spinach Soup - Koka Noodle': 0,
                  'Sliced Fish Spinach Soup - White Rice': 0,
                  'Meatball Spinach Soup - Thin Bee Hoon': 0,
                  'Meatball Spinach Soup - Koka Noodle': 0,
                  'Meatball Spinach Soup - White Rice': 0,
                };

                var economicRiceMenuMapToday = {
                  '1菜 + 1肉 + 饭': 0,
                  '2菜 + 1肉 + 饭': 0,
                  '1菜 + 2肉 + 饭': 0,
                  '2菜 + 2肉 + 饭': 0,
                  '2菜 + 3肉 + 饭': 0,
                };

                var chickenRiceMenuMapToday = {
                  'Steamed Chicken Rice': 0,
                  'Roasted Chicken Rice': 0,
                  'Chicken Char Siew Rice': 0,
                  'Black Pepper Chicken Rice': 0,
                  'Curry Chicken Rice': 0,
                  'Shredded Chicken Hor Fun': 0,
                  'Chicken Chop Noodle': 0,
                  'Chicken Char Siew Noodle': 0
                };

                var japKoreanMenuMapToday = {
                  'Black Pepper Chicken Set': 0,
                  'Black Pepper Pork Set': 0,
                  'BBQ Chicken Set': 0,
                  'BBQ Pork Set': 0,
                  'BBQ Pork + Saba Fish Set': 0,
                  'BBQ Chicken + Saba Fish Set': 0,
                  'Saba Fish Set': 0,
                  'Salmon Teriyaki Set': 0,
                  'Chicken Ranyeon': 0,
                  'Seafood Ranyeon': 0,
                  'Korean Spicy Fried Noodle': 0
                };
                var westernMenuMapToday = {
                  'Chicken Chop Set': 0,
                  'Fish and Chips Set': 0,
                  'Chicken Cutlet Set': 0,
                  'Beef Steak Set': 0,
                  'Chicken Chop Rice': 0,
                  'Chicken Cutlet Rice': 0,
                  'Fish Fillet Rice': 0,
                  'Beef Steak Rice': 0,
                  'Chicken Popcorn Rice': 0,
                  'Chicken Burger': 0,
                  'Fish Burger': 0,
                };

                var pastaMenuMapToday = {
                  'Aglio Olio': 0,
                  'Aglio Olio with Ham': 0,
                  'Aglio Olio with Hotdog': 0,
                  'Aglio Olio with Prawn': 0,
                  'Chicken Aglio': 0,
                  'Carbonara': 0,
                  'Creamy Chicken': 0,
                  'Meatball Pasta': 0,
                  'Chicken Cheese Sausage': 0,
                  'Chicken Chop Pasta': 0,
                  'Fish Pasta': 0,
                };

                var muslimMenuMapToday = {'Nasi Lemak': 0, 'Nasi Briyani': 0};
                print('hellocheckpoint3');

                for (var lol in _undoneTodosToday) {
                  for (var g in lol[usernameVal]) {
                    if (usernameVal == 'Drinks') {
                      drinksMenuMapToday[g]++;
                    } else if (usernameVal == 'ChickenRice') {
                      chickenRiceMenuMapToday[g]++;
                    } else if (usernameVal == 'EconomicRice') {
                      economicRiceMenuMapToday[g]++;
                    } else if (usernameVal == 'JapKorean') {
                      japKoreanMenuMapToday[g]++;
                    } else if (usernameVal == 'Muslim') {
                      muslimMenuMapToday[g]++;
                    } else if (usernameVal == 'Noodles') {
                      noodlesMenuMapToday[g]++;
                    } else if (usernameVal == 'Pasta') {
                      pastaMenuMapToday[g]++;
                    } else if (usernameVal == 'Spinach') {
                      spinachMenuMapToday[g]++;
                    } else if (usernameVal == 'Western') {
                      westernMenuMapToday[g]++;
                    }
                  }
                }

                for (var lol in _undoneTodos) {
                  for (var g in lol[usernameVal]) {
                    if (usernameVal == 'Drinks') {
                      drinksMenuMap[g]++;
                    } else if (usernameVal == 'ChickenRice') {
                      chickenRiceMenuMap[g]++;
                    } else if (usernameVal == 'EconomicRice') {
                      economicRiceMenuMap[g]++;
                    } else if (usernameVal == 'JapKorean') {
                      japKoreanMenuMap[g]++;
                    } else if (usernameVal == 'Muslim') {
                      muslimMenuMap[g]++;
                    } else if (usernameVal == 'Noodles') {
                      noodlesMenuMap[g]++;
                    } else if (usernameVal == 'Pasta') {
                      pastaMenuMap[g]++;
                    } else if (usernameVal == 'Spinach') {
                      spinachMenuMap[g]++;
                    } else if (usernameVal == 'Western') {
                      westernMenuMap[g]++;
                    }
                  }
                }
                print('hellocheckpoint4');

                final noodlesMenu = {
                  1: 'Minced Meat Noodes Dry - Mee Pok ',
                  2: 'Minced Meat Noodles Soup - Mee Pok',
                  3: 'Minced Meat Noodles Dry - Mee Kia',
                  4: 'Minced Meat Noodles Soup - Mee Kia',
                  5: 'Minced Meat Noodles Dry - Kuay Teow',
                  6: 'Minced Meat Noodles Soup - Kuay Teow',
                  7: 'Fishball Noodles Dry - Mee Pok',
                  8: 'Fishball Noodles Soup - Mee Pok',
                  9: 'Fishball Noodles Dry - Mee Kia',
                  10: 'Fishball Noodles Soup - Mee Kia',
                  11: 'Fishball Noodles Dry - Kuay Teow',
                  12: 'Fishball Noodles Soup - Kuay Teow',
                  13: 'Shanghai Noodles - Mee Pok',
                  14: 'Shanghai Noodles - Mee Kia',
                  15: 'Shanghai Noodles - Kuay Teow',
                };

                final drinksMenu = {
                  1: 'Red Bean Bun',
                  2: 'Coconut Bun',
                  3: 'Kaya Bun',
                  4: 'Cream Bun',
                  5: 'Homemade Soya Bean Curd',
                  6: 'Sandwich',
                  7: 'Kaya Toast (2pc)',
                  8: 'Breakfast Set (Milo)',
                  9: 'Breakfast Set (Coffee)',
                  10: 'Breakfast Set (Tea)',
                };

                final spinachMenu = {
                  1: 'Spinach Seafood Soup - Thin Bee Hoon',
                  2: 'Spinach Seafood Soup - Koka Noodle',
                  3: 'Spinach Seafood Soup - White Rice',
                  4: 'Spinach Yong Tau Foo Soup - Thin Bee Hoon',
                  5: 'Spinach Yong Tau Foo Soup - Koka Noodle',
                  6: 'Spinach Yong Tau Foo Soup - White Rice',
                  7: 'Spinach Century & Salted Egg Soup - Thin Bee Hoon',
                  8: 'Spinach Century & Salted Egg Soup - Koka Noodle',
                  9: 'Spinach Century & Salted Egg Soup - White Rice',
                  10: 'Signature Spinach Soup - Thin Bee Hoon',
                  11: 'Signature Spinach Soup - Koka Noodle',
                  12: 'Signature Spinach Soup - White Rice',
                  13: 'Sliced Fish Spinach Soup - Thin Bee Hoon',
                  14: 'Sliced Fish Spinach Soup - Koka Noodle',
                  15: 'Sliced Fish Spinach Soup - White Rice',
                  16: 'Meatball Spinach Soup - Thin Bee Hoon',
                  17: 'Meatball Spinach Soup - Koka Noodle',
                  18: 'Meatball Spinach Soup - White Rice',
                };

                final economicRiceMenu = {
                  1: '1菜 + 1肉 + 饭',
                  2: '2菜 + 1肉 + 饭',
                  3: '1菜 + 2肉 + 饭',
                  4: '2菜 + 2肉 + 饭',
                  5: '2菜 + 3肉 + 饭',
                };

                final chickenRiceMenu = {
                  1: 'Steamed Chicken Rice',
                  2: 'Roasted Chicken Rice',
                  3: 'Chicken Char Siew Rice',
                  4: 'Black Pepper Chicken Rice',
                  5: 'Curry Chicken Rice',
                  6: 'Shredded Chicken Hor Fun',
                  7: 'Chicken Chop Noodle',
                  8: 'Chicken Char Siew Noodle'
                };

                final japKoreanMenu = {
                  1: 'Black Pepper Chicken Set',
                  2: 'Black Pepper Pork Set',
                  3: 'BBQ Chicken Set',
                  4: 'BBQ Pork Set',
                  5: 'BBQ Pork + Saba Fish Set',
                  6: 'BBQ Chicken + Saba Fish Set',
                  7: 'Saba Fish Set',
                  8: 'Salmon Teriyaki Set',
                  9: 'Chicken Ranyeon',
                  10: 'Seafood Ranyeon',
                  11: 'Korean Spicy Fried Noodle'
                };
                final westernMenu = {
                  1: 'Chicken Chop Set',
                  2: 'Fish and Chips Set',
                  3: 'Chicken Cutlet Set',
                  4: 'Beef Steak Set',
                  5: 'Chicken Chop Rice',
                  6: 'Chicken Cutlet Rice',
                  7: 'Fish Fillet Rice',
                  8: 'Beef Steak Rice',
                  9: 'Chicken Popcorn Rice',
                  10: 'Chicken Burger',
                  11: 'Fish Burger',
                };

                final pastaMenu = {
                  1: 'Aglio Olio',
                  2: 'Aglio Olio with Ham',
                  3: 'Aglio Olio with Hotdog',
                  4: 'Aglio Olio with Prawn',
                  5: 'Chicken Aglio',
                  6: 'Carbonara',
                  7: 'Creamy Chicken',
                  8: 'Meatball Pasta',
                  9: 'Chicken Cheese Sausage',
                  10: 'Chicken Chop Pasta',
                  11: 'Fish Pasta',
                };

                final muslimMenu = {1: 'Nasi Lemak', 2: 'Nasi Briyani'};
                print('hellocheckpoint5');

                String summaryToday = '';
                if (usernameVal == 'Drinks') {
                  for (int i = 1; i <= drinksMenu.length; i++) {
                    summaryToday = summaryToday +
                        drinksMenu[i] +
                        ': ' +
                        drinksMenuMapToday[drinksMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'ChickenRice') {
                  print('hellocheckpoint6');

                  for (int i = 1; i <= chickenRiceMenu.length; i++) {
                    print('hellocheckpoint7');
                    summaryToday = summaryToday +
                        chickenRiceMenu[i] +
                        ': ' +
                        chickenRiceMenuMapToday[chickenRiceMenu[i]].toString() +
                        '\n\n';
                    print('hellocheckpoint8');
                    print(i);
                  }
                } else if (usernameVal == 'EconomicRice') {
                  for (int i = 1; i <= economicRiceMenu.length; i++) {
                    summaryToday = summaryToday +
                        economicRiceMenu[i] +
                        ': ' +
                        economicRiceMenuMapToday[economicRiceMenu[i]]
                            .toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'JapKorean') {
                  for (int i = 1; i <= japKoreanMenu.length; i++) {
                    summaryToday = summaryToday +
                        japKoreanMenu[i] +
                        ': ' +
                        japKoreanMenuMapToday[japKoreanMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Muslim') {
                  for (int i = 1; i <= muslimMenu.length; i++) {
                    summaryToday = summaryToday +
                        muslimMenu[i] +
                        ': ' +
                        muslimMenuMapToday[muslimMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Noodles') {
                  for (int i = 1; i <= noodlesMenu.length; i++) {
                    summaryToday = summaryToday +
                        noodlesMenu[i] +
                        ': ' +
                        noodlesMenuMapToday[noodlesMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Pasta') {
                  for (int i = 1; i <= pastaMenu.length; i++) {
                    summaryToday = summaryToday +
                        pastaMenu[i] +
                        ': ' +
                        pastaMenuMapToday[pastaMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Spinach') {
                  for (int i = 1; i <= spinachMenu.length; i++) {
                    summaryToday = summaryToday +
                        spinachMenu[i] +
                        ': ' +
                        spinachMenuMapToday[spinachMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Western') {
                  for (int i = 1; i <= westernMenu.length; i++) {
                    summaryToday = summaryToday +
                        westernMenu[i] +
                        ': ' +
                        westernMenuMapToday[westernMenu[i]].toString() +
                        '\n\n';
                  }
                }

                String summary = '';
                if (usernameVal == 'Drinks') {
                  print("hello checkpoint L");
                  for (int i = 1; i <= drinksMenu.length; i++) {
                    summary = summary +
                        drinksMenu[i] +
                        ': ' +
                        drinksMenuMap[drinksMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'ChickenRice') {
                  print('hellocheckpoint6');

                  for (int i = 1; i <= chickenRiceMenu.length; i++) {
                    print('hellocheckpoint7');
                    summary = summary +
                        chickenRiceMenu[i] +
                        ': ' +
                        chickenRiceMenuMap[chickenRiceMenu[i]].toString() +
                        '\n\n';
                    print('hellocheckpoint8');
                    print(i);
                  }
                } else if (usernameVal == 'EconomicRice') {
                  for (int i = 1; i <= economicRiceMenu.length; i++) {
                    summary = summary +
                        economicRiceMenu[i] +
                        ': ' +
                        economicRiceMenuMap[economicRiceMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'JapKorean') {
                  for (int i = 1; i <= japKoreanMenu.length; i++) {
                    summary = summary +
                        japKoreanMenu[i] +
                        ': ' +
                        japKoreanMenuMap[japKoreanMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Muslim') {
                  for (int i = 1; i <= muslimMenu.length; i++) {
                    summary = summary +
                        muslimMenu[i] +
                        ': ' +
                        muslimMenuMap[muslimMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Noodles') {
                  for (int i = 1; i <= noodlesMenu.length; i++) {
                    summary = summary +
                        noodlesMenu[i] +
                        ': ' +
                        noodlesMenuMap[noodlesMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Pasta') {
                  for (int i = 1; i <= pastaMenu.length; i++) {
                    summary = summary +
                        pastaMenu[i] +
                        ': ' +
                        pastaMenuMap[pastaMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Spinach') {
                  for (int i = 1; i <= spinachMenu.length; i++) {
                    summary = summary +
                        spinachMenu[i] +
                        ': ' +
                        spinachMenuMap[spinachMenu[i]].toString() +
                        '\n\n';
                  }
                } else if (usernameVal == 'Western') {
                  for (int i = 1; i <= westernMenu.length; i++) {
                    summary = summary +
                        westernMenu[i] +
                        ': ' +
                        westernMenuMap[westernMenu[i]].toString() +
                        '\n\n';
                  }
                }
                print('hi');
                print(summary);
                return (Container(
                    child: ListView(children: [
                  ListTile(
                    title: Text(
                      'Orders for Today',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7a939f),
                          fontSize: 24,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      summaryToday,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        color: Color(0xff7a939f),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Orders for Tomorrow',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7a939f),
                          fontSize: 24,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      summary,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        color: Color(0xff7a939f),
                        fontSize: 18,
                      ),
                    ),
                  )
                ])));
                // return ListView.separated(
                //   itemCount: _undoneTodos.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     return ListTile(
                //       title: Text(
                //         _undoneTodos[index].data()["title"] +
                //             " " +
                //             _undoneTodos[index].data()["user"],
                //         style: GoogleFonts.poppins(
                //           fontWeight: FontWeight.normal,
                //           color: Color(0xff7a939f),
                //         ),
                //       ),
                //       trailing:
                //           Icon(Icons.arrow_forward, color: Color(0xff7a939f)),
                //       onTap: () async {
                //         await Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => DetailPage(
                //               todo: _undoneTodos[index],
                //               vendorName: usernameVal),
                //         ));
                //         _refreshTodos();
                //       },
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) {
                //     return const Divider();
                //   },
                // );
              })),
    );
  }
}
