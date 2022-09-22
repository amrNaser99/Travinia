import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_state.dart';
import 'package:travinia/presentation/explore_on_map/block/map_state.dart';
import 'package:travinia/services/repositories/repository.dart';

class MapCubit extends Cubit<MapStates> {
  final Repository repository;

  MapCubit({
    required this.repository,
  }) : super(MapInitialState());

  static MapCubit get(context) => BlocProvider.of<MapCubit>(context);

  GoogleMapController? newGoogleMapController;
  final Set<Marker> markers = {};
  final Completer<GoogleMapController> controllerGoogleMap = Completer();

  CameraPosition? mylocationMark;

  void MylocationMarkMap({
    required double lat,
    required double long,
  }) {
    emit(LocationLoadingState());
    mylocationMark = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
    emit(GetLocationLoadingSucess());
    markers.add(Marker(
        markerId: MarkerId('myLocation'),
        position: mylocationMark!.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: 'my location',
        )));
    emit(MylocationMarkMapSucess());
  }

  CameraPosition? hotelLocationMarkMap;

  void HotelLocationMarkMap({
    required double lat,
    required double long,
    required String hotelName,
    required String hotelPrice,
  }) {
    emit(LocationLoadingState());
    hotelLocationMarkMap = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
    emit(GetLocationLoadingSucess());
    markers.add(Marker(
        markerId: MarkerId('myLocation'),
        position: hotelLocationMarkMap!.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: hotelPrice, snippet: hotelName)));
    emit(MylocationMarkMapSucess());
  }

  lightThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
      []
      ''');
  }

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]
                ''');
  }
}
