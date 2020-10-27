import 'package:empresa_abc/model/clientes.dart';
import 'package:empresa_abc/user-interface/clientes_informacion.dart';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:flutter/services.dart';

class ClientesAdd extends StatefulWidget {
  final Clientes clientes;
  ClientesAdd(this.clientes);
  @override
  _ClientesAddState createState() => _ClientesAddState();
}

final clientesReference =
    FirebaseDatabase.instance.reference().child('clientes');

class _ClientesAddState extends State<ClientesAdd> {
  final _formKey =
      GlobalKey<FormState>(); //key para la validacion del formulario

  int count = 0;

  List<Clientes> items;

  TextEditingController _nombreController;
  TextEditingController _direccionController;
  TextEditingController _telefonoController;
  TextEditingController _nombre_contController;
  TextEditingController _tel_contController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.clientes.nombre);
    _direccionController =
        new TextEditingController(text: widget.clientes.direccion);
    _telefonoController =
        new TextEditingController(text: widget.clientes.telefono);
    _nombre_contController =
        new TextEditingController(text: widget.clientes.nom_perscont);
    _tel_contController =
        new TextEditingController(text: widget.clientes.tel_perscont);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: (widget.clientes.id != null)
            ? Text('Editando a ${widget.clientes.nombre}')
            : Text(
                'Creando nuevo cliente'), //Verificando si se el id del cliente existe o no para cambiar el encabezado del activity
        backgroundColor:
            (widget.clientes.id != null) ? Colors.green : Colors.blueAccent,
      ),
      body: Container(
        child: Form(
          //comienza la validacion
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[A-z\s]')),
                ],
                textCapitalization: TextCapitalization.words,
                maxLength: 20,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Debe ingresar un nombre";
                  }
                  if (value.trim().length < 3) {
                    return 'Debe ingresar al menos 3 letras';
                  }
                  return null;
                },
                controller: _nombreController,
                style:
                    TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                decoration: InputDecoration(
                    icon: Icon(Icons.person), labelText: 'Nombre'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              TextFormField(
                maxLength: 50,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\s]')),
                ],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Debe ingresar una dirección";
                  }
                  return null;
                },
                controller: _direccionController,
                style:
                    TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                decoration: InputDecoration(
                    icon: Icon(Icons.location_on), labelText: 'Dirección'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              TextFormField(
                maxLength: 9,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Debe ingresar un numero de telefono";
                  }
                  if (value.length < 7 || value.length == 8) {
                    //verificando que al menos tenga 7 digitos el numero de telefono ingresado
                    return "Debe ingresar un numero de telefono valido";
                  }
                  return null;
                },
                controller: _telefonoController,
                style:
                    TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                decoration: InputDecoration(
                    icon: Icon(Icons.phone), labelText: 'Telefono'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Text(
                'Persona de contacto',
                style: TextStyle(color: Colors.lightBlue, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                maxLength: 20,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[A-z\s]')),
                ],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Debe ingresar un nombre";
                  }
                  if (value.trim().length < 3) {
                    return 'Debe ingresar al menos 3 letras';
                  }
                  return null;
                },
                controller: _nombre_contController,
                style:
                    TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                decoration: InputDecoration(
                    icon: Icon(Icons.phone), labelText: 'Nombre'),
              ),
              TextFormField(
                maxLength: 9,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: (value) {
                  if (value.isEmpty) {
                    return "Debe ingresar un numero de telefono";
                  }
                  if (value.length < 7 || value.length == 8) {
                    //verificando que al menos tenga 7 digitos el numero de telefono ingresado
                    return "Debe ingresar un numero de telefono valido";
                  }
                  return null;
                },
                controller: _tel_contController,
                style:
                    TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                decoration: InputDecoration(
                    icon: Icon(Icons.phone), labelText: 'Telefono'),
              ),
              RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Colors.blue)),
                splashColor: Colors.blueAccent,
                child: (widget.clientes.id != null)
                    ? Text(
                        'Actualizar',
                        style: TextStyle(fontSize: 17),
                      )
                    : Text('Agregar', style: TextStyle(fontSize: 17)),
                onPressed: () {
                  //HACIENDO LAS VALIDACION DE LOS CAMPOS VACIOS
                  if (_formKey.currentState.validate()) {
                    if (widget.clientes.id != null) {
                      clientesReference.child(widget.clientes.id).set({
                        'nombre': _nombreController.text,
                        'direccion': _direccionController.text,
                        'telefono': _telefonoController.text,
                        'nombre_pers_cont': _nombre_contController.text,
                        'tel_pers_cont': _tel_contController.text,
                      }).then((_) {
                        Navigator.pop(context);
                      });
                      Fluttertoast.showToast(
                          msg: 'Contacto Actualizado',
                          backgroundColor: Colors.deepOrange);
                    } else {
                      clientesReference.push().set({
                        'nombre': _nombreController.text,
                        'direccion': _direccionController.text,
                        'telefono': _telefonoController.text,
                        'nombre_pers_cont': _nombre_contController.text,
                        'tel_pers_cont': _tel_contController.text,
                      }).then((_) {
                        Navigator.pop(context);
                      });
                      Fluttertoast.showToast(
                          msg: 'Contacto creado',
                          backgroundColor: Colors.deepOrange);
                    }
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
            ],
          ),
        ),
      ),
    );
  }
}
