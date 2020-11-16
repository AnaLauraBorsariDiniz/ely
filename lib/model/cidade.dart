class CidadeModel {
  int _id;
  String _name;
  String _country;
  String _populationInMillions;
  String _type;

  CidadeModel(
      this._name, this._country, this._populationInMillions, this._type);

  CidadeModel.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._country = obj['country'];
    this._populationInMillions = obj['populationInMillions'];
    this._type = obj['type'];
  }

  int get id => _id;
  String get name => _name;
  String get country => _country;
  String get populationInMillions => _populationInMillions;
  String get type => _type;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['country'] = _country;
    map['populationInMillions'] = _populationInMillions;
    map['type'] = _type;
    return map;
  }

  CidadeModel.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._country = map['country'];
    this._populationInMillions = map['populationInMillions'];
    this._type = map['type'];
  }
}
