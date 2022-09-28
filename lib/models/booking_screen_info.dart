import 'package:travinia/models/booking_details.dart';

class BookingScreenInfo {
  final String title;
  List<BookingDetailsModel> bookingList;
  List<int> loadingList;

  BookingScreenInfo({
    required this.title,
    required this.bookingList,
    required this.loadingList,
  });
}
