import 'package:flutter/material.dart';
import 'package:flutter_application_new_cabify/place_service.dart';
import 'package:uuid/uuid.dart';

import 'address_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC Cabify',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _destionationController = TextEditingController();
  @override
  void dispose() {
    _destionationController.dispose();
    super.dispose();
  }

  _search() async {
    final sessionToken = Uuid().v4();
    final Suggestion result = await showSearch(
        context: context, delegate: AddressSearch(sessionToken));
    if (result != null) {
      setState(() {
        _destionationController.text = result.description;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: _appBar(),
        preferredSize: const Size(double.infinity, 140),
      ),
      body: Container(),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: const Text(
        "Ingresá tu destino",
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: <Widget>[
              AddressInput(
                iconData: Icons.gps_fixed,
                hintText: "Punto de partida",
                enabled: false,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  AddressInput(
                    controller: _destionationController,
                    iconData: Icons.gps_fixed,
                    hintText: "¿A dónde vas?",
                    onTap: _search,
                  ),
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(70),
      ),
    );
  }
}

class AddressInput extends StatelessWidget {
  final IconData iconData;
  final TextEditingController controller;
  final String hintText;
  final Function onTap;
  final bool enabled;

  const AddressInput(
      {Key key,
      this.iconData,
      this.controller,
      this.hintText,
      this.onTap,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          this.iconData,
          size: 18,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width / 1.4,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]),
            child: TextField(
              controller: controller,
              onTap: onTap,
              enabled: enabled,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
