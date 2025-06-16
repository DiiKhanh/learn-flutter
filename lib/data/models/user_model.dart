class UserModel {
  UserModel({
    this.username,
    this.name,
    this.email,
    this.phone,
    required this.address,
  });

  String? username;
  Name? name;
  String? email;
  String? phone;
  late Address address;

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = Name.fromJson(json['name']);
    email = json['email'];
    phone = json['phone'];
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['name'] = name?.toJson();
    data['email'] = email;
    data['address'] = address.toJson();
    data['phone'] = phone;
    return data;
  }
}

class Name {
  String? firstName;
  String? lastName;
  Name(this.firstName, this.lastName);

  Name.fromJson(Map<String, dynamic> json) {
    firstName = json['firstname'];
    lastName = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstName;
    data['lastname'] = lastName;
    return data;
  }
}

class Address {
  String? city;
  String? street;
  Address(this.city, this.street);
  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['street'] = street;
    return data;
  }
}
