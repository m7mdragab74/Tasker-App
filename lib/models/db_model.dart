class Course {
  int? _id;
  String? _courseName;
  String? _content;
  int? _hours;

  Course(dynamic obj) {
    {
      _id = obj['id'];
      _courseName = obj['courseName'];
      _content = obj['content'];
      _hours = obj['hours'];
    }
  }

  Course.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _courseName = data['courseName'];
    _content = data['content'];
    _hours = data['hours'];
  }

  Map<String, dynamic> toMap() => {
        'id': _id,
        'courseName': _courseName,
        'content': _content,
        'hours': _hours
      };
  int get id => _id!;
  String get name => _courseName!;
  String get content => _content!;
  int get hours => _hours!;
}
