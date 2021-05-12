class Aviso {
  String description;
  String days;
  DateTime alarmDateTime;
  bool active;
  Aviso({this.description, this.days, this.active, this.alarmDateTime});

  factory Aviso.fromMap(Map<String, dynamic> json) => Aviso(
        description: json["description"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        active: json["active"],
      );
  Map<String, dynamic> toMap(Aviso aviso) => {
        "description": description,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "active": active,
      };
}
