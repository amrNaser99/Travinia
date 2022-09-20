import 'package:travinia/models/booking_data_model.dart';
import 'package:travinia/models/booking_details.dart';
import 'package:travinia/models/status_model.dart';

class BookingModel {
  final StatusModel? status;
  final BookingDataModel? Data;

  BookingModel({
    this.status,
    this.Data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      status: StatusModel.fromJson(json['status']),
      Data: BookingDataModel.fromJson(json['data']),
    );
  }
}
