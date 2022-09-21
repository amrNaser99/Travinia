class HotelModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String longitude;
  final String latitude;
  final String rate;
  final String created_at;
  final String updated_at;
  final List<HotelImages> hotel_images;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.rate,
    required this.created_at,
    required this.updated_at,
    required this.hotel_images,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      address: json['address'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      rate: json['rate'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      hotel_images: List<HotelImages>.from(
          json["hotel_images"].map((x) => HotelImages.fromJson(x))),
    );
  }
}

class HotelImages {
  final int id;
  final String hotel_id;
  final String image;

  HotelImages({
    required this.id,
    required this.hotel_id,
    required this.image,
  });

  factory HotelImages.fromJson(Map<String, dynamic> json) {
    return HotelImages(
      id: json['id'],
      hotel_id: json['hotel_id'],
      image: json['image'] as String,
    );
  }
}
