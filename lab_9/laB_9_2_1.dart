class Student {
  int? id;
  String name;
  int age;
  String grade;

  Student({
    this.id,
    required this.name,
    required this.age,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'age': age,
      'grade': grade,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      grade: map['grade'],
    );
  }

  static String createTable() {
    return '''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        grade TEXT NOT NULL
      );
    ''';
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, age: $age, grade: $grade}';
  }
}
