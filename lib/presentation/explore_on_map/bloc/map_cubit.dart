import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/presentation/explore_on_map/bloc/map_state.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(MapInitialState());

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
            double.parse(AppCubit.get(context).hotels[i].longitude)),
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
    String svgStrings = ''''
        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="640" height="480" viewBox="0 0 640 480" xml:space="preserve">
<desc>Created with Fabric.js 3.6.3</desc>
<defs>
</defs>
<g transform="matrix(4.7 0 0 5.34 322.63 137.88)"  >
<path style="stroke: rgb(76,192,159); stroke-width: 8; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(76,192,159); fill-rule: nonzero; opacity: 1;"  transform=" translate(-62.2, -20.73)" d="m 20.013628 0 l 84.37401 0 l 0 0 c 11.053215 -1.04756605e-14 20.013626 9.282301 20.013626 20.7326 c 0 11.450296 -8.960411 20.7326 -20.013626 20.7326 l -84.37401 0 l 0 0 c -11.053222 0 -20.013628 -9.282303 -20.013628 -20.7326 c -5.2380687e-15 -11.450298 8.960406 -20.7326 20.013628 -20.7326 z" stroke-linecap="round" />
</g>
<g transform="matrix(1 0 0 1 332.5 283)"  >
<line style="stroke: rgb(0,0,0); stroke-width: 2; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;"  x1="0" y1="0" x2="0" y2="0" />
</g>
<g transform="matrix(1.05 0 0 1.05 322.43 354.63)"  >
<line style="stroke: rgb(76,192,159); stroke-width: 17; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;"  x1="0" y1="-82.5" x2="0" y2="82.5" />
</g>
<g transform="matrix(0.28 0 0 0.28 323.23 450.23)"  >
<circle style="stroke: rgb(32,31,31); stroke-width: 24; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(41,41,39); fill-rule: nonzero; opacity: 1;" vector-effect="non-scaling-stroke"  cx="0" cy="0" r="40" />
</g>
<g transform="matrix(4.53 0 0 4.53 431.72 148.23)" style=""  >
		<text xml:space="preserve" font-family="Impact, Charcoal, sans-serif" font-size="42" font-style="normal" font-weight="normal" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1; white-space: pre;" ><tspan x="-62.65" y="13.19" >\$${price}</tspan></text>
</g>
</svg>
        ''';
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
