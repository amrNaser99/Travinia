import 'package:dartz/dartz.dart';
import 'package:travinia/models/create_booking_model.dart';
import 'package:travinia/models/register_model.dart';
import 'package:travinia/services/repositories/repository.dart';

import '../../core/error/exceptions.dart';
import '../../models/facilities_model.dart';
import '../../models/hotels_model.dart';
import '../../models/login_model.dart';
import '../../models/profile_model.dart';
import '../api_service/dio_helper.dart';
import '../api_service/end_points.dart';

class RepositoryImplementation extends Repository {
  final DioHelper dioHelper;

  RepositoryImplementation({
    required this.dioHelper,
  });

  ///Implement All User Functions Here

  @override
  Future<Either<PrimaryServerException, RegisterModel>> register({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    return handlingRequestResult<RegisterModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: registerEndPoint,
          data: {
            'name': name,
            'email': email,
            'password': password,
            'password_confirmation': password_confirmation,
          },
        );

        return RegisterModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  }) async {
    return handlingRequestResult<ProfileModel>(
      onSuccess: () async {
        final response = await dioHelper.get(
          endPoint: profileEndPoint,
          token: token,
        );

        return ProfileModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return handlingRequestResult<LoginModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: loginEndPoint,
          data: {
            'email': email,
            'password': password,
          },
        );

        return LoginModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  ///Implement All Hotel Functions Here
  @override
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  }) async {
    return handlingRequestResult<HotelsModel>(
      onSuccess: () async {
        final response = await dioHelper.get(endPoint: hotelsEndPoint, query: {
          'page': page,
          'count': 10,
        });

        return HotelsModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, FacilitiesModel>> getFacilities() {
    return handlingRequestResult<FacilitiesModel>(
      onSuccess: () async {
        final response = await dioHelper.get(endPoint: facilitiesEndPoint);

        return FacilitiesModel.fromJson(response['data']);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }

  @override
  Future<Either<PrimaryServerException, Create_BookingModel>> create_Booking({
    required String token,
    required int user_id,
    required int hotel_id,
  }) async {
    return handlingRequestResult<Create_BookingModel>(
      onSuccess: () async {
        final response = await dioHelper.post(
          endPoint: create_BookingEndPoint,
          token: token,
          data: {
            'user_id': user_id,
            'hotel_id': hotel_id,
          },
        );

        return Create_BookingModel.fromJson(response);
      },
      onPrimaryServerException: (e) async {
        return e;
      },
    );
  }
}
