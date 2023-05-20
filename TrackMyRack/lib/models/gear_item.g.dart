// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gear.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GearItem _$GearItemFromJson(Map<String, dynamic> json) => GearItem(
      name: json['name'] as String,
      type: json['type'] as String,
      inUse: json['inUse'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$GearItemToJson(GearItem instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'inUse': instance.inUse,
      'description': instance.description,
    };
