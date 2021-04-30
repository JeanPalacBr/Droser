class UsuarioRegistrado {
  String nombre;
  String email;
  int documento;
  String direccion;
  String telefono;
  int idperfilusuario;
  String ciudad;

  UsuarioRegistrado(
      {this.documento,
      this.nombre,
      this.email,
      this.direccion,
      this.telefono,
      this.ciudad,
      this.idperfilusuario});

  factory UsuarioRegistrado.fromJson(Map<String, dynamic> json) {
    return UsuarioRegistrado(
      nombre: json['name'],
      email: json['email'],
      direccion: json['direccion'],
    );
  }
}

class UsuarioLog {
  String token;
  String email;
  int id;

  UsuarioLog({this.token, this.id, this.email});
  factory UsuarioLog.fromJson(Map<dynamic, dynamic> json) {
    return UsuarioLog(
        token: json['token'], id: json['id'], email: json["email"]);
  }
}
