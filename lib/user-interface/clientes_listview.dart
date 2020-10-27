import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:empresa_abc/user-interface/clientes_add.dart';
import 'package:empresa_abc/user-interface/clientes_informacion.dart';
import 'package:empresa_abc/model/clientes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientesListView extends StatefulWidget {
  @override
  _ClientesListViewState createState() => _ClientesListViewState();
}

final clientesReference =
    FirebaseDatabase.instance.reference().child('clientes');

class _ClientesListViewState extends State<ClientesListView> {
  TextEditingController searchController = new TextEditingController(); //BUSCAR
  String filter; //BUSCAR

  List<Clientes> items;
  StreamSubscription<Event> _onAgregarClientesSubscription;
  StreamSubscription<Event> _onEditarClientesSubscription;

  @override
  void initState() {
    // TODO: implement initState

    //BUSCAR
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    //

    super.initState();
    items = new List();
    _onAgregarClientesSubscription =
        clientesReference.onChildAdded.listen(_onAgregarClientes);
    _onEditarClientesSubscription =
        clientesReference.onChildChanged.listen(_onEditarClientes);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    //BUSCAR
    searchController.dispose();
    //

    super.dispose();
    _onAgregarClientesSubscription.cancel();
    _onEditarClientesSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Clientes'),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: TextField(
              controller: searchController,
              autofocus: false,
              decoration: InputDecoration(
                hintText: 'Buscar cliente',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, position) {
                  return (filter == null || filter == "")
                      ? Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(10.0)),
                              gradient: new LinearGradient(
                                  colors: [
                                    Colors.teal[500],
                                    Colors.lightGreen[100]
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  tileMode: TileMode.clamp)),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    '${items[position].nombre}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  subtitle: Text(
                                    'Dirección: ${items[position].direccion}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.yellow[900],
                                          radius: 18,
                                          child: Text(
                                            '${items[position].nombre[0].toUpperCase()}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        )
                                      ]),
                                  onTap: () =>
                                      _verClientes(context, items[position]),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () =>
                                      _showDialog(context, position)),
                              IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                  onPressed: () => _editarClientes(
                                      context, items[position])),
                            ],
                          ),
                        )
                      : '${items[position].nombre}'
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
                                  gradient: new LinearGradient(
                                      colors: [
                                        Colors.teal[500],
                                        Colors.lightGreen[100]
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      tileMode: TileMode.clamp)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        '${items[position].nombre}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                      subtitle: Text(
                                        'Dirección: ${items[position].direccion}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.yellow[900],
                                              radius: 18,
                                              child: Text(
                                                '${items[position].nombre[0].toUpperCase()}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            )
                                          ]),
                                      onTap: () => _verClientes(
                                          context, items[position]),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () =>
                                          _showDialog(context, position)),
                                  IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.blueAccent),
                                      onPressed: () => _editarClientes(
                                          context, items[position])),
                                ],
                              ),
                            )
                          : Container();
                }),
          )
        ],
      ),
    );
  }

  // Alerta de eliminar registro de cliente
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('Alerta'),
          content: Text('¿Esta seguro de que desea eliminar a este cliente?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Si',
                  style: TextStyle(color: Colors.green, fontSize: 18)),
              onPressed: () => _eliminarClientes(
                context,
                items[position],
                position,
              ),
            ),
            FlatButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onAgregarClientes(Event event) {
    setState(() {
      items.add(new Clientes.fromSnapShot(event.snapshot));
    });
  }

  void _onEditarClientes(Event event) {
    var oldClienteValue =
        items.singleWhere((clientes) => clientes.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldClienteValue)] =
          new Clientes.fromSnapShot(event.snapshot);
    });
  }

  void _eliminarClientes(
      BuildContext context, Clientes clientes, int position) async {
    await clientesReference.child(clientes.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
      Fluttertoast.showToast(
          msg: 'El contacto fue Eliminado', backgroundColor: Colors.deepOrange);
    });
  }

  void _editarClientes(BuildContext context, Clientes clientes) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClientesAdd(clientes)),
    );
  }

  void _verClientes(BuildContext context, Clientes clientes) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClientesInformacion(clientes)),
    );
  }
}
