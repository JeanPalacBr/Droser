import 'package:flutter/material.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class NavDrawer extends StatelessWidget {
  @override
  String email = "Invitado";
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
            decoration: BoxDecoration(
              color: Colors.indigo[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfessorDetails()))
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
            leading: Icon(Icons.category),
            title: Text('Categorias'),
            //  onTap: () => {sharedreflogoutset(context)},
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Mensajes'),
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
    _sharedPrefs.setString("usrname", "");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }
}
