class AddressModel {
  late int id;
  late String street;
  late String suite;
  late String city;
  late String zipcode;

  AddressModel(this.id, this.street, this.suite, this.city, this.zipcode);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['street'] = street;
    map['suite'] = suite;
    map['city'] = city;
    map['zipcode'] = zipcode;
    return map;
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    street = map['street'];
    suite = map['suite'];
    city = map['city'];
    zipcode = map['zipcode'];
  }
}
