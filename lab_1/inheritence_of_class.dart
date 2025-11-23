// Base class (Parent)
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo() {
    print('Name: $name');
    print('Age : $age');
  }
}

// Derived class (Child)
class Student extends Person {
  int rollNumber;

  Student(String name, int age, this.rollNumber) : super(name, age);

  void displayStudentDetails() {
    displayInfo(); // calling method from parent class
    print('Roll Number: $rollNumber');
  }
}

void main() {
  // Creating object of child class
  Student student1 = Student('Yash', 20, 101);

  // Displaying inherited and own details
  student1.displayStudentDetails();
}
