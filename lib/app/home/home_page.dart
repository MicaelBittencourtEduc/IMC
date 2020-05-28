import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:imc/app/home/home_controller.dart';
import 'package:imc/app/home/widget/alert_custom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
              child: Column(
            children: <Widget>[
              Container(
                child: Container(
                  width: double.infinity,
                  child: RaisedButton(
                      color: Colors.red,
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertCustom(
                              title: "Deletar Lista",
                              message: "Deseja realmete deletar esta Lista?",
                              confirm: () {
                                controller.cleanListData();
                                controller.getListData();
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              cancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      }),
                ),
              ),
              Container(
                height: _height * 0.80,
                child: ListView.builder(
                  itemCount: controller.listData.length,
                  itemBuilder: (context, index) {
                    var data = json.decode(controller.listData[index]);
                    return Card(
                      child: ListTile(
                        title: Text('Status: ${data["status"]}'),
                        subtitle: Row(
                          children: <Widget>[
                            Text('Altura: ${data["altura"]}'),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Peso: ${data["peso"]}')
                          ],
                        ),
                        trailing: Text(data['date']),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
          appBar: AppBar(
            centerTitle: true,
            title: Text('IMC'),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    textFieldGenerico(
                      label: 'Peso',
                      hint: 'Peso',
                      onChanged: (value) {
                        controller.peso = double.parse(value);
                        controller.calculaIMC();
                        controller.verificaSituacao();
                      },
                    ),
                    Divider(),
                    textFieldGenerico(
                      label: 'Altura',
                      hint: 'Altura',
                      onChanged: (value) {
                        controller.altura = double.parse(value);
                        controller.calculaIMC();
                        controller.verificaSituacao();
                      },
                    ),
                    RaisedButton(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.blue)),
                      child: Text(
                        'SALVAR',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        print(controller.altura);
                        print(controller.peso);
                        print(controller.status);
                        controller.setListData();
                        print(controller.resultado);
                      },
                    ),
                    Observer(builder: (_) {
                      return Column(
                        children: <Widget>[
                          Text(
                            '${controller.status}'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Image.asset(
                            controller.image,
                            height: _height * 0.45,
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

textFieldGenerico({String label, String hint, onChanged}) {
  return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: label,
          labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
          hintText: hint));
}
