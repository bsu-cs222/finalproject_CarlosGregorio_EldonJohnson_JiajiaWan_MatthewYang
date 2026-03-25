class Card {
  final String name;
  final String? type;
  final String? desc;

  Card({required this.name, this.type, this.desc});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(name: json['name'], type: json['type'], desc: json['desc']);
  }
}
