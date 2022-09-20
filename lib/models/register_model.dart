import 'package:travinia/models/auth_data_model.dart';
import 'package:travinia/models/status_model.dart';

class RegisterModel {
  final StatusModel status;
  final AuthDataModel? data;

  RegisterModel({
    required this.status,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: StatusModel.fromJson(json['status']),
      data: AuthDataModel.fromJson(json['data']),
    );
  }
}
