enum UserType {
  none,
  drivder,
  guide,
}

class UserModel {
  final String id; // not existing in post
  final String fullName;
  final String email;
  final String phone;
  String? imgUrl;
  String? password = '';
  final String carTypeId;
  final String carSizeId;
  final String? phone2;
  final String carLicenseNumber; // not existing in post
  final String? officeId;
  final String carNumber; // not existing in post
  final String carLisenseId;
  final DateTime liscenseDate;

  final UserType userType;
  final String status;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.carTypeId,
    required this.carSizeId,
    required this.phone2,
    required this.imgUrl,
    required this.carLicenseNumber,
    required this.officeId,
    required this.carNumber,
    required this.carLisenseId, //driverId
    required this.liscenseDate,
    required this.userType,
    required this.status,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['User_Id'], //
        fullName = json['User_Name'],
        email = json['User_Email'],
        imgUrl = json['Profile_Photo'],
        phone = json['User_Phone_Primary'],
        phone2 = json['User_Phone_Secondary'],
        password = json['password'],
        carTypeId = json['User_Car_Type'],
        carSizeId = json['User_Seats_Number'],
        carLicenseNumber = json['User_Car_License_Number'],
        liscenseDate = DateTime.parse(json['User_License_Due_Date']),
        officeId = null,
        carNumber = json['car_number'],
        carLisenseId = json['User_License_Number'],
        userType = UserModel.getUserTypeFromId(
          json['User_Type'],
        ),
        status = json['User_Status'];

  Map<String, dynamic> toJson() => {
        'User_Id': id,
        'User_Name': fullName,
        'User_Email': email,
        'User_Phone_Primary': phone,
        'User_Phone_Secondary': phone2,
        'password': password,
        'User_Car_Type': carTypeId,
        'User_Seats_Number': carSizeId,
        'User_License_Due_Date': liscenseDate.toString(),
        'User_Car_License_Number': carLicenseNumber, //carLisenseId
        'User_Type': userType.index.toString(),
        'User_Status': status,
        'User_License_Number': carLisenseId,
        'car_number': '',
      };

  static UserType getUserTypeFromId(String id) {
    if (id == '1') {
      return UserType.drivder;
    } else {
      return UserType.none;
    }
  }
}
