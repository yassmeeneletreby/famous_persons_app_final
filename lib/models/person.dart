class Person {
  final int id;
  final String name;
  final String? profilePath;
  final double popularity;
  final int? gender;
  final String? knownForDepartment;

  const Person({
    required this.id,
    required this.name,
    this.profilePath,
    required this.popularity,
    this.gender,
    this.knownForDepartment,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown',
      profilePath: json['profile_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] as int?,
      knownForDepartment: json['known_for_department'] as String?,
    );
  }
}
