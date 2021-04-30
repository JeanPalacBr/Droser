import 'package:flutter/material.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlEstados with ChangeNotifier {
  ControlEstados();
  bool _isLogged = false;
  String _email;
  String documentDeLogged;
  bool rememberme = false;

  void setLoggedin(String email, bool log, bool remember) async {
    String exist = "";
    try {
      //  fireDB.getInfoUsuario(_email).then((logDB) {
      //  logUSDB = logDB;
      // });
      // documentDeLogged = logUSDB.documents[0].documentID;
    } catch (e) {
      print(e.toString());
    }
    // SharedPreferences sharedpref = await SharedPreferences.getInstance();
    //exist = await sharedemailget() ?? "";
    if (exist.length != 0) {
      // _isLogged = await sharedLoggedget();
      // _email = await sharedemailget();
      // documentDeLogged = await sharedDocumentget();
    } else {
      _email = email;
      _isLogged = log;
    }
    if (remember) {
      // sharedLoggedset(log);
      // sharedemailset(email);
      // sharedDocumentset(documentDeLogged);
    }

    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setDocument(String document) {
    documentDeLogged = document;
    notifyListeners();
  }

  void setLogged(bool log) {
    _isLogged = log;
    notifyListeners();
  }

  void setRememberMe(bool remember) {
    rememberme = remember;
    notifyListeners();
  }

  void setLogout() {
    _isLogged = false;
    Islogged();
    notifyListeners();
  }

  bool get getlogin => _isLogged;
  String get getEmail => _email;
  String get getDocument => documentDeLogged;
  bool get getrememberMe => rememberme;

  // Future<String> sharedemailget() async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.getString("email");
  // }

  // Future<String> sharedDocumentget() async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.getString("document");
  // }

  // Future<bool> sharedLoggedget() async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.getBool("isloggeda") ?? false;
  // }

  // Future<bool> sharedemailset(String email) async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.setString("email", email);
  // }

  // Future<bool> sharedDocumentset(String document) async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.setString("document", document);
  // }

  // Future<bool> sharedLoggedset(bool log) async {
  //   SharedPreferences sharedpref = await SharedPreferences.getInstance();
  //   return sharedpref.setBool("isloggeda", log);
  // }
}
