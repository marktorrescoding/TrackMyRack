import 'package:flutter/material.dart';
import 'package:openbeta/models/climbing_route.dart';
import 'package:openbeta/services/api_service.dart';

class RouteDetailsPage extends StatefulWidget {
  final ClimbingRoute route;

  const RouteDetailsPage({required this.route, Key? key}) : super(key: key);

  @override
  _RouteDetailsPageState createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage> {
  final ApiService apiService = ApiService();
  Future<ClimbingRoute>? _routeDetails;

  @override
  void initState() {
    super.initState();
    _routeDetails = apiService.getClimbingRouteDetails(widget.route.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route Details'),
      ),
      body: FutureBuilder<ClimbingRoute>(
        future: _routeDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load route details'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Route Name: ${snapshot.data!.name}',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Grade: ${snapshot.data!.yds}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
