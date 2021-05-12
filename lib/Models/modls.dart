class UserInfo {
  final String token;
  final String username;
  final String name;

  UserInfo({this.token, this.username, this.name});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}

class Cities {
  String nombre;
  int idciudad;
  int estado;
  List<dynamic> data;

  Cities({this.nombre, this.idciudad, this.estado, this.data});

  factory Cities.fromJson(Map<dynamic, dynamic> json) {
    return Cities(
      nombre: json['nombre'],
      idciudad: json['idciudad'],
      estado: json['estado'],
      data: json["data"],
    );
  }
}

class City {
  String nombre;
  int idciudad;
  int estado;

  City({this.nombre, this.idciudad, this.estado});

  factory City.fromJson(Map<dynamic, dynamic> json) {
    return City(
      nombre: json['nombre'],
      idciudad: json['idciudad'],
      estado: json['estado'],
    );
  }
}

class IDocument {
  String nombre;
  int idtipo;
  int estado;

  IDocument({this.nombre, this.idtipo, this.estado});

  factory IDocument.fromJson(Map<dynamic, dynamic> json) {
    return IDocument(
      nombre: json['nombre'],
      idtipo: json['idtipo_documento'],
      estado: json['estado'],
    );
  }
}

class Category {
  String nombre;
  String imagen;
  String estado;
  String id;
  Category({this.nombre, this.estado, this.id, this.imagen});
}

class Ofert {
  String nombre;
  String categoria;
  String descripcion;
  String dto;
  int precio;
  int cantidad;
  String idarticulo;

  Ofert(
      {this.nombre,
      this.categoria,
      this.descripcion,
      this.dto,
      this.precio,
      this.cantidad,
      this.idarticulo});

  factory Ofert.fromJson(Map<dynamic, dynamic> json) {
    return Ofert(
        nombre: json['nombre'],
        categoria: json['categoria'],
        descripcion: json['descripcion'],
        precio: json['precio'],
        dto: json['dto'],
        cantidad: json['cantidad'],
        idarticulo: json['idarticulo']);
  }
}

class Coupon {
  String nombre;
  String codigo;
  int cantidad;
  int dcto;
  int estado;
  int idcupon;
  Coupon(
      {this.nombre,
      this.estado,
      this.idcupon,
      this.dcto,
      this.cantidad,
      this.codigo});
}

class Rent {
  String idarticulo;
  int cantidad;
  String fechaInicio;
  String horaInicio;
  String fechaFin;
  String horaFin;
  String direccionEntrega;
  int idcupon;
  String idciudad;
  int valor;
  Rent(
      {this.idarticulo,
      this.cantidad,
      this.fechaInicio,
      this.horaInicio,
      this.fechaFin,
      this.horaFin,
      this.direccionEntrega,
      this.idcupon,
      this.idciudad,
      this.valor});
}
