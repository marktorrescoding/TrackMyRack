class Gear {
  String category;
  String subCategory;
  String brand;
  String name;
  String details;
  String manufacturedDate;
  String strength;

  Gear(this.category, this.subCategory, this.brand, this.name, this.details, this.manufacturedDate, this.strength);

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'subCategory': subCategory,
      'brand': brand,
      'name': name,
      'details': details,
      'manufacturedDate': manufacturedDate,
      'strength': strength,
    };
  }
}
