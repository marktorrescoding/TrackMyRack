import 'package:flutter/material.dart';
import 'database_helper.dart';

class ViewMyRackPage extends StatelessWidget {
  final dbHelper = DatabaseHelper();

  Future<List<Gear>> fetchGearEntries() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('your_table_name');
    return List.generate(maps.length, (index) {
      return Gear(
        maps[index]['category'],
        maps[index]['item'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Rack'),
      ),
      body: FutureBuilder<List<Gear>>(
        future: fetchGearEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No gear entries found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final gear = snapshot.data![index];
              return ListTile(
                title: Text(gear.category),
                subtitle: Text(gear.item),
              );
            },
          );
        },
      ),
    );
  }
}
