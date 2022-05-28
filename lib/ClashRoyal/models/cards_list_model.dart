class Cards {
  Cards({
    this.name,
    this.id,
    this.maxLevel,
    this.iconUrls,
  });

  String? name;
  int? id;
  int? maxLevel;
  IconUrls? iconUrls;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        name: json["name"],
        id: json["id"],
        maxLevel: json["maxLevel"],
        iconUrls: IconUrls.fromJson(json["iconUrls"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "maxLevel": maxLevel,
        "iconUrls": iconUrls!.toJson(),
      };
}

class IconUrls {
  IconUrls({
    this.medium,
  });

  String? medium;

  factory IconUrls.fromJson(Map<String, dynamic> json) => IconUrls(
        medium: json["medium"],
      );

  Map<String, dynamic> toJson() => {
        "medium": medium,
      };
}
