class User {
  final String key;
  final String name;

  User({
    required this.key,
    required this.name
  });

  Map<String, dynamic> toJson() {
    return {
      'key' : key,
      'name' : name,
    };
  }
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      key: json['key'] as String,
      name: json['name'] as String
    );
  }
}