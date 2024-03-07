import 'package:touresco/models/light_trip_model.dart';

class SingleTripFinanceModel {
  final String id;

  final double totalTripPrice;
  final double totalExpenses;
  final String Trip_Unchangable_Id;
  final double totalCommission;
  final DateTime paymentDate;
  final TripSource tripSource;
  final String sourceId;

  SingleTripFinanceModel(
      {required this.id,
      required this.totalTripPrice,
      required this.totalExpenses,
      required this.totalCommission,
      required this.Trip_Unchangable_Id,
      required this.paymentDate,
      required this.tripSource,
      required this.sourceId});

  SingleTripFinanceModel.fromJson(Map<String, dynamic> json)
      : id = json['Trip_Id'],
        totalTripPrice =
            double.parse((json['Total_Money'] as dynamic).toString()),
        totalExpenses = double.parse((json['Outlays'] as dynamic).toString()),
        totalCommission =
            double.parse((json['Comession'] as dynamic).toString()),
        paymentDate = DateTime.parse(json['Payment_Date']),
        tripSource = LightTripModel.getTripSourceFromString(json['User_Type']),
        sourceId = json['sourceId'].toString(),
        Trip_Unchangable_Id = json['Trip_Unchangable_Id'] ==null ? "":json['Trip_Unchangable_Id'].toString();
}
