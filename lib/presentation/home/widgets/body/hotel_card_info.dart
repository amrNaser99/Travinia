import 'package:flutter/material.dart';
import 'package:travinia/core/utils/app_values.dart';
import 'package:travinia/core/utils/routes.dart';
import 'package:travinia/models/coords.dart';
import 'package:travinia/models/hotel_model.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_image.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_name_and_location.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_price_per_night.dart';
import 'package:travinia/presentation/home/widgets/body/hotel_rating_and_distance.dart';
import 'package:travinia/services/geo_locator/geo_locator_helper.dart';

class HotelCardInfo extends StatefulWidget {
  final HotelModel hotel;
  const HotelCardInfo({super.key, required this.hotel});

  @override
  State<HotelCardInfo> createState() => _HotelCardInfoState();
}

class _HotelCardInfoState extends State<HotelCardInfo> {
  late Coords location;
  @override
  void initState() {
    location = Coords(
      lat: double.parse(widget.hotel.latitude),
      lon: double.parse(widget.hotel.longitude),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.hotelDetailsScreen,
        arguments: widget.hotel,
      ),
      child: SizedBox(
        height: AppHeight.h130,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              HotelImage(),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(AppSize.s8).add(EdgeInsets.only(
                    top: AppHeight.h4,
                    bottom: AppHeight.h4,
                    right: AppWidth.w2,
                  )),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HotelNameLocation(
                              location: widget.hotel.address,
                              name: widget.hotel.name,
                            ),
                            HotelDistanceAndRating(
                              distance: GeoLocatorHelper.myLocation != null
                                  ? GeoLocatorHelper.getDistanceFrom(location)
                                  : null,
                              rate: widget.hotel.rate,
                            ),
                          ],
                        ),
                      ),
                      HotelPreicePerNight(price: widget.hotel.price)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
