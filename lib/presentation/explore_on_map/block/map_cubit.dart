import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
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
  List<Marker> markers = [];
  List<Marker> listMarkers = [];
  final Completer<GoogleMapController> controllerGoogleMap = Completer();

  void mapCreated(controller) {
    newGoogleMapController = controller;
  }

  int? prevPage = 0;

  late PageController pageController;

  initPagecontroler(BuildContext context) {
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  onScroll(BuildContext context) {
    if (pageController.page!.toInt() != prevPage) {
      prevPage = pageController.page!.toInt();
      moveCamera(context);
    }
    emit(GetLocationLoadingSucess());
  }

  moveCamera(BuildContext context) {
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                double.parse(AppCubit.get(context)
                    .hotels[pageController.page!.toInt()]
                    .latitude),
                double.parse(AppCubit.get(context)
                    .hotels[pageController.page!.toInt()]
                    .longitude)),
            zoom: 14.0,
            bearing: 45.0,
            tilt: 45.0)));
    print('-------------------------------------');
    print('latLong coordinates' +
        LatLng(
                double.parse(AppCubit.get(context)
                    .hotels[pageController.page!.toInt()]
                    .latitude),
                double.parse(AppCubit.get(context)
                    .hotels[pageController.page!.toInt()]
                    .longitude))
            .toString());
    print('index of page' + pageController.page!.toInt().toString());
    print('-------------------------------------');
  }

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
    required GlobalKey key,
    required BuildContext context,
  }) async {
    emit(LocationLoadingState());
    hotelLocationMarkMap = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
    emit(GetLocationLoadingSucess());
    markers.add(Marker(
      markerId: MarkerId('hotelLocation'),
      position: hotelLocationMarkMap!.target,
      icon: await bitmapDescriptorFromSvgAsset(context, hotelPrice),
    ));
    emit(MylocationMarkMapSucess());
  }

  CameraPosition? hotelsLocationMarkMap;

  void HotelsLocationMarkMap({
    required BuildContext context,
  }) async {
    emit(LocationLoadingState());
    for (int i = 0; i < AppCubit.get(context).hotels.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(AppCubit.get(context).hotels[i].name),
        position: LatLng(double.parse(AppCubit.get(context).hotels[i].latitude),
            double.parse(AppCubit.get(context).hotels[i].longitude) + i / 100),
        // icon: await MarkerIcon.widgetToIcon(key),
        icon: await bitmapDescriptorFromSvgAsset(
            context, AppCubit.get(context).hotels[i].price),
        // infoWindow: InfoWindow(title: hotelPrice, snippet: hotelName)
      ));
      print(AppCubit.get(context).hotels[i].price);
    }

    emit(MylocationMarkMapSucess());
  }

  Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
      BuildContext context, String price) async {
    // Read SVG file as String
    // String svgString = await DefaultAssetBundle.of(context).loadString(assetName,);
    // Create DrawableRoot from SVG String
    String svgStrings =
        '''<svg width="75" height="50" xmlns="http://www.w3.org/2000/svg">

  <path stroke="#000" id="svg_1" d="m74.14781,0.22566l-73.83144,-0.00774l0,31.59256l30.27788,0l5.12395,17.65467c0.04658,0.00774 3.86625,-17.02746 3.86625,-17.02746c0,0 34.48279,0 34.42362,-0.00774c0.00739,0.00097 0.01513,-0.5015 0.02299,-1.38155c0.00393,-0.44003 0.0079,-0.97446 0.01188,-1.58755c0.00398,-0.61309 0.00796,-1.30486 0.01193,-2.05955c0.02677,-7.20252 0.04414,-12.03835 0.05589,-15.41562c0.01175,-3.37727 0.0179,-5.29597 0.02223,-6.66423c0.00433,-1.36826 0.00686,-2.18608 0.00844,-2.71689c0.00158,-0.53081 0.00223,-0.77459 0.00281,-0.99479c0.00058,-0.2202 0.00109,-0.4168 0.00154,-0.58784c0.00044,-0.17104 0.00082,-0.31653 0.00112,-0.4345c0.0003,-0.11796 0.00053,-0.2084 0.00069,-0.26935c0.00015,-0.06095 0.00023,-0.0924 0.00023,-0.0924c-0.0102,3.52301 -0.01745,6.03945 -0.02249,7.80293c-0.00505,1.76348 -0.00789,2.77399 -0.00928,3.28516c-0.00139,0.51116 -0.00132,0.52297 -0.00054,0.28903c0.00077,-0.23394 0.00225,-0.71362 0.0037,-1.18544c0.00144,-0.47182 0.00284,-0.93578 0.00419,-1.38991c0.00135,-0.45413 0.00266,-0.89844 0.00393,-1.33095c0.00126,-0.43251 0.00248,-0.85323 0.00364,-1.26018c0.00116,-0.40696 0.00228,-0.80015 0.00334,-1.17762c-0.02728,9.05903 -0.02086,7.04596 -0.0151,5.15867c0.00576,-1.88729 0.01086,-3.64879 0.0151,-5.15867c0.00848,-3.01976 0.01351,-5.03301 0.01351,-5.03301z" stroke-width="1.5" fill="#78c188"/>
  <text  y="16.77155" x="24.02531" fill="#ffffff">\$${price}</text>

</svg>''';
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(
      svgStrings,
      'globalKey',
    );

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        75 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 50 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
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
