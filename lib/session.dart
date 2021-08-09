import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'loginpage.dart';
import 'vendor.dart';
import 'exceptions.dart';

class Session {
  final String _sessionId;
  final String _authToken;

  bool get invalid => _sessionId == null;

  const Session._(this._sessionId, this._authToken);

  const Session.invalid()
      : _sessionId = null,
        _authToken = null;

  factory Session.fromString(String string) {
    final sections = string.split('/');
    return Session._(sections[0], sections[1]);
  }

  factory Session.fromCookie(String cookie) {
    final sessionIdRe = RegExp(r'ASP.NET_SessionId=(.+?);');
    final authTokenRe = RegExp(r'AuthenticationToken=(.+?);');
    return Session._(
      sessionIdRe.firstMatch(cookie).group(1),
      authTokenRe.firstMatch(cookie).group(1),
    );
  }

  @override
  String toString() {
    if (invalid) throw InvalidSessionException();
    return '$_sessionId/$_authToken';
  }

  Map<String, String> toHeaders() {
    if (invalid) throw InvalidSessionException();
    return {
      'Cookie':
          'ASP.NET_SessionId=$_sessionId; AuthenticationToken=$_authToken',
      'Referer': 'https://iemb.hci.edu.sg',
    };
  }

  static Future<Session> create(String username, String password) async {
    // Get request verification tokens
    final tokenRes = await http.get(Uri.parse('https://iemb.hci.edu.sg/'));
    if (tokenRes.statusCode != 200) {
      if (tokenRes.statusCode == 500) throw InternalServerException();
      throw Exception('GET / failed with status ${tokenRes.statusCode}');
    }

    final tokenDoc = parse(tokenRes.body);
    final token = tokenDoc
        .getElementsByTagName('input')
        .singleWhere((element) =>
            element.attributes['name'] == '__RequestVerificationToken')
        .attributes['value'];
    final cookieTokenRe = RegExp(r'__RequestVerificationToken=(.+?);');
    final cookieToken =
        cookieTokenRe.firstMatch(tokenRes.headers['set-cookie']).group(1);

    // Attempt sign in
    final res = await http.post(
      Uri.parse('https://iemb.hci.edu.sg/home/logincheck'),
      body: {
        '__RequestVerificationToken': token,
        'UserName': username,
        'Password': password,
        'submitbut': 'Submit',
      },
      headers: {
        'Referer': 'https://iemb.hci.edu.sg/',
        'Cookie': '__RequestVerificationToken=$cookieToken',
      },
    );
    if (res.statusCode != 302) {
      if (res.statusCode == 500) throw InternalServerException();
      throw Exception(
          'POST /home/logincheck failed with status ${res.statusCode}');
    }

    final doc = parse(res.body);
    final redirect = doc.getElementsByTagName('a').first.attributes['href'];
    if (redirect != '/Board/BoardList') {
      if (redirect == '/?errorMessage=Login%20Failed')
        throw InvalidCredentialsException();
      throw Exception('POST /home/logincheck failed with url $redirect');
    }
    return Session.fromCookie(res.headers['set-cookie']);
  }

  Future<bool> validate() async {
    final res = await http.get(
        Uri.parse('https://iemb.hci.edu.sg/Board/BoardList'),
        headers: toHeaders());
    if (res.statusCode != 200) {
      if (res.statusCode == 500) throw InternalServerException();
      throw Exception(
          'GET /Board/BoardList failed with status ${res.statusCode}');
    }

    final doc = parse(res.body);
    return doc.getElementsByClassName('login-page').isEmpty;
  }

  Future<void> signOut() async {
    if (invalid) return;
    final res = await http.get(Uri.parse('https://iemb.hci.edu.sg/home/logout'),
        headers: toHeaders());
    if (res.statusCode != 200) {
      if (res.statusCode == 500) throw InternalServerException();
      throw Exception('GET /home/logout failed with status ${res.statusCode}');
    }
  }
}

String usernameVal = "";
bool checkPresent = true;
read() async {
  final prefs = await SharedPreferences.getInstance();
  usernameVal = prefs.getString('username');
}

save(text) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('username', text);
  print(usernameVal);
}

remove() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  // prefs.remove("username");
}

check(context) async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getString("username") == null ||
      prefs.getString("username") == "") {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  } else if (prefs.getString("username") == "Drinks" ||
      prefs.getString("username") == "ChickenRice" ||
      prefs.getString("username") == "EconomicRice" ||
      prefs.getString("username") == "JapKorean" ||
      prefs.getString("username") == "Muslim" ||
      prefs.getString("username") == "Noodles" ||
      prefs.getString("username") == "Pasta" ||
      prefs.getString("username") == "Spinach" ||
      prefs.getString("username") == "Western") {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SummarisedOrders()));
  } else {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }
  // if (checkPresent == false){
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(builder:(context) => LoginPage())
  //   );
  // } else if(checkPresent == true){
  //     await Navigator.of(context).push(
  //       MaterialPageRoute(builder:(context)=> HomePage())
  //   );
  // }
}
