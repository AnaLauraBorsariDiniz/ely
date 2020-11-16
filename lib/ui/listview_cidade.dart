import 'package:flutter/material.dart';
import '../model/cidade.dart';
import '../db/database_helper.dart';
import 'cidade_screen.dart';

class ListViewCidade extends StatefulWidget {
  @override
  _ListViewCidadeState createState() => new _ListViewCidadeState();
}


class _ListViewCidadeState extends State<ListViewCidade> {
  List<CidadeModel> items = new List();
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getCidades().then((cidades) {
      setState(() {
        cidades.forEach((cidade) {
          items.add(CidadeModel.fromMap(cidade));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cidades'),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Row(children: [
                        Text('País: ${items[position].country} - População: ${items[position].populationInMillions} - Tipo: ${items[position].type}',
                            style: new TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                            )),
                      
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _deleteCidade(
                                context, items[position], position)),
                      ]),
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 15.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () => _navigateToCidade(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewCidade(context),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }

  void _deleteCidade(BuildContext context, CidadeModel cidade, int position) async {
    db.deleteCidade(cidade.id).then((cidades) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToCidade(BuildContext context, CidadeModel cidade) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CidadeScreen(cidade)),
    );
    if (result == 'update') {
      db.getCidades().then((cidades) {
        setState(() {
          items.clear();
          cidades.forEach((cidade) {
            items.add(CidadeModel.fromMap(cidade));
          });
        });
      });
    }
  }

  void _createNewCidade(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CidadeScreen(CidadeModel('', '', '', ''))),
    );
    if (result == 'save') {
      db.getCidades().then((cidades) {
        setState(() {
          items.clear();
          cidades.forEach((cidade) {
            items.add(CidadeModel.fromMap(cidade));
          });
        });
      });
    }
  }
}
