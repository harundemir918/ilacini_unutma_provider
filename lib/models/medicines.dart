import 'dart:convert';

Medicines medicinesFromJson(String str) => Medicines.fromJson(json.decode(str));

String medicinesToJson(Medicines data) => json.encode(data.toJson());

class Medicines {
  Medicines({
    this.medicines,
    this.count,
  });

  List<Medicine> medicines;
  int count;

  factory Medicines.fromJson(Map<String, dynamic> json) => Medicines(
    medicines: List<Medicine>.from(json["medicines"].map((x) => Medicine.fromJson(x))),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
    "count": count,
  };
}

class Medicine {
  Medicine({
    this.id,
    this.name,
    this.image,
  });

  String id;
  String name;
  String image;

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}