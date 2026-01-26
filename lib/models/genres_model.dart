class MovieGenre {
  final int id;
  final String name;

  MovieGenre({required this.id, required this.name});

  factory MovieGenre.fromJson(Map<String, dynamic> json) {
    return MovieGenre(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return 'MovieGenre{id: $id, name: $name}';
  }
}
