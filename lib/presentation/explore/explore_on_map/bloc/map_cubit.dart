import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travinia/core/app/bloc/app_cubit.dart';
import 'package:travinia/presentation/explore/explore_on_map/bloc/map_state.dart';
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
        '''<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="640" height="480" viewBox="0 0 640 480" xml:space="preserve">
<desc>Created with Fabric.js 3.6.3</desc>
<defs>
</defs>
<rect x="0" y="0" width="100%" height="100%" fill="rgba(255, 255, 255, 0)"></rect>
<g transform="matrix(1 0 0 1 306 182)">
<line style="stroke: rgb(0,0,0); stroke-width: 2; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;" x1="0" y1="0" x2="0" y2="0"></line>
</g>
<g transform="matrix(1 0 0 1 3.05 2.05)">
<path style="stroke: rgb(120,193,136); stroke-width: 0.1; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(120,193,136); fill-rule: nonzero; opacity: 1;" transform=" translate(0, 0)" d="M -2 0 C -3 0 -3 -1 -3 -1 C -3 -2 -2 -2 -2 -2 H 2 C 3 -2 3 -1 3 -1 C 3 0 2 0 2 0 H -2 L 2 0 M 0 2 L 0 0" stroke-linecap="round"></path>
</g>
<g transform="matrix(0.97 0 0 0.97 309.96 239.46)">
	<image style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAYAAAA10dzkAAAAAXNSR0IArs4c6QAAIABJREFUeF7t3Ql8XGW9//Hv70y6sLihoLgg7gviinpFaTIFxTZJRbFFQdukFXFH8V68CM1M0gLqXbziWqFJi+LF9qrYJEUQmrSoXAH1uiCK8me7grIjbWmb5Pz+r1PCFaFtkpkzM8+Z+eT14gWa8zzP7/d+DuX7OjPnHBM/CCCAAAIIIIAAAg0lYA3VLc0igAACCCCAAAIIiADISYAAAggggAACCDSYAAGwwTacdhFAAAEEEEAAAQIg5wACCCCAAAIIINBgAgTABttw2kUAAQQQQAABBAiAnAMIIIAAAggggECDCRAAG2zDaRcBBBBAAAEEECAAcg4ggAACCCCAAAINJkAAbLANf3S7c4bOfWbOp70oMt/fTfvJ7EmSnuQe7yft/OcnStpP8uR3+8m1d4OT0T4CCCDQ2AKmre52j+T3SrrXpHskuzf53252j9zv9Z2/s7viGfrDtm03/+9wvjja2GjhdU8ADG9PKlWRzbvs3APGotwrFfnrzO11kr1KpgMlRZValHkRQAABBBpZwGOZ/dlkv5DrKnO/SnvN+MW6fzj+DkneyDK17p0AWOsdqND6xwz1PXG7jx0SWe61Mn+dyQ6T6dlyTa/QkkyLAAIIIIDAhAIujZjsZknXmHSVRboqGvNrL8p33jfhYA5ITYAAmBpl7SdqveKCJ9nYaIspfo+kZpeeXPuqqAABBBBAAIEJBZKPjIct0gVbd9jw5UctunvCERxQlgABsCy+2g9uv2bF3vHmma+XxyeY6a2SnlH7qqgAAQQQQACBEgVMt0n6gckv2L6t6aeXHr1wS4kzMWwPAgTADJ4eL12zZvrB+297eeRjC5TT2yQ9X873+DK4lZSMAAIIILAbAZfcZDeYx983+YUz7rz1V2sXFHcAlo4AATAdx8rP4m7zftz7wnjU3iGzd5rrUJemVX5hVkAAAQQQQKDWAj4q2W9cWisb/d7grD/9XlaMa11VltcnAIa/ezZv4+pXjik+2Xzn1b7ksSz8IIAAAggg0JgCpr/K9X1F/h8DR3T+QmbcTVzCmUAALAGtWkPah/pe7JF/WG7HSdq/WuuyDgIIIIAAAsELuO4207dHI//yxbMW/zb4egMrkAAY2IYk5bztkt5njc2M3u/uS0w7n9PHDwIIIIAAAgjsSsB0m0nnxyN+7uBRi/8fSJMTIABOzqkqR8277NynjuVy7zWzD0h6XlUWZREEEEAAAQTqQMClm9y0YsyaVl8y672310FLFW2BAFhR3slNnjy/T/H2+ebRR+X+MrErk4PjKAQQQAABBB4j4NeZ7EvyGWv688ffBdCuBYgaNT4z5g71vTUyFST9Q41LYXkEEEAAAQTqSeDqOPIz/7L3yPqfHXbSSD01lkYvBMA0FEuYY96lK58ez2j6qDw+UbyxowRBhiCAAAIIILBnAZfuN2llbrv/x/ePXnwrXn8TIABW+WyYv2ZNbvv+W94cm53u8jea+MC3ylvAcggggAACjSWQPCbmp7FHZ27VQT8YzudHG6v9XXdLAKziWTB3qO9pOdNHXTqJq35VhGcpBBBAAAEEpPti+dejsdw5A0cu+lOjgxAAq3EGrJmfm/PUtx4ZeXS6md7Ea9uqgc4aCCCAAAII/L1A8no5uX4SW3Tmg37jD4fzxYa9GkgArPC/HclVvyiyD8s9uerHw5wr7M30CCCAAAIITCTg0j2SvjYaNX2pUR8ZQwCc6Cwp9ffFYtQ2++C8xzrd5M2SolKnYhwCCCCAAAIIpCxgis31I1PT8hl3zNiwdsGCsZRXCHo6AmAFtqdlqG/mvpEtkfunJD2rAkswJQIIIIAAAgikIWC6Te6ftQdGzutvP2lrGlNmYQ4CYMq7lDzU2Ua3nWwWfcR5vEvKukyHAAIIIIBA+gLufr8s+sK2UTvn8qMW3Z3+CuHNSABMcU/mDJ37zMii00zRYkkzU5yaqRBAAAEEEECgggIubZOsb8z9cz/Id95UwaWCmJoAmNI2zNnU+9JcbEslzZeUS2lapkEAAQQQQACBagmYYrl9N4ps2bpZi35VrWVrsQ4BMAX1tqG+FiWvc3Mlf+cHAQQQQAABBLItcMWYefHi5sUbst3G7qsnrpSzs2vm51r3nzvfTGdIOqScqRiLAAIIIIAAAuEImPTbsTFfvjW6ZW09Pi+QAFjiucadviXCMQwBBBBAAIGsCNTxHcIEwBJOwp3hz/QhScljXg4oYQqGIIAAAggggEA2BJK7gj9r++74cv9h9fOYGALgFE+++deumf7gnZs/YLJ/dunAKQ7ncAQQQAABBBDInsCdkj5z9/R7v3rl4ac8mL3yH1sxAXAKu/iaa1ZMO/CBpvdL0WkyPWMKQzkUAQQQQAABBLIt8Ge5n7nXnbd8fe2C4o5styLuWZ3sBrYMDTXtrRuXRGaflnTQZMdxHAIIIIAAAgjUjcCtbrb8z7/b3vezk04ayXJXXAGczO4Vi1Fr/tkd5jvv9n3OZIZwDAIIIIAAAgjUn4BLN8m0bEt88/lZvjuYADjRuelubcOrj5d58pDnF010OL9HAAEEEEAAgboXuEFmPXv9Ze8L1i5YMJbFbgmAe941axvqXSCLlkrOc/6yeIZTMwIIIIAAApURuN5M3f1DN1+oYjGuzBKVm5UAuAfb9k2rjo1jL5h0aOW2gJkRQAABBBBAIJsCfp1ZVOxv7lgrybPUAwFwN7vVvqH3bR6pINmrsrSh1IoAAggggAACVRX4nzFX98X5zouqumqZixEAdwHYOtx3hMmLks0u05fhCCCAAAIIIFDnAiZtihUVB1sWDWWlVQLgo3aq9Yre59qYFV32HpPjk5UzmToRQAABBBCooYDL/jNy7+nPd/6uhmVMemkCziOoWq+44EmKRz5t7h+VNGPSihyIAAIIIIAAAg0t4NJI5H5O0965s7/3+kXJ6+OC/iEAjm9P8paPp22Z8TFzP03Sk4PeNYpDAAEEEEAAgfAETPe44rPiLVu+dPHcj20Pr8C/VUQAHLdo39h3vLu6eNZfyKcrtSGAAAIIIBC8wA2RR8V1+UUXhHxnMAFQUvum3maPrSipJfjTigIRQAABBBBAIHSBK8y82N+8eEOohTZ8AExu+ohG1Z3c9MGbkUM9TakLAQQQQACBbAmEflNIQwdAbvrI1r9MVIsAAggggEBWBJKbQuT68sj03NmXvnHhHaHV3bABcP61a6Zvu2vzx9ztn7npI7TTknoQQAABBBDIvoC736/Izr5n2r3nXHn4KQ+G1FHDBsC2jSsXynPJO36fH9KGUAsCCCCAAAII1I+ASzfJvTiYX3x+SDeFNGQAbLv8vNcpFyVv+phTP6cYnSCAAAIIIIBAmAJ+mdy7B/JLfhRKfQ0XAOes/+bjczNHzlBOJ8s1PZSNoA4EEEAAAQQQqFMB15gs/sLIdD/zksPfd08IXTZcAGzf1Nex83l/rueEsAHUgAACCCCAAAKNIGD/62aFweZFvSF021ABsG3DylfIoqJMx4SATw0IIIAAAggg0DgC7hqMTN39LZ1X17rrhgmAb7nk/H2mTR89zcw+KWlmreGzsL6PF9kwJ0kWNoUaEUAAAQSyK2DaIbN/27Z9+2cve/NJ99eykYb5b3v7hlULPEpe9eaH1BKctRFAAAEEEGgcgeRSQsNEjUltq7tuMFlhIN+RvCquZj8NsStzr1j9wmgs7pb0rppJh7gwl/hC3BVqQgABBBCodwHTd3JS9/ebO39dq1brPgC2DPXN3Fv6VGT6J0n71AqadRFAAAEEEEAAgUTApW1m+sxe0/b53NrDF9TkAdF1HwDbN61+m8dekPxVnHYIIIAAAggggEAYAvYbi1Xsn93xnVrUU9cBcO7l5z07F0XdbraoFrisiQACCCCAAAITCDTw15FM9k037xlo7vxDtc+Tug2Ar7lmxbSnb5l5int8mqQnVBuW9RBAAAEEEEAAgT0L2GYpPmts6+Z/v3jux7ZXU6tuA2Dr8Mq8WVSQq7maoKyFAAIIIIAAAmUINN4VwZ/EUnF9S+cPy1Cb8tC6DIDt16zY2x+YvtRMn3Rp2pRVsjSg8f5FydLuUCsCCCCAAAKTEfiXqCletu5NSx6YzMFpHFOXAbBtQ99cRSpIel0aSMyBAAIIIIAAAghUTMD0c7mKAy2d/RVb41ET110AnLP+m4/P7T2ShL+PS4qqBVmNdbjYVw1l1kAAAQQQCE6gzv8D6JJHpi80jUTLv3fUorur4V93AXDexr53xL7z6t/LqwHIGggggAACCCCAQPkCfp3LCoMtnWvLn2viGeoqAL79p6ufPLLVu930IZPXSW+8Rmfi05gjEEAAAQQaRqCerwaavjZiTT2XzHrv7ZXezzoJSQ8xtW1cdYKkLrm/sNJw1Zi/ns/xavixBgIIIIBAvQvU3UWSm92iwmDzotWV3rm6CYDzLl359Hi6dUv2vkqjMT8CCCCAAAIIIFAZATt/bEw9Fx/ZcUNl5n9o1roJgG3DfSfKvUtmz6wkGHMjgAACCCCAAAIVFPiLuRf684tXVHCN+giAc69Y/cJoLO6W9K5KYjE3AggggAACCCBQaQGT1qrJuvvf1HFtpdaqhyuA1j7Ud7JMZ7j05EpBMS8CCCCAAAIIIFAlgXslLw40d35RZg/fEpDq0pkPgG0bVr5CUVSUdEyqMkyGAAIIIIAAAgjUTMAHIvfudfkl11SihMwHwPbhVZ9waankT6oEEHMigAACCCCAAALVFnDpfnMVBvKd50hK/SpgpgPgvKHznh9bLvnu3/HV3hjWQwABBBBAAAEEKixwodtoz2DzidelvU7GA2Dve2KzLkkvSBuG+RBAAAEEEEAAgVoKuHSTmRUGmjvOT7uOzAbA1isueJKNbu+R7CP1cS9z2lvLfAgggAACCCDw0KenmY07SeVf1L4zevoPO/6uNHczsyLtw6vnuMUFuV6fJghzIYAAAggggECdCWT71Vo/l1QcaOnsT3NXMhkAX3PNimlP++u0Myyyf5Y0PU2QqsyV7ROxKkQsggACCCCAAAKJgI1Kfvbd0+89+8rDT3kwLZNMBsC5G3pfb5EVTXprWhDVmSfbl6GrY8QqCCCAAAIIIPBIAZN+aLF1r5vd8eO0ZDIZANs29J2iyM7g0S9pnQbMgwACCCCAAALhCthmyQsDLZ2fT+uRMJkLgDz6JdzTk8oQQAABBBBAoEICrm97lOsebF6YyiNhMhcA24f73utKHv3iz68QcerT7vzKn4/fg5Q58dQ5mBABBBBAAAEEpi5ws1tUGGxetHrqQx87IlNxhEe/pLHlzIEAAggggAAC2RTwr8ZuPevznX8ut/5MBcC2DX1zFakg6XXlNs54BBBAAAEEEEAgUwKmn8vTeSRMdgKgu7VuXHWGSWdk8tEvmTrDKBYBBBBAAAEEQhNwaUTSsi1+8NnD+fxoOfVlJgDOvWL1C6OxOHnv77vKaZixCCCAAAIIIIBAVgXctTZy6+6f3XFtOT1kJgC2b1h1bBx5waRDy2mYsQgggAACCCCAQGYFXL+L3QrrZ3esKaeHbATANfNzrQe0nm7y0/n4t5ztZiwCCCCAAAIIZFrANSZp+V4H7HPW2kMW7Ci1l0wEwNaN578kise63TS/1EYZhwACCCCAAAII1IOAS9/NRVH3ulmLflVqP5kIgO0bVi3wSMmz/w4ptVHGIYAAAggggAACdSJwvbsKg/nOC0vtJ/gA+JprVkw7cPP0pZKfJllTqY0yDgEEEEAAAQQQqAsBU+zys++Zdt+ZVx5+yoOl9BR8AGwdOv9lURQX3f3YUhpkDAIIIIAAAgggUG8C7v79XBR3r2t+3y9K6S34ANh+ee+7PZe8+k0vLqVBxiCAAAIIIIAAAnUocIPMCgPNHReU0lvQAXDO+nNm5PZ+fEHyT0mKSmmwGmN2vutX4+/6rcaCrIEAAggggAACjS1Q5sfAQQfAtg0rX6EoKko6prF3me4RQAABBBBAAIFHC/hA5N69Lr/kmqnaBB0AW4d632O28+PfF0y1MY5HAAEEEEAAAQRKEsjIR3su3WQPfQx8/lT7DDYAZuXj36mCczwCCCCAAAIIIJCSgJvrcw9o6/Lh/Ic3T2XOYAPgvI2rXxW7FyWfN5WGOBYBBBBAAAEEEGgggfWKou6BWYuumkrP4QbA4b75sVSQxMOfp7KjHIsAAggggAACDSTgf0w+Bu5v7vzWVJoONgC2Dvd92qSlkmZOpaGqHpuR7whU1YTFEEAAAQQQQKCKAj5qrmL/xlvOVrEYT3bhIAPgvMvOferYtKZuc5002UY4DgEEEEAAAQQQaEQBN1tpkfUMHLHolsn2H2QAbBte/QYpTh7/8pbJNsJxCCCAAAIIIIBAQwq4hs292D978cbJ9h9kAOTxL5PdPo5DAAEEEEAAAQR0S+wqrM93rpqsRXgBsFiM2vLPXmqu012aNtlGOA4BBBBAAAEEEGhMAY9NWj7zjlvOXLuguGMyBsEFwLdt7H3WmKtbss7JNMAxCCCAAAIIIIAAAvpG5GM96/Lv++NkLIILgO2beps9tuT7fy2TaYBjEEAAAQQQQACBRhcw149jeXEwv/iyyVgEFwBbN/YtNvcuyZ49mQY4BgEEEEAAAQQQaHQBM7vd3QsDLZ3nTsYiqADYMlRs2kcHFS2y0+SKJtMAxyCAAAIIIIAAAggkAn723dPvW3bl4ac8OJFHUAHwmB+vet7oqHfLdcJEhfN7BBBAAAEEEEAAgb8TuNBttGew+cTrJnIJKgC2X77yLZ6Lkte/HT5R4fweAQQQQAABBBBA4O8ErpapONDcuX4il6ACYNumvg9YrC6XDpyocH6PAAIIIIAAAghUWyDwt8DebVJXf0vnVyZyCSYAdgz1zbzL1CPXPymYqibi4/cIIIAAAggggEBIAv65zf7gsuH8hzfvqapgolbbxr4XuHu3yd4dEmNSS+BpPzQu6kEAAQQQQACBWgm4vu1RrnuweeEevwcYTgC8YvWbFMdFuY6slRnrIoAAAggggAACmRZwJe8DLg7kO4ezcQVwaPU7ZV6Q/GWZhqd4BBBAAAEEEECgdgK/l0WFgeZF385GANy0+iOK4y5J+9fOjJURQAABBBBAAIHsCrh0v8m6Blo6zslGABzu65G0NLvkVI4AAggggAACCNRewKSzHnAtG853bttdNUF8B/Adm75x4I54tFvSibVnowIEEEAAAQQQQCDTAr3x2FjP+iPfd3PQAXDextWvit2Lks/LNDfFI4AAAggggAACtRdYryjqHpi16KqgA2D78Oo5bnFBrtfX3owKEEAAAQQQQACBTAv8fOedwC2d/UEHwLbh3k6XdZl0cFDcPAAwqO2gGAQQQAABBBCYjID9yU2FweaOlUEHwNbhvk/bQzeAzJxMWxyDAAIIIIAAAgiEIZBcLQriloq/cbjGTF7ozy8+6xHvs/g7rppXPGf9Nx+f22ukR6aTw9hIqkAAAQQQQAABBDIuYHaOxdOX9eePv2tXndQ8AM69YvULo7E4uQP4XRmnpnwEEEAAAQQQQCAIAXetjdy6+2d3XBtkAGwd7jvCpKKk2UGIUQQCCCCAAAIIIJBxAZNtimXFwZZFQ0EGwHnDffNjqSDpkHCsA/w8PxwcKkEAAQQQQACB8AWud1dhMN95YZABsG1D78cUJTeA2FPCt6RCBBBAAAEEEEDg7wWCfGiI6a+SugaaO78QZABsHe7tNrMz5Io4oRBAAAEEEEAAgawJBBkAE0RTcWDWzctkxfjRpjW9CeS9vzx/n3vvH+tRrFOyttnUiwACCCCAAAIIJAKhBkCXfV65acsGjzjh3qACIO8A5l8cBBBAAAEEEECgMgJuttIi6xk4YtEtQQVAHgFTmQ1nVgQQQAABBBCookCglwBNWqsm6+5/02MfBVPTj4DnDp1/WC6Ki+7eWsVtYikEEEAAAQQQQKD+Bdwv0Zh3Dxy15MqgrgDO2dg7O5IVzDWr/neBDhFAAAEEEEAAgWoK+JVmXuxvXnJpUAGwfajvmOQZgGZ6ZTU5WAsBBBBAAAEEEKh/AfuNxSr2z+74TlABsG3jyoXyqEvS84LZhEA/xw/Gh0IQQAABBBBAICMCdou5F/rznasCC4CrPmzuXS4dkBFJykQAAQQQQAABBLIicJ9JXf0tnV8MKwAOrzrNpKUu3ysrktSJAAIIIIAAAghkRGDM3QqD+Y4zwwmAxWLUmj+ox9xOzwgiZSKAAAIIIIAAApkSMNdnt+/ILbv06IVbHll4zR4Dc/QPzttv2oxcj0wfzpQkxSKAAAIIIIAAApkR8K/Gbj3r851/DiIAvnWo7+Am827JFmbGkEIRQAABBBBAAIEMCZjsm27eM9Dc+YcgAuC8y859edyUK0r29lAcuQE4lJ2gDgQQQAABBBBIRcB8nUzdA7MW/zyMALhp1RvjOE4C4FGpNMgkCCCAAAIIIIAAAo8WGLYoV+yftXBjEAGwdaj3KLOoIPmb2CsEEEAAAQQQQACBCgiYfhrHKq7Pd/4giAA4Z3j1nMjj5C0gr69Au0yJAAIIIIAAAgggYPpZHHtxfX7xQBABsG24r12mglyvYXcQQAABBBBAAAEEKiLwS3MV+/OdFwUSAFe/XYoLkl5RkXaZFAEEEEAAAQQQqLpAcktpzZ6y95huTfqte1QYyC/6ryACYPuGVQs8Upfkh1R9b1gQAQQQQAABBBBoDIHr3VUYzHdeGEYA3Nh3vHsSAPWixvCnSwQQQAABBBBAoOoCN5pU6G/p/EYQAbB1qHeRWRIA7blVp2BBBBBAAAEEEECgMQRulbww0LK4L5AAuHKJWZRcATyoMfzpEgEEEEAAAQQQqK6Amd3ungTAznODCIDtG3tPcrckAD69uhSshgACCCCAAAIINIqA3ZXcczE4q+OrQQTAto2rPmzuXS4d0ChbQJ8IIIAAAggggECVBe4zqau/pfOLQQTA1qG+j1ukpXLtV2WIXS/Hi4CD2AaKQAABBBBAAIH0BNy1xVxdA7M7/z2IANg+tOoffWcA9Men1yYzIYAAAggggAACCPyfgPt27QyAiz8XRABsG+49TbKlkvZimxBAAAEEEEAAgXoQCPADxTGXugZbOs8KIgC2DvctjaSlLk2rhw2nBwQQQAABBBBAIESB8QC4LIgA2Dbc1yMpuQLIDwIIIIAAAggggEDlBJbdvu+OZT877KSRh5eo2cvq2jb2FXcGQFdUuX6ZGQEEEEAAAQQQaHABs+V7PWXvZWsPWbCj9gFwqPcM2c7vAE5v8G2hfQQQQAABBBBAoGICFnuhf/bi5CPgh7+iqJpdAWzd2Pcp850fAe9TsY6ZGAEEEEAAAQQQaGgBj5PHwPTnF5/5SIbaBcChVZ808yQAPqGh94XmEUAAAQQQQACBSgkE9xiYob6TZTuvAD65Uj0zLwIIIIAAAgggUF2B5FPWml1f20WrtvmhN4F0fD6IK4Dtw30fcvcumT21uhvDaggggAACCCCAQMMI3Df+GJgwXgXXNtx3ouRdkj2zYbaARhFAAAEEEEAAgeoK3KlIXQOzOr8WxBXAtuHeTpd1mXRwdR1YDQEEEEAAAQQQqIxAcG8CMd2m2AsD+cXnBREA5w31vic265L0gspsAbMigAACCCCAAAINL3BL7Cqsz3euCiIAtm1cfZzcC5K/pOG3BgAEEEAAAQQQQKAyAjfIrDDQ3HFBEAGwfcOqY+PICyYdWpl+mRUBBBBAAAEEEGh4gd+ZWaG/uWNNEAFw3sZV8+KdVwD16obfGgAQQAABBBBAAIHKCPzaTcXB5s7vBhEA2zb0zVWkJAC+rjL9MisCCCCAAAIIINDoAv4LNy8ONi9ZF0QAbL985Vs8FyUB8PBG3xr6RwABBBBAAAEEKiJgdpW5FftbFl0cRABsHV6ZN4sKcjVXpGEmRQABBBBAAAEEEPhJLBXXt3T+MIgAOGeo7x8iqWimo9kbBBBAAAEEEEAAgUoI2GVy6x7IL/pRGAFwU+9Lc2Pqltk7K9FuKXMG9/DGUppgDAIIIIAAAggg8H8C/j3F3j0we8kvwwiAQ+c+M2dN3ZIWB7NLJMBgtoJCEEAAAQQQyJ5AEiQsqLLNtToe857Boxb/vzAC4H9/8/G5B0d6ZDo5KCmKQQABBBBAAAEE6kTApC9q3xk9/Ycdf1cQATApom24r0eupYGF5TrZctpAAAEEEEAAgUYXcPcz4wc3L7t47se2BxQAe081aanL9g1hg/gEOIRdoAYEEEAAAQQQSEPApRFzdQ3kOz/z6Plq+kF121DfB9zUZdKBaTTKHAgggAACCCCAAALjAq67zdTV39L5laACYPvGvuPd1SXpRWwWAggggAACCCCAQKoCN5pU6G/p/EZQAXDu0Oo2My+Y/LBU22UyBBBAAAEEEEAAgV+aq9if77worAC4cdUs87hosjx7hAACCCCAAAIIIJCqwBVmXuxvXrwhqAA454fnvSo3LSpKNi/VdpkMAQQQQAABBBBocAE3DUau7v6WzqvDCoCXr3heLpreLdMJDb5HtI8AAggggAACWRVwaeeTRCysx0C77D8j957+fOfvwgqAm3r3z8VRt+QfzOqeUzcCCCCAAAIIIBCigMu/bmO5noEjF/0prAD4h/Uzcrff0aPYTw0RjpoQQAABBBBAAIGsCrj7v44/BPqvQQXApJjW4b6l0c6HQWtaVoGpGwEEEEAAAQQQCEzAXSoMtnQu21VdNX0QdFJQ+3Dfh9y9S2ZPDQyOchBAAAEEEEAAgawK3Cv3roH84i8FGQDnbeh7RxypIOnl4QgnX+WseTYOh4NKEEAAAQQQQCBjAn6dy5IrgGuDDICtG3sPl1vRpDdnTJZyEUAAAQQQQACBIAVMNmSm4rrmjk1BBsA5PAomyBOHohBAAAEEEEAguwJ7egRM0lXNP+ec/5M1e20d2dpj7v+YXWYqRwABBBBAAAEEwhFw2eeVm7a+nZqTAAAgAElEQVRs8IgT7g3yCmBSVNvwqlNt553Avm84dFSCAAIIIIAAAghkT8ClEXN1DeQ7P7O76mt+BTAprHWod5GZuiR7bvaYqRgBBBBAAAEEEAhK4FbJCgMtHX1hB8ANvUfbzjuB7Q1B8VEMAggggAACCCCQPYGrZSoONHeuDzoAtm1Y+QpFUVHSMdkzpmIEEEAAAQQQaESBne//DeGGisfg+0Dk3r0uv+SaoAPg3KG+p+XMul3+/kY8gegZAQQQQAABBBBIT8DOy1nc8/3mxbcGHQCT4tqG+3okLU2v+XRmCjfdp9MfsyCAAAIIIIBAnQm4L9/rzluWrV1Q3BF+ABxa+WFZ1CXpgDrbBtpBAAEEEEAAAQSqJXCfS12DLZ1f3NOCQdwFnBTYvmnVsR578kq4Q6slxDoIIIAAAggggECdCfzOzAr9zR1rMhEA24ZWvkmKijIdWWcbQTsIIIAAAggggEC1BIYtyhX7Zy3cmIkAOG/ovOfHluuWdHy1hFgHAQQQQAABBBCoM4EL3UZ7BptPvC4TAXD+tWumP3jXlm53+5TJg/lous5OCtpBAAEEEEAAgTIFQr5B1Fyf3b4jt+zSoxduyUQATIpsG+r7gJu6TDqwzL1hOAIIIIAAAggg0FgCrruTN6v1t3R+ZaLGg7rS1n75yrd4LkpuBDl8osL5PQIIIIAAAggggMAjBMyuMrdif8uiiydyCSoAHvPjVc8bHfVuuU6YqHB+jwACCCCAAAIIIPAIAdeFPjraM/jmPX//LxkRVABsGRpq2ie6sWiy0+SK2FQEEEAAAQQQQACBSQm4uZ/1gGz5cL5z20QjggqASbGtG/sWmyt5IPSzJyqe3yOAAAIIIIAAAghILt1uigsDLUvOnYxHcAGwbaivRabke4Atk2mAYxBAAAEEEEAAgUYXcNePJS8O5hdfNhmL8ALgD1cc5NOmd5vUMZkGOAYBBBBAAAEEEEDAzh8bU8/FR3bcMBmL4AKgisWoteWgM8zsdLmmT6YJjkEAAQQQQAABBBpXwGOTumfese+ZaxcsGJuMQ3gBUNK8od73xGbJ9wBfMJkmOAYBBBBAAAEEEGhYAdfNLi8M5hevnqxBkAGwdWPv4XIrmvTmyTbCcQgggAACCCCAQOoCIb/2Y7xZkw2ZqbiuuWPTZPsPMgDOHep7Ws6s2+Xvn2wjHIcAAggggAACCDSigLtW2mjUM/DmRbdMtv8gA2BSfNvwqtNMWuryvSbbDMchgAACCCCAAAKNJWCjydW//qGbzlaxGE+292ADYPvGVQti94JJL51sMxyHAAIIIIAAAgg0mMAfTFbob+n4z6n0HWwAnDvU98qcVHTT26bSEMcigAACCCCAAAINI2BaL4u6B2YtumoqPQcbAOesP2dGbu99C5KdKik3laY4FgEEEEAAAQQQaACB5PVvn9u+o2nZpUcv3DKVfoMNgEkT7Rv7jveHXgv3oqk0Vc1jM3BzUDU5WAsBBBBAAAEEqiTg0k1mVhho7jh/qksGHQDnbuw7NOcquvSOqTbG8QgggAACCCCAQJ0L9HvOugeP6PjZVPsMOgC+5poV0w7cPH2p5KdJ1jTV5jgeAQQQQAABBBCoSwFT7LGfvUW2fDjfuW2qPQYdAJNm2oZ6j7PIuty5G3iqm8vxCCCAAAIIIFCfAu66Ibn7dyDfcUEpHQYfAOds6n1pbkzdMntnKQ0yBgEEEEAAAQQQqEOBi2JX9/p85/+U0lvwAXD+mjW5B/ffcoZMn5Y0vZQmGYMAAggggAACCNSRwJjLz9x7/33PXHvIgh2l9BV8AEyaat+06liPvSDp0FKarOoYbguuKjeLIYAAAggg0IACv5dFhYHmRd8utfdMBMB5G1a+KDZLPgY+rtRGGYcAAggggAACCNSFgNt/uaLuwfzC35TaTyYCIB8Dl7q9jEMAAQQQQACBehJwaUTSsi1+8NnD+fxoqb1lIgAmzbUP9R3jpuRj4FeW2izjEEAAAQQQQACBjAtcK/fiQH7xf5XTR2YC4Lyh854fW65b0vHlNMxYBBBAAAEEEEBgp0A2v7d/odtoz2DzideVs4uZCYByt/bh1Z+W6XSX71VO04xFAAEEEEAAAQSyJpDWx79J39kJgJJaN/QebVHyMbC9IWubRr0IIIAAAggggECZAlfLVBxo7lxf5jzZCoDzf7jiCQ82Te92s4+ZPFPhtdyNYjwCCCCAAAIINLiA2TkWT1/Wnz/+rnIlMhei2jauPk6ePBPQX1Ju84xHAAEEEEAAAQSyIeB/NLNCf3Pnt9KoN3sB8IerD7JpcbdLHWkAMAcCCCCAAAIIIJABgW9EPtazLv++P6ZRa+YCYNJ063DvB03WJelpaSAwBwIIIIAAAgggELDAvYqiroFZi76UVo2ZDIBtG1a+QlFUlHRMWhDMgwACCCCAAAL1LZDNp74ke+IDkXv3uvySa9LaoUwGQBWLUVvLQZ+S7HRJ+6SFwTwIIIAAAgggUIcC2U1+yWZsN7dlt12//XM/O+mk5C0gqfxkMwAmbwbZ1NvssSVXAVtSkWASBBBAAAEEEEAgOAH7kSIVB2Z1XJ5maZkNgPN/smavrdu3FMz0j5JyaaIwFwIIIIAAAgjUgUC2r/wlLypxi/WvY9seWH7x3I/9Nc0dyWwATBAy/37gh0/MpJlM70SapyRzIYAAAggggMBDAvYbi1Xsn93xnbRFMh075m/q3f9Btx65PpA2DPMhgAACCCCAAAI1FXA7L7cj7vn+0YtvTbuOTAfABKNtuLfTZV0mHZw2DvMhgAACCCCAAAK1EDCz2929MNDSeW4l1s98AJx7+XnPzkVR8nq4RZUAYk4EEEAAAQQQQKAGAt+K4rhn3ewlv6/E2pkPgAlK61DvIjN1SfbcSiBVdc6Mf2G1qlYshgACCCCAQF0K2J/cVBhs7lhZqfbqIgDOu+zcp45Na+o210mVgmJeBBBAAAEEEECgOgJ2Xs7inu83p//dv4frr4sAmDTTvmHVAo+Sq4B+SHU2h1UQQAABBBBAAIHUBf5gskJ/S8d/pj7zIyasmwDYesUFT7KxkaLLP2o8VKWS5wxzI4AAAggggEClBMy+tKMpWnbpGxfeUaklknnrJgAmzbRuWDXPIi9IenUl0ZgbAQQQQAABBEIQSL44X1dR5tfKRYWBIxZ9r9K6daU2f+jL+z7oe3cpsk9I3lRpPOZHAAEEEEAAAQRSETDFJv98LrblF+U770tlzj1MUlcBMOlz7nDfm81UMNcbK43H/AgggAACCCCAQEoCV8tUHGjuXJ/SfHucpu4CYMtQ38x9TJ826VRJM6qByBoIIIAAAgggUEGB8Uek+XhqqbvwIh8112e372g6+9KjF26poOT/TV1/hsl3AYf7jjB5UbLZ1UBkDQQQQAABBBBAoAyBK8y82N+8eEMZc0xpaF0GwJahoaZ9/KZTo8hPc9m+UxLhYAQQQAABBBBAoFoC7tvNorMecP/ccL5zW7WWrcsAmODNHTr/sFwUF929tVqYNV2HN4jUlJ/FEUAAAQQQKEXApB9abN3rZnf8uJTxpY6p2wAod2sb7v2QLDpD0tNKBWIcAggggAACCCBQEQHTPXLr3uuOvb+8dsGCsYqssZtJ6zcASnr7JecfMDpjrOCmD8gVVRO25mtxRbDmW0ABCCCAAAII7EHAZVoRbY+XrXvLktuqLVXXATDBbB1emTeLCnI1VxuX9RBAAAEEEEAAgV0L+JUP3fix5NJaCNV9AFSxGLW1HPQRyZKPgvevBTJrIoAAAggggAACjxC4zyLreWDspi8O54ujtZCp/wAo6R2bvnHgSDxSjGUn8p7gWpxmrIkAAggggAAC/yfgdl5uR9zz/aMX31orlYYIgAkubwjZ3SnmUv0+WbNW/16xLgIIIIAAArsTqOobP3ZXRMMEwASgbajvZJmWSnoy5+XEAtxHMrERRyCAAAIIIDBZAZful/vyPz9u5As/O+ykkcmOq8RxDRUA5wyd+8yc5brltlgN1XklTh3mRAABBBBAAIGpCVhfk3vPRfnOm6Y2Lv2jGy4GtW3om6tIBUmvS5+TGRFAAAEEEEAAgV0ImH4uV3GgpbM/BJ+GC4CvuWbFtAM3z/iE5KdJemIIm0ANCCCAAAIIIFC/Au7aYuZnjm3d/O8Xz/3Y9hA6bbgAmKAfM9R38Kh5t2QLQ9gEakAAAQQQQACBOhZwXRCPjfSsP+r914fSZUMGwASfB0SHcgpSBwIIIIAAAnUs4Ppvdy8Ozl58SUhdNmwATDahfVNfh8fqkvSckDaFWhBAAAEEEECgLgRudbfuwZZFvTJ7+OEaQTTW0AGwZahv5j6mU0w6VdITgtgRikAAAQQQQACBzAsk3/uT6bMj23P/funRC7eE1lBDB8BkM+Zddu5Tx5qaukw6SVIutA2iHgQQQAABBBDImIAp9ljnWhwtGzhy0Z9CrL7hA+DOELhp9cvj2IuSvz3ETaImBBBAAAEEEMiOgJsGI1d3f0vn1aFWTQAc35m5Q71tJhXM7LBQN4u6EEAAAQQQQCB4gV9JcXGgZcn3Qq6UAPjw7qyZn2t72twTNaYzZHpGyJtGbQgggAACCCAQpMBfTOqZecc+K9YuWDAWZIXjRREAH7E77/3l+fvce+/YpySdImmfkDeO2hBAAAEEEEAgHAGXtsns37bv2P4vl735pPvDqWzXlRAAH+Xytkt6nxXPtELsWmzijcGhn8DUhwACCCCAQAAC7q7VUTTa09984o0B1DNhCQTAXRC1buw9XG5Fk948oSAHIIAAAggggEBDC5hsyEzFdc0dm7ICQQDczU61b+h9m0cqSPaqrGwmdSKAAAIIIIBA1QX+Z8zVfXG+86Kqr1zGggTAPeC1b1p1bBx7waRDyzBmKAIIIIAAAgjUpYBfZxYV+5s71koK6k0fE3ETAPcsZG1DvQtk0VLJD5kIk98jgAACCCCAQMMIXG+m7v6hmy9UsRhnrWsC4EQ75m5tw6uPl/lSSS+a6HB+jwACCCCAAAJ1L3CDzHr2+sveF4T+uJfd7QQBcDLnaLEYteaf3WGuMyQ9ZzJDOAYBBBBAAAEE6k/ApZtkWrYlvvn84XxxNKsdEgAnuXMtQ0NNe+vGJZHZpyUdNMlhHIYAAggggAAC9SJgus3dl//59yPn/eykk0ay3BYBcAq795prVkw78IGm90vRabwtZApwHIoAAggggED2Bf4cx362b9u84uK5H9ue9XYIgFPcwfnXrpm+7c7NH3bZP0s6YIrDORwBBBBAAAEEsidwp6TP3D393q9eefgpD2av/MdWTAAsYRfn/2TNXg/u2PxRSf8k2VNKmIIhCCCAAAIIIJANgXvd9Nlonx1f7D/spK3ZKHniKgmAExvt8ogkBG7bseV97n6qzJ5Z4jQMQwABBBBAAIFwBf4k2ed2bI9WXnr0wi3hljn1ygiAUzf724hiMWqf9ax3utlSmb2snKkYiwACCCCAAAIhCdhvLNaymXft/Z2sPuplT5oEwBTOtdbLew+3nBVc9maTY5qCKVMggAACCCBQI4HkP+RDZtadpXf7TtWKsDJVsd0cP+fyFc/L5aadLrMT5Jqe0rRMgwACCCCAAAJVE/DkuX7fimI/a93sJb+v2rI1WIgAmCJ6+9C3nuLR9k/K9SFJj09xaqZCAAEEEEAAgQoKuGuLZF91+b+tz3f+uYJLBTE1ATDlbWjvX7G3HjftJJf9o6Snpzw90yGAAAIIIIBA+gJ/MbN/tdzYinVvWvJA+tOHNyMBsAJ7Mn/Nmty2p2w5Tjmd7q6XVmAJpkQAAQQQQACBdASuN2n5bb/fcWHW3+4xFQ4C4FS0pnhs64ZVr7GcTpN7u8T3AqfIx+EIIIAAAghUTMClEZnWm0VnDcxadFXFFgp0YgJghTfmmKG+J466FivSybxDuMLYTI8AAggggMBkBEy3yf0LI9vi8y556/vumcyQejuGAFilHR1/VMzpkr1F8qYqLcsyCCCAAAIIIPA3gTHJLs/Jl3+/pfNHkrxRcQiAVdz5t1+2+smj0/wD7v4RSU+r4tIshQACCCCAQGMLmO7wMf9y3KSvXjxrcfJu34b+IQBWe/uLxWhO/qCWnNvpklokRdUugfUQQAABBBBoGAFTbK4fjUnL1zfffLmsGDdM73tolABYo7PgHZu+ceBIPPoRl79fsqfUqAyWRQABBBBAoJ4F7pPrayO5pnMumfXe2+u50an2RgCcqljKx7du6D3aIhUke0PKUzMdAggggAACjStg+qlF0fIHRg/6wXA+n7zhg59HCBAAAzgd5l+z5glbt2w+xlwnu+yVJrEvAewLJSCAAAIIZEvApeQ9vr+W+xdHtsffbdQ7fCezawSNyShV6Zj5Pzlvvwd35I6V7CMuHWo7z2N+EEAAAQQQQGACATf5dZJ9WfvOWNN/2PF3IbZnAQJGgGdI+9CKp7iajrMo+pDHeinXAwPcJEpCAAEEEAhF4Pex7Cuj06ILL33jwjtCKSr0OgiAAe/QvMvOferY9KZ3W6wPSnphwKVSGgIIIIAAAlUW8D/Gsq+PRU3f5AaPqdMTAKduVvURbZd/9RlxNP29kUXvk/S8qhfAgggggAACCIQjcLPcz1Oc6xs4ctGfwikrW5UQADO0X2//6eonj2wdO8pk73XTmyQ9IUPlUyoCCCCAAAKlCZj+KtmPPY6/lRsb++G6o078S2kTMephAQJgRs+Ftw71Hdwkb5PZuyW9WtLMjLZC2QgggAACCOxKYLukX7jr2xrzdYNHLb6xkV/dlvYpQgBMW7TK881fsya3df9tL5GNzjfZsZJeLClX5TJYDgEEEEAAgTQExlx+vVzfNfe1m+3Wa4fzRZ7hl4bso+YgAFYAtVZTtgz1zdzL7TVR5Meb1CbXQdxBXKvdYF0EEEAAgSkI3Oqm9crpgnuie6+58vBTHpzCWA4tQYAAWAJaFoYkYfBxPvI8We61rugwmV47fnXw8VmonxoRQAABBOpW4AFJv5PsGje/RnHuqntm3HUDoa+6+00ArK53TVd7yyXn79M0fewF0UNh8LWSHSZ58niZfWpaGIsjgAACCNSpgG+V7A/mukZRdLVJV23bZtdfevTCLXXacGbaIgBmZqsqU+j8a9dM3377/U8ay83YP4pGD4hjOyAy7e9mB5jrAHc/wCLt7zv/WQeY6XGSospUw6wIIIAAAmELeCwpuYJ3p8zu8Fh3mukOd78j+Xss3RnF0R1xzu9omjF6x4zHPeHetYcs2BF2T41ZHQGwMfedrhFAYM8CycPXi5IOmCLU1ZKOk5TcrcgPAgggEKwAATDYraEwBBCooUCpATAJfkdL+kMNa2dpBBBAYEIBAuCERByAAAINKFBqAEzeSjBb0vUNaEbLCCCQIQECYIY2i1IRQKBqAgTAqlGzEAII1EKAAFgLddZEAIHQBQiAoe8Q9SGAQFkCBMCy+BiMAAJ1KkAArNONpS0EEHhIgADImYAAAgg8VoAAyFmBAAJ1LUAArOvtpTkEEChRgABYIhzDEEAgGwIEwGzsE1UigEB1BQiA1fVmNQQQqLIAAbDK4CyHAAKZECAAZmKbKBIBBEoVIACWKsc4BBCoZwECYD3vLr0hgAA3gXAOIIAAArsQIAByWiCAQF0LcAWwrreX5hBAoEQBAmCJcAxDAIFsCBAAs7FPVIkAAtUVIABW15vVEECgygIEwCqDsxwCCGRCgACYiW2iSAQQKFWAAFiqHOMQQKCeBQiA9by79IYAAtwEwjmAAAII7EKAAMhpgQACdS3AFcC63l6aQwCBEgUIgCXCMQwBBLIhQADMxj5RJQIIVFeAAFhdb1ZDAIEqCxAAqwzOcgggkAkBAmAmtokiEUCgVAECYKlyjEMAgXoWIADW8+7SGwIIcBMI5wACCCCwC4FSA+B2Sa+W9FtUEUAAgZAFuAIY8u5QGwII1Eqg1ACY1HuopN/UqnDWRQABBCYjQACcjBLHIIBAowkQABttx+kXgQYTIAA22IbTLgIITEqAADgpJg5CAIGsChAAs7pz1I0AApUUIABWUpe5EUCg5gIEwJpvAQUggECAAgTAADeFkhBAID0BAmB6lsyEAAL1I0AArJ+9pBMEENiFAAGQ0wIBBBB4rAABkLMCAQTqWoAAWNfbS3MIIFCiAAGwRDiGIYBANgQIgNnYJ6pEAIHqChAAq+vNagggUGUBAmCVwVkOAQQyIUAAzMQ2USQCCJQqQAAsVY5xCCBQzwIEwHreXXpDAAHeBcw5gAACCOxCgADIaYEAAnUtwBXAut5emkMAgRIFCIAlwjEMAQSyIUAAzMY+USUCCFRXoJwAmJf0I0mj1S2Z1RBAAIHJCxAAJ2/FkQgg0DgC5QTAoyUNSRppHC46RQCBrAkQALO2Y9SLAALVECAAVkOZNRBAoGYCBMCa0bMwAggELEAADHhzKA0BBMoXIACWb8gMCCBQfwIEwPrbUzpCAIFHCBAAOR0QQACBxwoQADkrEECgrgUIgHW9vTSHAAIlChAAS4RjGAIIZEOAAJiNfaJKBBCorgABsLrerIYAAlUWIABWGZzlEEAgEwIEwExsE0UigECpAgTAUuUYhwAC9SxAAKzn3aU3BBDgXcCcAwgggMAuBMoJgCdIukjSVmQRQACBUAW4AhjqzlAXAgjUUqCcALhY0hpJW2rZAGsjgAACexIgAHJ+IIAAAo8VIAByViCAQF0LEADrentpDgEEShQgAJYIxzAEEMiGAAEwG/tElQggUF0BAmB1vVkNAQSqLEAArDI4yyGAQCYECICZ2CaKRACBUgUIgKXKMQ4BBOpZgABYz7tLbwggwGNgOAcQQACBXQiUEwBPlfR1SfcjiwACCIQqwBXAUHeGuhBAoJYC5QTAMyR9WdJ9tWyAtRFAAIE9CRAAOT8QQACBxwoQADkrEECgrgUIgHW9vTSHAAIlChAAS4RjGAIIZEOAAJiNfaJKBBCorgABsLrerIYAAlUWIABWGZzlEEAgEwIEwExsE0UigECpAgTAUuUYhwAC9SxAAKzn3aU3BBDgMTCcAwgggMAuBAiAnBYIIFDXAlwBrOvtpTkEEChRoJwA+B+SzpR0V4lrMwwBBBCouAABsOLELIAAAhkUWCrp45L2K6H2r0jqlnRHCWMZggACCFRFgABYFWYWQQCBjAksl/QhSU8qoW4CYAloDEEAgeoKEACr681qCCCQDQECYDb2iSoRQKBEAQJgiXAMQwCBuhYoJwCukfQJSbfVtRDNIYBApgUIgJnePopHAIEKCZQTAC+S9BFJf6pQbUyLAAIIlC1AACybkAkQQKAOBQiAdbiptIQAAn8TIAByNiCAAAKPFSAAclYggEBdCxAA63p7aQ4BBEoUIACWCMcwBBDIhgABMBv7RJUIIFBdAQJgdb1ZDQEEqixAAKwyOMshgEAmBL4m6QRJ+5ZQ7Y8kvUfSzSWMZQgCCCBQFQECYFWYWQQBBDIm0CtpgaR9Sqj7aknHSbqxhLEMQQABBKoiQACsCjOLIIBAxgQIgBnbMMpFAIGpCRAAp+bF0Qgg0BgCBMDG2Ge6RKBhBQiADbv1NI4AAnsQKCcAJh/9Hi3pDwgjgAACoQoQAEPdGepCAIFaCpQTAJM3gMyWdH0tG2BtBBBAYE8CBEDODwQQQOCxAuskvUXSjBJwCIAloDEEAQSqK0AArK43qyGAQDYELpHUIml6CeVul/RqSb8tYSxDEEAAgaoIEACrwswiCCCQMYFyAmDS6qGSfpOxnikXAQQaSIAA2ECbTasIIDBpgZ9JepWkUv+MzEtKHgg9OukVORABBBCookCpf7hVsUSWQgABBKou8GtJLytj1eQu4CFJI2XMwVAEEECgYgIEwIrRMjECCGRYgACY4c2jdAQQmFiAADixEUcggEDjCZQbAJP3CF8kaWvj0dExAghkQYAAmIVdokYEEKimwFMkXSHpxWUsuljSGklbypiDoQgggEDFBAiAFaNlYgQQyKjA08e/v/fCMuo/VdLXJd1fxhwMRQABBComQACsGC0TI4BARgXSCIBnSPqypPsyakDZCCBQ5wIEwDrfYNpDAIEpCxAAp0zGAAQQyJoAATBrO0a9CCBQaYGXS/qepOeWsdA3JH1K0u1lzMFQBBBAoGICBMCK0TIxAghkVOC1kr4t6Tll1J/cAfwRScl7gflBAAEEghMgAAa3JRSEAAI1FpgjaYWkZ5VRR/IWkPdIurmMORiKAAIIVEyAAFgxWiZGAIGMChwj6UuSnlFG/VdLOk7SjWXMwVAEEECgYgIEwIrRMjECCGRUYImkMyU9tYz6H5D0eknXlTEHQxFAAIGKCRAAK0bLxAggkFGBD0oqSjqgzPrzkpKPgkfLnIfhCCCAQOoCBMDUSZkQAQQyLrBU0scl7VdmHydLWiXpr2XOw3AEEEAgdQECYOqkTIgAAhkX+Jqk5F2++5bZB4+CKROQ4QggUDkBAmDlbJkZAQSyKfATSa+TlCuz/LskvV3Sf/MxcJmSDEcAgdQFCICpkzIhAghkVOApko6V1F3mDSCPbH+DpH+S9CtCYEbPCspGoE4FCIB1urG0hQACUxJIwt9HJb1r/A0gTVMavfuDt4/fCXySpJ8TAlNSZRoEEChbgABYNiETIIBAHQjMl7RM0vNT+Oh3VxxcCayDk4QWEKgnAQJgPe0mvSCAQCkCLx5/88c/SJpeygSTGJNcCfyMpHMk3TOJ4zkEAQQQqKgAAbCivEyOAAIZEEjrrt+JWk3eC7xA0lV8FDwRFb9HAIFKCxAAKy3M/AggELJA8t2/yyUdKqkafx72SPoCVwFDPiWoDYHGEKjGH3iNIUmXCCCQRYHku3//IenpVSqeq4BVgmYZBBDYswABkDMEAQQaWeASSS0V/O7frmx5Q0gjn3H0jkAgAgTAQDaCMhBAoOoCyce/V0hKbgKp5g9vCKmmNmshgMAuBQiAnC11zPEAAAdMSURBVBgIINCoAtX++Pdh5+QNIUdI+l2jwtM3AgjUXoAAWPs9oAIEEKiNwAWSjpG0926W/5GkmyQlj4c5WNJkHg6dhLpt41cVZ+6hrbykZP7R2rTOqggg0OgCBMBGPwPoH4HGFfiZpFft5u7fz0r6L0l3S3qhpLMkvXyCEJgEuuWS/iLpq5IO28PxJ0i6SNLWxuWncwQQqKUAAbCW+qyNAAK1EtjT9/+Sq3jHj7+/d0zSDEmfkpTcvLHfbgpOPtZdKCl540fy0OfkUS8dkh6/m+NPlfR1SffXCoB1EUCgsQUIgI29/3SPQKMKJFfzvjf+3t9HG1wt6ThJNz7iF7Ml9Uk6aDdgayR9QtJt47//uKRPS9p/N8efIenLku5r1A2gbwQQqK0AAbC2/qyOAAK1EZgz/vq3Z+1i+V0FwMdJGpT0ht18rPvoj3Q/KKko6QACYG02mFURQGDPAgRAzhAEEGhEgTdJSh7Hktzc8eifByS1SrryUTdpLJWUXNl79MfAyce/R0r6tSQfn2yiG0y4AtiIZx09IxCQAAEwoM2gFAQQqJrAayV9W9JzdrPirl7ZlrwtZK2k1z3qKuCy8beJ3DM+12ReL/cBSUlI3Fy1jlkIAQQQeIQAAZDTAQEEGlEg+Uj3p5Jespvmd/fKtg9J+vD4ncHJY2GSO3+T/++3kpIbRpKf3V0pfORSh0u66hFjGnEP6BkBBGooQACsIT5LI4BATQWGJCUfBe/u+X7JHb3/NH438MPP60uu7r1F0hslPTj+qJhfjN/5mzST3C2cXN1LvluY2013PAi6ptvO4gggkAgQADkPEECgUQUm+p5e8jiX6ySdL6l//KHQSRBMrh4+cfz7gXeO/z0JksljYpK/J3f+7i78JdaPvmO4Uf3pGwEEaihAAKwhPksjgEBNBZZIOlPSUyeoIvk4+HZJPx//K3nTR/KTXA18maRnSnqapBeMPzNwoqYe/Z3BiY7n9wgggEDqAgTA1EmZEAEEMiKQBLjkWYDJq94m85q35O7g5Ll9D3/XL3lAdPKg5+RVcpP9szT5+Pftkv6b18Bl5CyhTATqVGCyf2jVafu0hQACDS4w0Rs70ubh49+0RZkPAQRKEiAAlsTGIAQQqBOB5HEwyRs5kncCT+YqYLlt8w7gcgUZjwACqQgQAFNhZBIEEMiowGTe85tWaxdJ+uT4K+YefmB0WnMzDwIIIDAlAQLglLg4GAEE6lAgecBzcgfviZKeVKH+ku/+Je8XvkLSSIXWYFoEEEBg0gIEwElTcSACCNSxQBICk7tzF0jaN+U+k/CXPDx6QNLWlOdmOgQQQKAkAQJgSWwMQgCBOhRIXgv3wfG7dJN3BKfxncAk/BUkfVPSX+vQjJYQQCCjAgTAjG4cZSOAQEUEkiuBeUmnSnppmSEweU3cv0jaJOl+SXzvryJbxqQIIFCKAAGwFDXGIIBAPQskb/p4vqTkDuF3j/9z8qDnyV4RTIJf8paR5Fl/yZtEkjeK8IMAAggEJUAADGo7KAYBBAISSIJg8k7fw8Zf/faSR7z1IwmEyUOh/zz+QOffS/ofSf87/v/dLGkzV/0C2k1KQQCBvxMgAHJCIIAAAnsWSIJg8m7f5O97SZo5/ldyN2/yWrjko92H3xKS3OTBR72cUQggELwAATD4LaJABBBAAAEEEEAgXQECYLqezIYAAggggAACCAQvQAAMfosoEAEEEEAAAQQQSFeAAJiuJ7MhgAACCCCAAALBCxAAg98iCkQAAQQQQAABBNIVIACm68lsCCCAAAIIIIBA8AIEwOC3iAIRQAABBBBAAIF0BQiA6XoyGwIIIIAAAgggELwAATD4LaJABBBAAAEEEEAgXQECYLqezIYAAggggAACCAQvQAAMfosoEAEEEEAAAQQQSFeAAJiuJ7MhgAACCCCAAALBCxAAg98iCkQAAQQQQAABBNIVIACm68lsCCCAAAIIIIBA8AIEwOC3iAIRQAABBBBAAIF0BQiA6XoyGwIIIIAAAgggELwAATD4LaJABBBAAAEEEEAgXQECYLqezIYAAggggAACCAQvQAAMfosoEAEEEEAAAQQQSFeAAJiuJ7MhgAACCCCAAALBCxAAg98iCkQAAQQQQAABBNIVIACm68lsCCCAAAIIIIBA8AIEwOC3iAIRQAABBBBAAIF0BQiA6XoyGwIIIIAAAgggELwAATD4LaJABBBAAAEEEEAgXQECYLqezIYAAggggAACCAQvQAAMfosoEAEEEEAAAQQQSFeAAJiuJ7MhgAACCCCAAALBCxAAg98iCkQAAQQQQAABBNIVIACm68lsCCCAAAIIIIBA8AIEwOC3iAIRQAABBBBAAIF0BQiA6XoyGwIIIIAAAgggELwAATD4LaJABBBAAAEEEEAgXQECYLqezIYAAggggAACCAQvQAAMfosoEAEEEEAAAQQQSFeAAJiuJ7MhgAACCCCAAALBCxAAg98iCkQAAQQQQAABBNIV+P8XCsizgseU5QAAAABJRU5ErkJggg==" x="-320" y="-240" width="640" height="480"></image>
</g>
<g transform="matrix(6.57 0 0 6.57 333.89 170.34)" style="">
		<text xml:space="preserve" font-family="'Open Sans', sans-serif" font-size="30" font-style="normal" font-weight="normal" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-dashoffset: 0; stroke-linejoin: miter; stroke-miterlimit: 4; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1; white-space: pre;"><tspan x="-40" y="9.42">$price</tspan></text>
</g>
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
