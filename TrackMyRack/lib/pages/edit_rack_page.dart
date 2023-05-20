import 'package:flutter/material.dart';
import 'database_helper.dart';


class EditRackPage extends StatefulWidget {
  @override
  _EditRackPageState createState() => _EditRackPageState();
}

class _EditRackPageState extends State<EditRackPage> {
  String? selectedCategory;
  String? selectedItem;
  final dbHelper = DatabaseHelper();

  final Map<String, List<String>> categories = {
    'Protection': ['Nuts', 'Cams', 'Tricams'],
    'Soft Goods': ['Slings', 'Loops'],
    'Hardware': ['Carabiner', 'Quick draw'],
    // Add more categories and sub-categories here...
  };

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void selectItem(String item) async {
    setState(() {
      selectedItem = item;
    });

    if (selectedCategory != null && selectedItem != null) {
      // Create a Gear instance
      Gear gear = Gear(selectedCategory!, selectedItem!);

      // Save the gear entry to the database
      await dbHelper.insertGear(gear);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Rack'),
      ),
      body: ListView(
        children: [
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: categories.keys.map((String category) {
              return ElevatedButton(
                child: Text(category),
                onPressed: () => selectCategory(category),
              );
            }).toList(),
          ),
          if (selectedCategory != null) ...[
            SizedBox(height: 20.0), // Add some spacing
            Text(
              'Sub-categories for $selectedCategory:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: categories[selectedCategory]!.map((String item) {
                return ElevatedButton(
                  child: Text(item),
                  onPressed: () => selectItem(item),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
