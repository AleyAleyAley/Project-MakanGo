import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import "package:makangoagain/menu.dart";
import "session.dart";
import 'main.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key key, @required this.todo, this.vendorName}) : super(key: key);
  DateTime currentDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
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
    if (pickedDate != null && pickedDate != currentDate) {
      currentDate = pickedDate;
    }
  }

  DateTime currenthour = new DateTime(DateTime.now().hour);
  TimeOfDay _time =
      TimeOfDay(hour: DateTime.now().toLocal().hour + 3, minute: 00);
  void selectTime(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      _time = newTime;
      ;
    }
  }

  var orders = [
    '', //drinks 0
    '', //pasta 1
    '', //spinach 2
    '', //chicken 3
    '', //economic 4
    '', //japanandkorean 5
    '', //muslim 6
    '', //noodle 7
    '', //western 8
    '', //total value
  ];
  var orderschecker = [
    '', //drinks 0
    '', //pasta 1
    '', //spinach 2
    '', //chicken 3
    '', //economic 4
    '', //japanandkorean 5
    '', //muslim 6
    '', //noodle 7
    '', //western 8
  ];
  final String vendorName;
  final DocumentSnapshot todo;
  final _todosCollection = FirebaseFirestore.instance.collection('todos');
  Future<QuerySnapshot> _getTodos;

  // Future<void> _markAsDone(BuildContext context) async {
  //   await _todosCollection.doc(todo.id).update({'isDone': true});
  //   Navigator.of(context).pop();
  // }

  Future<void> _delete(BuildContext context) async {
    await _todosCollection.doc(todo.id).delete();
    Navigator.of(context).pop();
  }

  Future _reorder(BuildContext context) async {}

  var muslimPrice = {"Nasi Lemak": '2.50', "Nasi Briyani": '3.50'};

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

  @override
  Widget build(BuildContext context) {
    var _orderedFood = "";
    var _totalCost = 0.00;

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

    void _getOrdered() {
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

      final stallName = [
        'Drink Stall',
        'Pasta Stall',
        'Spinach Soup',
        'Chicken Rice',
        'Economic Rice',
        'Japanese and Korean',
        'Muslim Stall',
        'Noodle Stall',
        'Western Stall'
      ];

      if (vendorName == "nil") {
        for (var j = 0; j < 9; j++) {
          if (todo.data()[stalls[j]].length != 0) {
            for (var i in (todo.data()[stalls[j]])) {
              orders[j] = orders[j] +
                  '• ' +
                  i +
                  ' - ' +
                  ' \$' +
                  stallPrices[j][i] +
                  "\n";
              var cost = double.parse(stallPrices[j][i]);
              _totalCost += cost;
            }
            if (orders[j] != '') {
              orders[j] = orders[j] + '\n';
            }
          }
        }
        var stringCost = _totalCost.toStringAsFixed(2);
        orders[9] = "Total Cost: \$" + stringCost;
      } else {
        for (var k in todo.data()[vendorName]) {
          _orderedFood = _orderedFood + '• ' + k + "\n";
        }
        _orderedFood = _orderedFood + '\n';
      }
    }

    _getOrdered();
    if (orders[0] != '') {
      orderschecker[0] = 'Drinks Stall' + '\n';
    }
    if (orders[1] != '') {
      orderschecker[1] = 'Pasta Stall' + '\n';
    }
    if (orders[2] != '') {
      orderschecker[2] = 'Spinach Soup' + '\n';
    }
    if (orders[3] != '') {
      orderschecker[3] = 'Chicken Rice' + '\n';
    }
    if (orders[4] != '') {
      orderschecker[4] = 'Economic Rice' + '\n';
    }
    if (orders[5] != '') {
      orderschecker[5] = 'Japanese and Korean' + '\n';
    }
    if (orders[6] != '') {
      orderschecker[6] = 'Muslim Stall' + '\n';
    }
    if (orders[7] != '') {
      orderschecker[7] = 'Noodle Stall' + '\n';
    }
    if (orders[8] != '') {
      orderschecker[8] = 'Western Stall' + '\n';
    }

    if (vendorName == "nil" && todo.data()["isarchived"] == false) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff7a939f),
            actions: [
              IconButton(
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
                            'Re-order',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff7a939f),
                            ),
                          ),
                          children: [
                            // TextField(
                            //   controller: titleController,
                            //   decoration: InputDecoration(labelText: 'Date'),
                            // ),
                            // TextField(
                            //   controller: descriptionController,
                            //   decoration: InputDecoration(labelText: 'Description'),
                            // ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff7a939f)),
                              child: Text(
                                'Date',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffddf2ff),
                                ),
                              ),
                              onPressed: () => selectDate(context),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff7a939f)),
                                child: Text('Time',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffddf2ff))),
                                onPressed: () => selectTime(context)),

                            TextButton(
                              child: Text('Done',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff7a939f))),
                              onPressed: () {
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                                _cancelled = 0;
                              },
                            ),
                            TextButton(
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff7a939f))),
                              onPressed: () {
                                Navigator.pop(context, true);
                                _cancelled = 1;
                              },
                            ),
                          ],
                        );
                      },
                    );

                    var chosendates = currentDate.toLocal();
                    print('chosendates' '$chosendates');
                    var chosendatetime = new DateTime(
                      chosendates.year,
                      chosendates.month,
                      chosendates.day,
                      _time.hour,
                      _time.minute,
                    );
                    print('chosendatetime:');
                    print('$chosendatetime');
                    String formattedDate2 =
                        DateFormat('dd-MM-yyyy - H:mm').format(chosendatetime);
                    print('formatteddatetime2');
                    print('$formattedDate2');
                    if ((completed == true) && (_cancelled != 1)) {
                      await FirebaseFirestore.instance
                          .collection('todos')
                          .doc('$formattedDate2   $usernameVal')
                          .set({
                        "title": ('$formattedDate2'),
                        // "description": descriptionController.text,
                        "ChickenRice": todo.data()['ChickenRice'],
                        "Drinks": todo.data()['Drinks'],
                        "EconomicRice": todo.data()['EconomicRice'],
                        "JapKorean": todo.data()['JapKorean'],
                        "Muslim": todo.data()['Muslim'],
                        "Noodles": todo.data()['Noodles'],
                        "Pasta": todo.data()['Pasta'],
                        "Spinach": todo.data()['Spinach'],
                        "Western": todo.data()['Western'],
                        "isDone": false,
                        "isarchived": false,
                        "isNotified":false,
                        "user": usernameVal,
                      });
                    }
                  },
                  icon: Icon(Icons.low_priority)),
              IconButton(
                icon: Icon(Icons.edit),
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
                          'Edit Order',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        children: [
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
                                  onTap: () => showChickenSelect(context,
                                      chickenRiceItem, chickenRiceMenu),
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

                  String formattedDate2 = (todo.data()['title']);
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
                      "isarchived": false,
                      "isNotified":false,
                      "user": usernameVal,
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _delete(context),
              ),
              // if (!todo.data()["isDone"])
              //   IconButton(
              //     icon: Icon(Icons.done),
              //     onPressed: () => _markAsDone(context),
              //   ),
            ],
          ),
          body: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    todo.data()["title"],
                    style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7a939f)),
                  ),
                ),
                // ListTile(
                //   title: Text(todo.data()["description"]),
                // ),
                ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: '',
                      children: <TextSpan>[
                        // TextSpan(
                        //   text: 'Ordered Food\n',
                        //   style: GoogleFonts.poppins(
                        //     decoration: TextDecoration.underline,
                        //     fontWeight: FontWeight.bold,
                        //     color: Color(0xff7a939f),
                        //   ),
                        // ),

                        TextSpan(
                          text: orderschecker[0],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[0],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[1],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[1],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[2],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[2],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[3],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[3],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[4],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[4],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[5],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[5],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[6],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[6],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[7],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[7],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[8],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[8],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[9],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    } else if (vendorName != "nil") {
      return (Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff7a939f),
            actions: [
              // if (!todo.data()["isDone"])
              //   IconButton(
              //     icon: Icon(Icons.done),
              //     onPressed: () => _markAsDone(context),
              //   ),
            ],
          ),
          body: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    todo.data()["title"],
                    style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7a939f)),
                  ),
                ),
                // ListTile(
                //   title: Text(todo.data()["description"]),
                // ),
                ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Ordered Food\n',
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: _orderedFood,
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        )
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff7a939f),
            actions: [
              IconButton(
                  padding: EdgeInsets.only(right: 10),
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
                            'Re-order',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              color: Color(0xff7a939f),
                            ),
                          ),
                          children: [
                            // TextField(
                            //   controller: titleController,
                            //   decoration: InputDecoration(labelText: 'Date'),
                            // ),
                            // TextField(
                            //   controller: descriptionController,
                            //   decoration: InputDecoration(labelText: 'Description'),
                            // ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff7a939f)),
                              child: Text(
                                'Date',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xffddf2ff),
                                ),
                              ),
                              onPressed: () => selectDate(context),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff7a939f)),
                                child: Text('Time',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffddf2ff))),
                                onPressed: () => selectTime(context)),

                            TextButton(
                              child: Text('Done',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff7a939f))),
                              onPressed: () {
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                                _cancelled = 0;
                              },
                            ),
                            TextButton(
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff7a939f))),
                              onPressed: () {
                                Navigator.pop(context, true);
                                _cancelled = 1;
                              },
                            ),
                          ],
                        );
                      },
                    );

                    var chosendates = currentDate.toLocal();
                    print('chosendates' '$chosendates');
                    var chosendatetime = new DateTime(
                      chosendates.year,
                      chosendates.month,
                      chosendates.day,
                      _time.hour,
                      _time.minute,
                    );
                    print('chosendatetime:');
                    print('$chosendatetime');
                    String formattedDate2 =
                        DateFormat('dd-MM-yyyy - H:mm').format(chosendatetime);
                    print('formatteddatetime2');
                    print('$formattedDate2');
                    if ((completed == true) && (_cancelled != 1)) {
                      await FirebaseFirestore.instance
                          .collection('todos')
                          .doc('$formattedDate2   $usernameVal')
                          .set({
                        "title": ('$formattedDate2'),
                        // "description": descriptionController.text,
                        "ChickenRice": todo.data()['ChickenRice'],
                        "Drinks": todo.data()['Drinks'],
                        "EconomicRice": todo.data()['EconomicRice'],
                        "JapKorean": todo.data()['JapKorean'],
                        "Muslim": todo.data()['Muslim'],
                        "Noodles": todo.data()['Noodles'],
                        "Pasta": todo.data()['Pasta'],
                        "Spinach": todo.data()['Spinach'],
                        "Western": todo.data()['Western'],
                        "isDone": false,
                        "isarchived": false,
                        "isNotified":false,
                        "user": usernameVal,
                      });
                    }
                  },
                  icon: Icon(Icons.low_priority)),
              // IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () async {
              //     var _cancelled = 1;
              //     // final titleController = TextEditingController();
              //     // final descriptionController = TextEditingController();
              //     reset();

              //     final completed = await showDialog(
              //       context: context,
              //       builder: (context) {
              //         return SimpleDialog(
              //           contentPadding: EdgeInsets.all(8.0),
              //           title: Text(
              //             'Edit Order',
              //             style: GoogleFonts.poppins(
              //               fontWeight: FontWeight.normal,
              //               color: Color(0xff7a939f),
              //             ),
              //           ),
              //           children: [
              //             // TextField(
              //             //   controller: titleController,
              //             //   decoration: InputDecoration(labelText: 'Date'),
              //             // ),
              //             // TextField(
              //             //   controller: descriptionController,
              //             //   decoration: InputDecoration(labelText: 'Description'),
              //             // ),

              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Drinks Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showDrinksSelect(
              //                   context, drinksItem, drinksMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Spinach Soup Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showSpinachSelect(
              //                   context, spinachItem, spinachMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Economic Rice Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showEconomicSelect(
              //                   context, economicItem, economicRiceMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Noodles Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showNoodlesSelect(
              //                   context, noodlesItem, noodlesMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Chicken Rice Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showChickenSelect(
              //                   context, chickenRiceItem, chickenRiceMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Japanese and Korean Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showJapKorSelect(
              //                   context, japKoreanItem, japKoreanMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Western Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showWesternSelect(
              //                   context, westernItem, westernMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Pasta Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () =>
              //                   showPastaSelect(context, pastaItem, pastaMenu),
              //             ),
              //             ElevatedButton(
              //               style: ElevatedButton.styleFrom(
              //                   primary: Color(0xff7a939f)),
              //               child: Text("Muslim Menu",
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xffddf2ff))),
              //               onPressed: () => showMuslimSelect(
              //                   context, muslimItem, muslimMenu),
              //             ),

              //             TextButton(
              //               child: Text('Done',
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xff7a939f))),
              //               onPressed: () {
              //                 Navigator.pop(context, true);
              //                 Navigator.pop(context, true);
              //                 _cancelled = 0;
              //               },
              //             ),
              //             TextButton(
              //               child: Text('Cancel',
              //                   style: GoogleFonts.poppins(
              //                       fontWeight: FontWeight.normal,
              //                       color: Color(0xff7a939f))),
              //               onPressed: () {
              //                 Navigator.pop(context, true);
              //                 _cancelled = 1;
              //               },
              //             ),
              //           ],
              //         );
              //       },
              //     );

              //     String formattedDate2 = (todo.data()['title']);
              //     if ((completed == true) && (_cancelled != 1)) {
              //       await FirebaseFirestore.instance
              //           .collection('todos')
              //           .doc('$formattedDate2   $usernameVal')
              //           .set({
              //         "title": ('$formattedDate2'),
              //         // "description": descriptionController.text,
              //         "ChickenRice": chickenRice,
              //         "Drinks": drinks,
              //         "EconomicRice": economicRice,
              //         "JapKorean": japKorean,
              //         "Muslim": muslim,
              //         "Noodles": noodles,
              //         "Pasta": pasta,
              //         "Spinach": spinach,
              //         "Western": western,
              //         "isDone": false,
              //         "isarchived": false,
              //         "user": usernameVal,
              //       });
              //     }
              //   },
              // ),
              // IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () => _delete(context),
              // ),
              // // if (!todo.data()["isDone"])
              // //   IconButton(
              // //     icon: Icon(Icons.done),
              // //     onPressed: () => _markAsDone(context),
              // //   ),
            ],
          ),
          body: Container(
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    todo.data()["title"],
                    style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7a939f)),
                  ),
                ),
                // ListTile(
                //   title: Text(todo.data()["description"]),
                // ),
                ListTile(
                  title: Text.rich(
                    TextSpan(
                      text: '',
                      children: <TextSpan>[
                        // TextSpan(
                        //   text: 'Ordered Food\n',
                        //   style: GoogleFonts.poppins(
                        //     decoration: TextDecoration.underline,
                        //     fontWeight: FontWeight.bold,
                        //     color: Color(0xff7a939f),
                        //   ),
                        // ),

                        TextSpan(
                          text: orderschecker[0],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[0],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[1],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[1],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[2],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[2],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[3],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[3],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[4],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[4],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[5],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[5],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[6],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[6],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[7],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[7],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orderschecker[8],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[8],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        TextSpan(
                          text: orders[9],
                          style: GoogleFonts.poppins(
                            color: Color(0xff7a939f),
                          ),
                        ),
                        // can add more TextSpans here...
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    }
  }

  void setState(Null Function() param0) {}
}
