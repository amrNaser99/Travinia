import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/core/utils/app_themes.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_state.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    setState(() {});
    super.initState();

    MapCubit.get(context).HotelLocationMarkMap(
        lat: 30.3,
        long: 33.33,
        hotelName: 'test',
        hotelPrice: '\$200-fixed',
        key: globalKey,
        context: context);
    MapCubit.get(context).HotelsLocationMarkMap(
      context: context,
    );
    MapCubit.get(context).MylocationMarkMap(
        lat: AppCubit.get(context).myLat, long: AppCubit.get(context).myLong);
    MapCubit.get(context).markers.addAll(MapCubit.get(context).listMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapStates>(
        listener: (context, state) {},
        builder: (BuildContext context, State) {
          if (State is LocationLoadingState) {
            return CircularProgressIndicator();
          }
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition:
                          MapCubit.get(context).mylocationMark!,
                      markers: MapCubit.get(context).markers.toSet(),
                      onMapCreated: (GoogleMapController controller) {
                        MapCubit.get(context)
                            .controllerGoogleMap
                            .complete(controller);
                        MapCubit.get(context).newGoogleMapController =
                            controller;

                        if (AppThemes.darkTheme == false) {
                          MapCubit.get(context).lightThemeGoogleMap();
                        } else {
                          MapCubit.get(context).blackThemeGoogleMap();
                        }
                      },
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.70),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
