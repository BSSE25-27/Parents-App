class Child {
  final String id;
  final String name;
  final String schoolId;
  final String schoolName;
  final String grade;
  final String section;
  final String parentId;
  final String? imageUrl;

  Child({
    required this.id,
    required this.name,
    required this.schoolId,
    required this.schoolName,
    required this.grade,
    required this.section,
    required this.parentId,
    this.imageUrl,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      schoolId: json['school_id'],
      schoolName: json['school_name'],
      grade: json['grade'],
      section: json['section'],
      parentId: json['parent_id'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'school_id': schoolId,
      'school_name': schoolName,
      'grade': grade,
      'section': section,
      'parent_id': parentId,
      'image_url': imageUrl,
    };
  }
}

