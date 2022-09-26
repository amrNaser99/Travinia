import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'core/functions/gelocator_permission.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travinia/core/app/bloc/bloc_observer.dart';
import 'package:travinia/core/app/travinia_app.dart';
import 'package:travinia/core/di/injection.dart';
import 'package:travinia/services/geo_locator/geo_locator_helper.dart';

Future<bool?> askPermission() async {
  PermissionStatus status = await Permission.location.request();
  if (status.isDenied == true) {
    return askPermission();
  } else {
    return true;
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  GeoLocatorHelper.determinePosition();


  runApp(const TraviniaApp());
  Bloc.observer = MyBlocObserver();

}
