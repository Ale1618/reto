import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:empresa_abc/model/clientes.dart';
import 'package:empresa_abc/user-interface/clientes_listview.dart';
import 'package:empresa_abc/user-interface/pagina_extra.dart';
import 'package:flutter/material.dart';

import 'clientes_add.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State {
  int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _crearNuevoCliente(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        elevation: 50,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        currentIndex: currentIndex,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
        fabLocation: BubbleBottomBarFabLocation.end,
        onTap: changePage,
        items: [
          BubbleBottomBarItem(
            backgroundColor: Colors.teal[500],
            icon: Icon(
              Icons.people,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.people,
              color: Colors.red,
            ),
            title: Text('Clientes'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.indigo,
            icon: Icon(
              Icons.info_outline,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.info_outline,
              color: Colors.indigo,
            ),
            title: Text('Más'),
          ),
        ],
      ),
      body: (currentIndex == 0) ? ClientesListView() : Mas(),
    );
  }
}

void _crearNuevoCliente(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ClientesAdd(Clientes(null, '', '', '', ''))),
  );
}
