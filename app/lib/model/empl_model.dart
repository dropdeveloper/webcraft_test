class Employee {
  late int id;
  late String name;
  late String username;
  late String email;
  late String profile_image;
  late String phone;
  late String website;
  late String company;
  late String catchPhrase;
  late String bs;
  late String street;
  late String suite;
  late String city;
  late String zipcode;

  Employee(
      this.id,
      this.name,
      this.username,
      this.email,
      this.profile_image,
      this.phone,
      this.website,
      this.company,
      this.catchPhrase,
      this.bs,
      this.street,
      this.city,
      this.suite,
      this.zipcode);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['profile_image'] = profile_image;
    map['phone'] = phone;
    map['website'] = website;
    map['company'] = company;
    map['catchPhrase'] = catchPhrase;
    map['bs'] = bs;
    map['street'] = street;
    map['city'] = city;
    map['suite'] = suite;
    map['zipcode'] = zipcode;
    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    username = map['username'];
    email = map['email'];
    profile_image = map['profile_image'];
    phone = map['phone'];
    website = map['website'];
    company = map['company'];
    catchPhrase = map['catchPhrase'];
    bs = map['bs'];
    street = map['street'];
    suite = map['suite'];
    city = map['city'];
    zipcode = map['zipcode'];
  }
}
