import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vendor.dart';
import 'voting.dart';
import 'votingredone.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      _createHeader(),
      _createDrawerItem(
        icon: (Icons.apps_outlined),
        text: "Summarised Orders",
        onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SummarisedOrders())),
      ),
      _createDrawerItem(
          icon: Icons.assignment,
          text: "Detailed Orders",
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VendorView()))),
      _createDrawerItem(
          icon: Icons.history,
          text: "Order History",
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ArchivedVendorView()))),
      _createDrawerItem(
        icon: Icons.account_box,
        text: "Change Password",
        onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ChangeDetails())),
      ),
      _createDrawerItem(
          icon: Icons.star,
          text: "Rating",
          onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => VotingRedone())))
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
        Icon(icon, color: Color(0xFF898989)),
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
