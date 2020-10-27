import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Clientes {
  String _id;
  String _nombre;
  String _direccion;
  String _telefono;
  String _nom_perscont;
  String _tel_perscont;

  Clientes(this._nombre, this._direccion, this._telefono,
      this._nom_perscont, this._tel_perscont);

  Clientes.map(dynamic obj) {
    this._nombre = obj['nombre'];
    this._direccion = obj['direccion'];
    this._telefono = obj['telefono'];
    this._nom_perscont = obj['nombre_pers_cont'];
    this._tel_perscont = obj['tel_pers_cont'];
    
  }

  String get id => _id;
  String get nombre => _nombre;
  String get direccion => _direccion;
  String get telefono => _telefono;
  String get nom_perscont => _nom_perscont;
  String get tel_perscont => _tel_perscont;

  Clientes.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _direccion = snapshot.value['direccion'];
    _telefono = snapshot.value['telefono'];
    _nom_perscont = snapshot.value['nombre_pers_cont'];
    _tel_perscont = snapshot.value['tel_pers_cont'];
    
  }
}

