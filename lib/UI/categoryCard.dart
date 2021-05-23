import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/modls.dart';
import 'package:lease_drones/UI/searchByCategory.dart';

class CategoryCard extends StatelessWidget {
  Category cat;
  CategoryCard(this.cat);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchByCategory(cat.id.toString())));
        },
        child: Card(
          margin: EdgeInsets.all(0),
          shadowColor: Colors.black,
          color: Colors.indigo[50],
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Image.network(
                    cat.imagen,
                    fit: BoxFit.fill,
                    width: 400,
                    height: 210,
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 175, 0, 0),
                    child: Text(
                      cat.nombre,
                      style: TextStyle(
                          backgroundColor: Colors.black45,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
