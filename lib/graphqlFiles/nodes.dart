class Character {
  final String name;
  final String image;

  Character({required this.name, required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name']['full'],
      image: json['image']['medium'],
    );
  }
}
