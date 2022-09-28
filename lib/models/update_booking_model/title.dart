class Title {
  String? ar;
  String? en;

  Title({this.ar, this.en});

  @override
  String toString() => 'Title(ar: $ar, en: $en)';

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        ar: json['ar'] as String?,
        en: json['en'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ar': ar,
        'en': en,
      };

  Title copyWith({
    String? ar,
    String? en,
  }) {
    return Title(
      ar: ar ?? this.ar,
      en: en ?? this.en,
    );
  }
}
