class Gear {
  String category;
  String item;
  String name;
  String details;
  String manufacturedDate;
  String strength;

  Gear(this.category, this.item, this.name, this.details, this.manufacturedDate, this.strength);

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'item': item,
      'name': name,
      'details': details,
      'manufacturedDate': manufacturedDate,
      'strength': strength,
    };
  }
}
