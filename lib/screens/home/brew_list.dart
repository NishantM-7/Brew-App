import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/models/brew.dart';

class BrewList extends StatefulWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    brews.forEach((brew) {
      print(brew.name);
      print(brew.strength);
      print(brew.sugars);
    });
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/coffee_icon.png'),
                  backgroundColor: Colors.brown[brews[index].strength],
                  radius: 25.0,
                ),
                title: Text(brews[index].name),
                subtitle: Text('Takes ${brews[index].sugars} sugar(s)')),
          ),
        );
      },
      itemCount: brews.length,
    );
  }
}
