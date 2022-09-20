
import 'package:travinia/models/auth_data_model.dart';
import 'package:travinia/models/status_model.dart';

class LoginModel {
  final StatusModel status;
  final AuthDataModel? data;

  LoginModel({
    required this.status,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: StatusModel.fromJson(json['status']),
      data: AuthDataModel.fromJson(json['data']),
    );
  }
}