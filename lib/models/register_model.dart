import 'package:travinia/models/status_model.dart';
import 'package:travinia/models/user_model.dart';

class RegisterModel {
  final StatusModel status;
  final UserModel? data;

  RegisterModel({
    required this.status,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: StatusModel.fromJson(json['status']),
      data: UserModel.fromJson(json['data']),
    );
  }
}
