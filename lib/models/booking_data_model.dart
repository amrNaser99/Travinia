import 'package:travinia/models/booking_details.dart';
import 'package:travinia/models/booking_links_model.dart';

class BookingDataModel {
  final int? currentPage;
  final List<BookingDetailsModel>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final List<bookingLinksModel>? links;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  BookingDataModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.links,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory BookingDataModel.fromJson(Map<String, dynamic> json) {
    return BookingDataModel(
      currentPage: json["current_page"],
      data: List<BookingDetailsModel>.from(
        json["data"].map(
          (x) => BookingDetailsModel.fromJson(x),
        ),
      ),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      links: List<bookingLinksModel>.from(
        json["links"].map(
          (x) => bookingLinksModel.fromJson(x),
        ),
      ),
      lastPageUrl: json["last_page_url"],
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }
}
