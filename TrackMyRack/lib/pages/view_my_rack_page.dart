import 'package:flutter/material.dart';
import 'package:openbeta/models/gear.dart';
import 'package:openbeta/services/database_helper.dart';

class ViewMyRackPage extends StatelessWidget {
  final GearService gearService = GearService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View My Rack'),
      ),
      body: FutureBuilder<List<GearItem>>(
        future: gearService.getGearItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final gearItems = snapshot.data;

          if (gearItems == null || gearItems.isEmpty) {
            return Center(
              child: Text('No gear items found.'),
            );
          }

          return ListView.builder(
            itemCount: gearItems.length,
            itemBuilder: (context, index) {
              final gearItem = gearItems[index];
              return ListTile(
                title: Text(gearItem.name),
                subtitle: Text(gearItem.type),
                // Add other properties as needed
              );
            },
          );
        },
      ),
    );
  }
}
