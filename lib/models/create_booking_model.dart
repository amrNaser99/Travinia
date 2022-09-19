import 'package:travinia/models/status_model.dart';

class Create_BookingModel {
  final StatusModel status;

  Create_BookingModel({
    required this.status,
  });

  factory Create_BookingModel.fromJson(Map<dynamic, dynamic> json) {
    return Create_BookingModel(
      status: StatusModel.fromJson(json['status']),
    );
  }
}
