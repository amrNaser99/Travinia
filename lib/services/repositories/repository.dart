import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:travinia/core/error/exceptions.dart';
import 'package:travinia/models/hotels_model.dart';
import 'package:travinia/models/login_model.dart';
import 'package:travinia/models/profile_model.dart';

import '../../models/facilities_model.dart';

abstract class Repository {
  ///Implement All User Functions Here
  Future<Either<PrimaryServerException, LoginModel>> login({
    required String email,
    required String password,
  });

  Future<Either<PrimaryServerException, ProfileModel>> getProfile({
    required String token,
  });

  ///Implement All Hotel Functions Here
  Future<Either<PrimaryServerException, HotelsModel>> getHotels({
    required int page,
  });

  Future<Either<PrimaryServerException, FacilitiesModel>> getFacilities();
}

extension HandlingRequestResultFunction on Repository {
  Future<Either<PrimaryServerException, T>> handlingRequestResult<T>({
    required Future<T> Function() onSuccess,
    Future<PrimaryServerException> Function(PrimaryServerException exception)?
        onPrimaryServerException,
  }) async {
    try {
      final r = await onSuccess();
      return Right(r);
    } on PrimaryServerException catch (e, s) {
      debugPrint(s.toString());
      return Left(e);
    }
  }
}
