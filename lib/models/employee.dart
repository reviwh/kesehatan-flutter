import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  String name;
  String noBp;
  String noHp;
  String email;
  String createdAt;

  Employee({
    required this.name,
    required this.noBp,
    required this.noHp,
    required this.email,
    required this.createdAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        noBp: json["no_bp"],
        noHp: json["no_hp"],
        email: json["email"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "no_bp": noBp,
        "no_hp": noHp,
        "email": email,
        "created_at": createdAt,
      };
}
