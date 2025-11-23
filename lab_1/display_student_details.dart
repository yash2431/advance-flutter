class Student {
  String name;
  int rollNumber;
  String grade;
  Student(this.name, this.rollNumber, this.grade);

  void displayDetails() {
    print('Student Details:');
    print('Name       : $name');
    print('Roll Number: $rollNumber');
    print('Grade      : $grade');
  }
}

void main() {
  Student student1 = Student('Yash', 375, 'B');
  student1.displayDetails();
}
