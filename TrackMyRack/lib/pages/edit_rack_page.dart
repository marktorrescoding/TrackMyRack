import 'package:flutter/material.dart';
import 'database_helper.dart';

class EditRackPage extends StatefulWidget {
  @override
  _EditRackPageState createState() => _EditRackPageState();
}

class _EditRackPageState extends State<EditRackPage> {
  final dbHelper = DatabaseHelper();
  String? selectedCategory;
  String? selectedItem;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController manufacturedDateController = TextEditingController();
  TextEditingController strengthController = TextEditingController();

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

  void selectItem(String item) {
    setState(() {
      selectedItem = item;
    });
    _showGearEntryDialog();
  }

  Future<void> _showGearEntryDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Gear Entry'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: detailsController,
                  decoration: InputDecoration(labelText: 'Details'),
                ),
                TextField(
                  controller: manufacturedDateController,
                  decoration: InputDecoration(labelText: 'Manufactured Date'),
                ),
                TextField(
                  controller: strengthController,
                  decoration: InputDecoration(labelText: 'Strength'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () async {
                String name = nameController.text;
                String details = detailsController.text;
                String manufacturedDate = manufacturedDateController.text;
                String strength = strengthController.text;

                // Create a Gear instance
                Gear gear = Gear(
                  selectedCategory!,
                  selectedItem!,
                  name,
                  details,
                  manufacturedDate,
                  strength,
                );

                // Save the gear entry to the database
                await dbHelper.insertGear(gear);

                // Clear the text fields
                nameController.clear();
                detailsController.clear();
                manufacturedDateController.clear();
                strengthController.clear();

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                // Clear the text fields
                nameController.clear();
                detailsController.clear();
                manufacturedDateController.clear();
                strengthController.clear();

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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
