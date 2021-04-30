import 'package:flutter/material.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';

class ProfessorDetails extends StatefulWidget {
  int profeid;
  String username;
  String token;
  bool logged;

  ProfessorDetails(
      {Key key, this.profeid, this.username, this.token, this.logged})
      : super(key: key);
  @override
  ProfessorDetailsstate createState() => ProfessorDetailsstate(
      profeid: profeid, username: username, logged: logged, token: token);
}

class ProfessorDetailsstate extends State<ProfessorDetails> {
  int profeid;
  int profidcourse;
  String emailed;
  String usename;
  String useemail;
  String usephone;
  String usecity;
  //String country;
  UsuarioRegistrado usuario;
  String profbirthday;
  String username;
  String token;
  bool logged = true;
  ProfessorDetailsstate({this.profeid, this.username, this.token, this.logged});
  //List<Student> studentsL = new List<Student>();
  //final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    loadFromShared();
    super.initState();
    //FocusScope.of(context).requestFocus(new FocusNode());
    usuario = UsuarioRegistrado(
        direccion: "Cra 22 # 11-12",
        documento: 11111,
        email: "asd@un.com",
        nombre: "Pedrinho",
        telefono: "+57123123",
        ciudad: "Soledad",
        idperfilusuario: 1);
    //if (logged) {
    ProfessorDetailsstate();
    //} else {
    //   Islogged();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Droser"),
          backgroundColor: Colors.indigo[700],
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 18, 0),
              child: Text(
                emailed,
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ),
          ]),
      drawer: NavDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          headerWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 36, 8, 15),
            child: Row(
              children: <Widget>[
                Icon(Icons.confirmation_number),
                Text(
                  "Documento de identidad: " + usuario.documento.toString(),
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.alternate_email),
                Text(
                  "Email: " + emailed,
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.phone),
                Text(
                  "Teléfono: " + usuario.telefono,
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_on),
                Text(
                  "Dirección: " + usuario.direccion,
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.location_city),
                Text(
                  "Ciudad: " + usuario.ciudad.toString(),
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Icon(Icons.date_range),
                Text(
                  "Birthday: 15/04/1999",
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return new Card(
      elevation: 3,
      color: Colors.indigo[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Center(
            child: new Container(
              margin: EdgeInsets.only(bottom: 5.0),
              height: 20.0,
              width: 80.0,
            ),
          ),
          Text(
            'Perfil de usuario',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Image.network(
            "https://scontent.fctg1-3.fna.fbcdn.net/v/t1.6435-9/37043851_10216044568609042_7828755675776811008_n.jpg?_nc_cat=100&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeGY3V07QAhtuPHoxR0RqZwI8t6iWEKq69ry3qJYQqrr2kiDhhYYzPpd2XcLOPbRSP-VPFJulkG3pB_NBMuVyRuu&_nc_ohc=PR4xY9PS1V0AX8nmAuL&_nc_ht=scontent.fctg1-3.fna&oh=1f678cb1fac53cb33a86a362a79520f9&oe=60AF3BF5",
            width: 200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Text(
              " " + usuario.nombre.toString(),
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    //flex: 1,
  }

  Future<void> loadFromShared() async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();

    emailed = _sharedPrefs.getString("email");
    if (emailed == null) {
      emailed = "esnull";
    }
  }

  void sharedreflogoutset() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString("tokn", "");
    sharedpref.setString("usrname", "");
    sharedpref.setBool("isloggeda", false);
  }
}
