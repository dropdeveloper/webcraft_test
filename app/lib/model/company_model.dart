class CompanyModel {
  late int id;
  late String name;
  late String catchPhrase;
  late String bs;

  CompanyModel(this.id, this.name, this.catchPhrase, this.bs);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['catchPhrase'] = catchPhrase;
    map['bs'] = bs;
    return map;
  }

  CompanyModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    catchPhrase = map['catchPhrase'];
    bs = map['bs'];
  }
}
