import 'package:flutter/material.dart';
import 'database_helper.dart';

class ViewMyRackPage extends StatefulWidget {
  @override
  _ViewMyRackPageState createState() => _ViewMyRackPageState();
}

class _ViewMyRackPageState extends State<ViewMyRackPage> {
  final dbHelper = DatabaseHelper();
  List<CategoryGroup> categoryGroups = [];

  @override
  void initState() {
    super.initState();
    fetchGearEntries();
  }

  Future<void> fetchGearEntries() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('your_table_name');

    List<Gear> gearEntries = List.generate(maps.length, (index) {
      return Gear(
        maps[index]['category'],
        maps[index]['item'],
        maps[index]['name'],
        maps[index]['details'],
        maps[index]['manufacturedDate'],
        maps[index]['strength'],
      );
    });

    // Group gear entries by category
    categoryGroups = [];
    for (var gear in gearEntries) {
      var group = categoryGroups.firstWhere(
            (categoryGroup) => categoryGroup.category == gear.category,
        orElse: () {
          var newGroup = CategoryGroup(category: gear.category, gearList: []);
          categoryGroups.add(newGroup);
          return newGroup;
        },
      );
      group.gearList.add(gear);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Rack'),
      ),
      body: ListView.builder(
        itemCount: categoryGroups.length,
        itemBuilder: (context, categoryIndex) {
          final categoryGroup = categoryGroups[categoryIndex];
          return Column(
            children: [
              ListTile(
                title: Text(
                  categoryGroup.category,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    categoryGroup.isExpanded = !categoryGroup.isExpanded;
                  });
                },
              ),
              if (categoryGroup.isExpanded)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: categoryGroup.gearList.length,
                    itemBuilder: (context, itemIndex) {
                      final gear = categoryGroup.gearList[itemIndex];
                      return ExpansionTile(
                        title: Text(gear.item),
                        children: [
                          ListTile(
                            title: Text(gear.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Details: ${gear.details}'),
                                Text('Manufactured Date: ${gear.manufacturedDate}'),
                                Text('Strength: ${gear.strength}'),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class CategoryGroup {
  String category;
  List<Gear> gearList;
  bool isExpanded;

  CategoryGroup({
    required this.category,
    required this.gearList,
    this.isExpanded = false,
  });
}
