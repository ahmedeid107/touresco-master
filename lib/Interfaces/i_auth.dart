import 'dart:io';

import 'package:touresco/models/car_size_model.dart';
import 'package:touresco/models/user_model.dart';

abstract class IAuth {
  Future<UserModel> signIn(String email, String password, String deviceToken);

  Future<void> signUp(UserModel user, bool withActivateOwnerDashboard);

  Future<void> signOut();

  Future<bool> retrieveAccountPassword(String email);

  Future<bool> changePassword(
    String userId,
    String oldPassword,
    String newPassword,
  );

  Future<Map> syncUserData(String userId);

  Future<bool> updateUserData(
    String userId,
    Map data,
    bool isOfficeChanged,
    bool isOwnerStatusChanged,
  );
  Future<List<CarSizeModel>> getAllSize(String id);
  //***///
  Future<Map> updateProfileImage(File image,String userId);

  Future<bool> checkIfDriverCanUserEmailAsOwner(String email);

  Future<Map> deleteAccount({required String token, required String password});
}
