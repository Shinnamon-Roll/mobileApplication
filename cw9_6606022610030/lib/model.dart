class Model {
  final String id;
  final String name;
  final String address;
  final String email;

  Model._({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model._(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
    );
  }
}
