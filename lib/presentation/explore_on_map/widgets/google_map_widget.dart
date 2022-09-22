import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/presentation/explore_on_map/block/map_cubit.dart';
import 'package:travinia/presentation/explore_on_map/block/map_state.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  @override
  void initState() {
    setState(() {});
    super.initState();
    MapCubit.get(context).MylocationMarkMap(
        lat: AppCubit.get(context).myLat, long: AppCubit.get(context).myLong);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapStates>(
        listener: (context, state) {},
        builder: (BuildContext context, State) {
          if (State is LocationLoadingState) {
            return CircularProgressIndicator();
          }
          return Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: MapCubit.get(context).mylocationMark!,
              markers: MapCubit.get(context).markers,
              onMapCreated: (GoogleMapController controller) {
                MapCubit.get(context).controllerGoogleMap.complete(controller);
                MapCubit.get(context).newGoogleMapController = controller;
                // _setMapStyle();
                if (ThemeData.dark() == true) {
                  MapCubit.get(context).blackThemeGoogleMap();
                } else {
                  MapCubit.get(context).lightThemeGoogleMap();
                }
              },
            ),
          );
        });
  }
}
