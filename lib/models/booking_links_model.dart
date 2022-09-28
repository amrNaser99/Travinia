class bookingLinksModel {
  final String? url;
  final String? label;
  final bool? active;

  bookingLinksModel({
    this.url,
    this.label,
    this.active,
  });

  factory bookingLinksModel.fromJson(Map<String, dynamic> json) {
    return bookingLinksModel(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}
