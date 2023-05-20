import 'package:json_annotation/json_annotation.dart';

part 'gear_item.g.dart';

@JsonSerializable()
class GearItem {
  final String name;
  final String type;
  late final bool inUse;
  final String description;

  GearItem({
    required this.name,
    required this.type,
    required this.inUse,
    required this.description,
  });

  factory GearItem.fromJson(Map<String, dynamic> json) => _$GearItemFromJson(json);
  Map<String, dynamic> toJson() => _$GearItemToJson(this);
}
