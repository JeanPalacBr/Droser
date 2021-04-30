import 'package:flutter/material.dart';
import 'package:lease_drones/Models/userRegistered.dart';
import 'package:lease_drones/UI/navDrawer.dart';

class DetailOfert extends StatefulWidget {
  int idOfert;
  DetailOfert({Key key, int idOfert}) : super(key: key);
  @override
  DetailOfertstate createState() => DetailOfertstate(this.idOfert);
}

class DetailOfertstate extends State<DetailOfert> {
  int idOfert;
  int profidcourse;
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

  DetailOfertstate(int idOfert);
  //List<Student> studentsL = new List<Student>();
  //final acState = Provider.of<AccountState>(contextsc);
  @override
  void initState() {
    super.initState();
    //FocusScope.of(context).requestFocus(new FocusNode());
    usuario = UsuarioRegistrado(
        direccion: "Cra 22 # 11-12",
        documento: 11111,
        email: "asd@un.com",
        nombre: "Drone quadcoptero DJI BoxMaster 5000",
        telefono: "+57123123",
        ciudad: "Soledad",
        idperfilusuario: 1);
    //if (logged) {
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
                "",
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
                  "Email: " + usuario.email,
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
          Image.network(
            "https://media.istockphoto.com/photos/delivery-drone-with-box-picture-id637413978?k=6&m=637413978&s=612x612&w=0&h=cSlShuU_9YjMzEWJKy4pvenI922DefkiISMPAqAik3A=",
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
}
