import 'package:empresa_abc/model/clientes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ClientesInformacion extends StatefulWidget {
  final Clientes clientes;

  ClientesInformacion(this.clientes);
  @override
  _ClientesInformacionState createState() => _ClientesInformacionState();
}

final clientesReference =
    FirebaseDatabase.instance.reference().child('clientes');

class _ClientesInformacionState extends State<ClientesInformacion> {
  List<Clientes> items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visualizando a ${widget.clientes.nombre}"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),
      body: Container(
        height: 290.0,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.orangeAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Nombre : ${widget.clientes.nombre}",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                new Text(
                  "Direccion : ${widget.clientes.direccion}",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                new Text(
                  "Telefono : ${widget.clientes.telefono}",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: 30, color: Colors.white),
                    SizedBox(width: 15),
                    Text(
                      'Personas de contacto',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 13.0),
                ),
                (widget.clientes.nom_perscont.isNotEmpty)? Text(
                  "Nombre : ${widget.clientes.nom_perscont}",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,) :Text('No ha asignado un nombre'),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                (widget.clientes.tel_perscont.isNotEmpty)? Text(
                  "Telefono : ${widget.clientes.tel_perscont}",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,) :Text('No ha asignado un telefono'),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
