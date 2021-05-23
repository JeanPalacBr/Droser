import 'package:flutter/material.dart';
import 'package:lease_drones/UI/bubbleMess.dart';
import 'package:lease_drones/UI/cart.dart';
import 'package:lease_drones/UI/home.dart';
import 'package:lease_drones/UI/login.dart';
import 'package:lease_drones/Services/APIcon.dart';
import 'package:lease_drones/UI/navDrawer.dart';
import 'package:lease_drones/UI/searchResult.dart';

class Chat extends StatefulWidget {
  Chat();

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> strList = <String>[];
  List<bool> strListP = <bool>[];
  TextEditingController mensajeaenviar = new TextEditingController();
  TextEditingController busqueda = new TextEditingController();
  bool searching = false;
  bool encontrado = false;
  @override
  void initState() {
    super.initState();
  }

  _ChatState();
  Widget chatMessages() {
    return strList.length > 0
        ? ListView.builder(
            itemCount: strList.length,
            itemBuilder: (context, index) {
              return BurbujaMensaje(strList[index], strListP[index]);
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: !searching
            ? Text("Droser")
            : TextField(
                controller: busqueda,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    hintText: "Busca drones, artículos y más...",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white),
                onSubmitted: (busqueda) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(busqueda)));
                },
              ),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                  icon: !searching ? Icon(Icons.search) : Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.searching = !this.searching;
                      busqueda.clear();
                    });
                  }),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Carrito(carrito)));
                },
                icon: Icon(Icons.shopping_cart),
              )
            ],
          )
        ],
        backgroundColor: Colors.blue[400],
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                color: Colors.blue[400],
                child: Row(
                  children: [
                    Expanded(
                        child: containerText(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          autocorrect: true,
                          showCursor: true,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 2000,
                          controller: mensajeaenviar,
                          decoration: InputDecoration(
                              hintText: "Envíanos un mensaje...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                        onTap: () {
                          enviarmensajebtn();
                        },
                        child: Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  enviarmensajebtn() {
    droserBotCS(" Enviado por: " +
        usuario.nombre +
        "\n Email: " +
        usuario.email +
        "\n Telefono: " +
        usuario.telefono +
        "\n Mensaje: " +
        "\n " +
        mensajeaenviar.value.text);

    setState(() {
      strList.add(mensajeaenviar.value.text);
      mensajeaenviar.text = "";
      strListP.add(true);
      if (strList.length == 1) {
        strList.add("Hola " +
            usuario.nombre.split(" ")[0] +
            ", bienvenido al servicio al cliente de Droser, uno de nuestros asesores le contactará muy pronto.");
        strListP.add(false);
      }
    });
  }

  Widget containerText(Widget widg) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: widg,
    );
  }
}
