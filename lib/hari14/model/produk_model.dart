import 'dart:convert';

import 'package:flutter/material.dart';

class ProdukModel {
  final String nama;
  final IconData icon;
  final String deskripsi;
  final Color warna;

  ProdukModel({
    required this.nama,
    required this.icon,
    required this.deskripsi,
    required this.warna,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'icon': icon.codePoint,
      'deskripsi': deskripsi,
      'warna': warna.value,
    };
  }

  factory ProdukModel.fromMap(Map<String, dynamic> map) {
    return ProdukModel(
      nama: map['nama'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      deskripsi: map['deskripsi'] as String,
      warna: Color(map['warna'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdukModel.fromJson(String source) =>
      ProdukModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
