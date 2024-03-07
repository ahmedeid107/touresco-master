import 'package:touresco/models/light_trip_model.dart';

class SingleFinanceModel {
  final String id;
  final String name;
  final double totalTripPrice;
  final double totalExpenses;
  final double totalCommission;
  final TripSource tripSource;


  SingleFinanceModel({
    required this.id,
    required this.name,
    required this.totalTripPrice,
    required this.totalExpenses,
    required this.totalCommission,
    required this.tripSource,
  });

  SingleFinanceModel.fromJson(Map<String, dynamic> json)
      : id = json['User_Id'],
        name = json['User_name'],
        totalTripPrice =
            double.parse((json['Total_Money'] as dynamic).toString()),
        totalExpenses = double.parse((json['Outlays'] as dynamic).toString()),
        totalCommission =
            double.parse((json['Comession'] as dynamic).toString()),
        tripSource = LightTripModel.getTripSourceFromString(json["User_Type"]);
}
