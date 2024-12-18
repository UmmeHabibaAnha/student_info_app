//model class
class Student{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? location;

  //constructor
  Student({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.location,
  });


  //for saving data to db
  //name must be same as table name in db
  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
    };
  }

  //for retrieving data from db
  static Student fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      location: map['location'],
    );
  }
}