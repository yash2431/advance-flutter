class Student {
  int? id;
  String name;
  int age;
  int courseId;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.courseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'course_id': courseId,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      courseId: map['course_id'],
    );
  }
}
