import 'package:touresco/models/single_finance_model.dart';
import 'package:touresco/models/single_finance_trip_model.dart';

abstract class IExpenses {
  Future<bool> addExpenses(String tripId, String driverId, double prcie,
      String note, String paymentType, String path);

  Future<bool> paymentDoneForExpenses(
      String userId, String expensesId, String path);
  Future<bool> cancelPendingExpenses(
      String userId, String expensesId,   bool isOwner);
  Future<bool> cancelNewExpensesByDriver(
      String userId, String expensesId, bool isOwner);
  Future<bool> agreeNewExpensesByDriver(
      String userId, String expensesId, String path);
  Future<Map<String, List<SingleFinanceModel>>> getAllUserFinances(
      String userId);
  Future<List<SingleTripFinanceModel>>
      getTripsRelatedWithCreatorByExpensesStatus(
          String userId, String officeId, String path,String ownerType , String fillter
      );
  Future<List<SingleTripFinanceModel>>
      filterTripsRelatedWithCreatorByPaymentDate(String userId, String officeId,
          String fromDate, String toDate, String owner, String type);
}
