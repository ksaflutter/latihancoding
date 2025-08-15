class EventModel {
  int? id;
  String nama;
  String email;
  String event;
  String kota;
  EventModel({
    this.id,
    required this.nama,
    required this.email,
    required this.event,
    required this.kota,
  });
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nama': nama,
      'email': email,
      'event': event,
      'kota': kota,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      event: map['event'],
      kota: map['kota'],
    );
  }
}
