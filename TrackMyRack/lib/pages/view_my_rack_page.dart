import 'package:flutter/material.dart';
import 'database_helper.dart';

class ViewMyRackPage extends StatefulWidget {
  @override
  _ViewMyRackPageState createState() => _ViewMyRackPageState();
}

class _ViewMyRackPageState extends State<ViewMyRackPage> {
  final dbHelper = DatabaseHelper();
  List<Gear> gearEntries = [];
  List<bool> itemExpandedList = [];

  @override
  void initState() {
    super.initState();
    fetchGearEntries();
  }

  Future<void> fetchGearEntries() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('your_table_name');
    setState(() {
      gearEntries = List.generate(maps.length, (index) {
        return Gear(
          maps[index]['category'],
          maps[index]['item'],
          maps[index]['name'],
          maps[index]['details'],
          maps[index]['manufacturedDate'],
          maps[index]['strength'],
        );
      });
      itemExpandedList = List.generate(maps.length, (index) => false);
    });
  }

  void toggleItemExpanded(int index) {
    setState(() {
      itemExpandedList[index] = !itemExpandedList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Rack'),
      ),
      body: ListView.builder(
        itemCount: gearEntries.length,
        itemBuilder: (context, index) {
          final gear = gearEntries[index];
          return ExpansionTile(
            title: Text(gear.category),
            subtitle: Text(gear.item),
            onExpansionChanged: (expanded) {
              toggleItemExpanded(index);
            },
            children: [
              ListTile(
                title: Text('Name: ${gear.name}'),
              ),
              ListTile(
                title: Text('Details: ${gear.details}'),
              ),
              ListTile(
                title: Text('Manufactured Date: ${gear.manufacturedDate}'),
              ),
              ListTile(
                title: Text('Strength: ${gear.strength}'),
              ),
            ],
            initiallyExpanded: itemExpandedList[index],
          );
        },
      ),
    );
  }
}
