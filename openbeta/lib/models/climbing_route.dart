import 'package:json_annotation/json_annotation.dart';

part 'climbing_route.g.dart';

@JsonSerializable()
class ClimbingRoute {
  final String name;
  final String yds; // Added `yds` field

  ClimbingRoute({
    required this.name,
    required this.yds, // Initialized `yds` in constructor
  });

  factory ClimbingRoute.fromJson(Map<String, dynamic> json) => _$ClimbingRouteFromJson(json);
  Map<String, dynamic> toJson() => _$ClimbingRouteToJson(this);
}
