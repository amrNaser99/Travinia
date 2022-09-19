import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/models/user_model.dart';

class BookingDetailsModel {
  final int? id;
  final int? userId;
  final int? hotelId;
  final String? bookingType;
  final int? createdAt;
  final int? updatedAt;
  final UserModel? user;
  final HotelModel? hotel;

  BookingDetailsModel({
    this.id,
    this.userId,
    this.hotelId,
    this.bookingType,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.hotel,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsModel(
      id: json["id"],
      userId: json["userId"],
      hotelId: json["hotelId"],
      bookingType: json["bookingType"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      user: UserModel.fromJson(json["user"]),
      hotel: HotelModel.fromJson(json["hotel"]),
    );
  }
//

}
