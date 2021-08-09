import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//=====from stackoverflow========
class MultiSelectDialogItem<V> {
  const MultiSelectDialogItem(this.value, this.label);

  final V value;
  final String label;
}

class MultiSelectDialog<V> extends StatefulWidget {
  MultiSelectDialog({Key key, this.items, this.initialSelectedValues})
      : super(key: key);

  final List<MultiSelectDialogItem<V>> items;
  final Set<V> initialSelectedValues;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
}

class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
  final _selectedValues = Set<V>();

  void initState() {
    super.initState();
    if (widget.initialSelectedValues != null) {
      _selectedValues.addAll(widget.initialSelectedValues);
    }
  }

  void _onItemCheckedChange(V itemValue, bool checked) {
    setState(() {
      if (checked) {
        _selectedValues.add(itemValue);
      } else {
        _selectedValues.remove(itemValue);
      }
    });
  }

  void _onCancelTap() {
    Navigator.pop(context);
  }

  void _onSubmitTap() {
    Navigator.pop(context, _selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Food',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.normal,
          color: Color(0xff7a939f),
        ),
      ),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          textColor: Color(0xff7a939f),
          iconColor: Color(0xff7a939f),
          child: ListBody(
            children: widget.items.map(_buildItem).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
             style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Color(0xff7a939f),
            ),
          ),
          onPressed: _onCancelTap,
        ),
        FlatButton(
          child: Text(
            'OK',
             style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
              color: Color(0xff7a939f),
            ),
          ),
          onPressed: _onSubmitTap,
        )
      ],
    );
  }

  Widget _buildItem(MultiSelectDialogItem<V> item) {
    final checked = _selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) => _onItemCheckedChange(item.value, checked),
    );
  }
}
//================

List<MultiSelectDialogItem<int>> drinksItem = List();
List<MultiSelectDialogItem<int>> spinachItem = List();
List<MultiSelectDialogItem<int>> economicItem = List();
List<MultiSelectDialogItem<int>> chickenRiceItem = List();
List<MultiSelectDialogItem<int>> japKoreanItem = List();
List<MultiSelectDialogItem<int>> westernItem = List();
List<MultiSelectDialogItem<int>> pastaItem = List();
List<MultiSelectDialogItem<int>> muslimItem = List();
List<MultiSelectDialogItem<int>> noodlesItem = List();

final noodles = [];
final drinks = [];
final spinach = [];
final economicRice = [];
final chickenRice = [];
final japKorean = [];
final western = [];
final pasta = [];
final muslim = [];

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

// final valuestopopulate = {
// };

void populateMultiselect(
    valuestopopulate, List<MultiSelectDialogItem<int>> items) {
  for (var v in valuestopopulate.keys) {
    items.add(MultiSelectDialogItem(v, valuestopopulate[v]));
  }
}

//===========Drinks Stall============
void drinksgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      drinks.add(valuestopopulate[x]);
    }
  }
}

void showDrinksSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  drinks.clear();
  drinksgetvaluefromkey(selectedValues, valuestopopulate);
}

//===========Noodles Stall========
void noodlesgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      noodles.add(valuestopopulate[x]);
    }
  }
}

void showNoodlesSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  noodles.clear();
  noodlesgetvaluefromkey(selectedValues, valuestopopulate);
}

//==========Spinach Soup==========
void spinachgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      spinach.add(valuestopopulate[x]);
    }
  }
}

void showSpinachSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  spinach.clear();
  spinachgetvaluefromkey(selectedValues, valuestopopulate);
}

//===========Economic Rice==========
void economicgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      economicRice.add(valuestopopulate[x]);
    }
  }
}

void showEconomicSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  economicRice.clear();
  economicgetvaluefromkey(selectedValues, valuestopopulate);
}

//==========Chicken Rice==========
void chickengetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      chickenRice.add(valuestopopulate[x]);
    }
  }
}

void showChickenSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  chickenRice.clear();
  chickengetvaluefromkey(selectedValues, valuestopopulate);
}

//==========Japanese and Korean==========
void japkorgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      japKorean.add(valuestopopulate[x]);
    }
  }
}

void showJapKorSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  japKorean.clear();
  japkorgetvaluefromkey(selectedValues, valuestopopulate);
}

//==========Western Stall=========
void westerngetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      western.add(valuestopopulate[x]);
    }
  }
}

void showWesternSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  western.clear();
  westerngetvaluefromkey(selectedValues, valuestopopulate);
}

//=========Pasta Stall========
void pastagetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      pasta.add(valuestopopulate[x]);
    }
  }
}

void showPastaSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  pasta.clear();
  pastagetvaluefromkey(selectedValues, valuestopopulate);
}

//==========Muslim Stall==========
void muslimgetvaluefromkey(Set selection, valuestopopulate) {
  if (selection != null) {
    for (int x in selection.toList()) {
      muslim.add(valuestopopulate[x]);
    }
  }
}

void showMuslimSelect(BuildContext context,
    List<MultiSelectDialogItem<int>> item, valuestopopulate) async {
  item = [];
  populateMultiselect(valuestopopulate, item);
  final items = item;
  final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
        );
      });
  muslim.clear();
  muslimgetvaluefromkey(selectedValues, valuestopopulate);
}

//=======

void reset() {
  if (drinks != []) {
    drinks.clear();
  }
  if (spinach != []) {
    spinach.clear();
  }
  if (economicRice != []) {
    economicRice.clear();
  }
  if (noodles != []) {
    noodles.clear();
  }
  if (chickenRice != []) {
    chickenRice.clear();
  }
  if (japKorean != []) {
    japKorean.clear();
  }
  if (pasta != []) {
    pasta.clear();
  }
  if (western != []) {
    western.clear();
  }
  if (muslim != []) {
    muslim.clear();
  }
}
