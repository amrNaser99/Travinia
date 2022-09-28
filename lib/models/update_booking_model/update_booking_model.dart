import 'status.dart';

class UpdateBookingModel {
  Status? status;

  UpdateBookingModel({this.status});

  @override
  String toString() => 'UpdateBookingModel(status: $status)';

  factory UpdateBookingModel.fromJson(Map<String, dynamic> json) {
    return UpdateBookingModel(
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
    );
  }
}
