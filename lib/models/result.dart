class Result {
  int id;

  Result({required this.id});

  Result.fromMap(Map<String, dynamic> map) : id = map['id'];

  Map<String, Object> topMap() {
    return {
      'id': id,
    };
  }
}
