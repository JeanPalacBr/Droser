import 'package:flutter/material.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Catalog.dart';
import 'categories.dart';
import 'login.dart';

class NavDrawer extends StatelessWidget {
  @override
  String email = "Hola, Hubrt";
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Image(
                  width: 120,
                  image: AssetImage("assets/images/DroneLeaser.png"),
                ),
                Text(email,
                    style: TextStyle(fontSize: 25, color: Colors.white)),
              ],
            ),
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.blue[200], Colors.blue[400]],
                    stops: [0.1, 0.3, 0.7],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()))
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()))
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Mis rentas'),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
          ListTile(
            leading: Icon(Icons.admin_panel_settings_outlined),
            title: Text('Panel de control de renta'),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Catalogo'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Catalog()))
            },
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Categorias'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Categories()))
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Mensajes'),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text(
              'Cuponmania!!!',
              style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient),
            ),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {sharedpreflogoutset(context)},
          ),
          ListTile(
            title: Text('Acerca de Droser'),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
        ],
      ),
    );
  }

  Future<void> loadFromShared() async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();
    email = _sharedPrefs.getString("email");
  }

  void sharedpreflogoutset(BuildContext context) async {
    SharedPreferences _sharedPrefs;
    _sharedPrefs = await SharedPreferences.getInstance();
    _sharedPrefs.setString("email", "");
    _sharedPrefs.setString("tokn", "");
    _sharedPrefs.setString("userid", "");
    _sharedPrefs.clear();
    _sharedPrefs.remove("email");
    _sharedPrefs.remove("tokn");
    _sharedPrefs.remove("userid");
    islogd = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
}
