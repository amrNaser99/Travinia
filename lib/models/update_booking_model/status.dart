import 'title.dart';

class Status {
  String? type;
  Title? title;

  Status({this.type, this.title});

  @override
  String toString() => 'Status(type: $type, title: $title)';

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'] as String?,
        title: json['title'] == null
            ? null
            : Title.fromJson(json['title'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title?.toJson(),
      };

  Status copyWith({
    String? type,
    Title? title,
  }) {
    return Status(
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }
}
