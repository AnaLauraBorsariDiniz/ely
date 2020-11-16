import 'package:flutter/material.dart';
import '../model/cidade.dart';
import '../db/database_helper.dart';

class CidadeScreen extends StatefulWidget {
  final CidadeModel cidade;
  CidadeScreen(this.cidade);
  @override
  State<StatefulWidget> createState() => new _CidadeScreenState();
}

class _CidadeScreenState extends State<CidadeScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nameController;
  TextEditingController _countryController;
  TextEditingController _populationInMillionsController;
  TextEditingController _typeController;

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController(text: widget.cidade.name);
    _countryController = new TextEditingController(text: widget.cidade.country);
    _populationInMillionsController =
        new TextEditingController(text: widget.cidade.populationInMillions);
    _typeController = new TextEditingController(text: widget.cidade.type);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cidade')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.network(
            'https://pt-static.z-dn.net/files/d09/db60a8dd0caaf95bb3beaab270614f33.jpg',
             width: 500,
             height: 300,
             alignment: Alignment.center,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'País'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _populationInMillionsController,
              decoration: InputDecoration(labelText: 'População'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Tipo'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.cidade.id != null)
                  ? Text('Alterar')
                  : Text('Inserir'),
              onPressed: () {
                if (widget.cidade.id != null) {
                  db.updateCidade(CidadeModel.fromMap({
                    'id': widget.cidade.id,
                    'name': _nameController.text,
                    'country': _countryController.text,
                    'populationInMillions': _populationInMillionsController.text,
                    'type': _typeController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirCidade(CidadeModel(
                          _nameController.text,
                          _countryController.text,
                          _populationInMillionsController.text,
                          _typeController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}