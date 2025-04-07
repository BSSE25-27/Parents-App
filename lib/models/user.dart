class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? imageUrl;
  final List<String>? childrenIds;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
    this.childrenIds,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['image_url'],
      childrenIds: json['children_ids'] != null
          ? List<String>.from(json['children_ids'])
          : null,
      isVerified: json['is_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image_url': imageUrl,
      'children_ids': childrenIds,
      'is_verified': isVerified,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
    List<String>? childrenIds,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      childrenIds: childrenIds ?? this.childrenIds,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

