import 'package:travinia/models/facility_model.dart';

class FacilitiesModel {
  final List<FacilityModel> facilities;

  FacilitiesModel({
    required this.facilities,
  });

  factory FacilitiesModel.fromJson(List json) {
    List<FacilityModel> resultOfFacilities = [];
    json.forEach((element) {
      resultOfFacilities.add(FacilityModel.fromJson(element));
    });
    return FacilitiesModel(facilities: resultOfFacilities);
  }
}
