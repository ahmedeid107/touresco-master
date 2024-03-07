// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: curly_braces_in_flow_control_structures

enum TripStatusData {
  none,
  waitingDriverToTakeTrip,
  driverTakeTripButNotFinsihIt,
  driverFinishTripButNotGetPaid,
  driverFinishTripAndGetPaid,
  ownerWantToCancelTrip,
  tirpOwner,
}

TripStatusData getTripStatusType(String status, String path) {
  print("AAAAAAAA SS ${path}");
  print("AAAAAAAA status SS ${status}");
  if (((status == '2' || status == '12' || status == '22' ) &&
      path != '3'))
    return TripStatusData.waitingDriverToTakeTrip;
  else if ((status == '3' ||
          status == '13' ||
          status == '23' )  )
    return TripStatusData.driverTakeTripButNotFinsihIt;
  else if ((status == '4' ||
          status == '14' ||
          status == '24' ) &&
      path != '3')
    return TripStatusData.driverFinishTripButNotGetPaid;
  else if (status == '5' || status == '15' || status == '25'  )
    return TripStatusData.driverFinishTripAndGetPaid;
  else if ((status == '1' ||status == '2' ||
          status == '12' || status == '17' ||
          status == '22'  ) )
    return TripStatusData.ownerWantToCancelTrip;
  else if(status=="32")
    return TripStatusData.tirpOwner;
  else
    return TripStatusData.none;
}

enum ExpensesStatusData {
  //In Order no need to convert Function
  none,
  activeAndAcceptedTwoPartsButPaymentNotCompleted, //1
  paymentIsCompleted, //2
  waitingOfficeToAcceptExpenses, //3
  waitingDriverToAcceptExpensesThatComeFromOffice, //4
  canceldByDriver, //5
  canceldByOffice //6
}

enum MotionRequestStatus {
  none,
  userNotRequestMotionRequestYet,
  userWaitingMotionRequestAnswer,
  userMotionRequestApproved,
  userMotionRequestRefused,
  userNotRegisterInOffice,
  driverIsNotAccpetedYetByOffice,
  driverIsBlockedFromOffice
}

enum TransferStatus {
  none,
  canNotBeTransferred,
  canBeTransferred,
}

class TripDetailsModel {
  final String id;
  final String Trip_Unchangable_Id;
  final String userId;
  final String status;
  final String? tripCommission;
  final String tripCompanyName;
  final double tripPrice;
  final String tripResponseTime;
  final String? contactPhoneNumber;
  final String? signName;
  final String flightNumber;
  final String tripAddedDate;
  final String tripSeenStatus;
  final String tripPaymentDate;
  final String tripNotes;
  final TransferStatus transferStatus;
  final List<SingleTripProgramData> programs;
  final List<SingleExpensesData> expenses;
  final List<SinglePassengerData> passengers;
  final MotionRequestStatus motionRequestStatus;
  final String tripApprovalId;
  final String tripDateConflictStatus;
  final String tripChatMessagesNumber;
  final String? sourceId;
  final String tripArchivedDate;
  final bool isOwner;

  TripDetailsModel(
      {required this.id,
      required this.userId,
      required this.Trip_Unchangable_Id,
      required this.status,
      this.tripCommission,
      required this.tripCompanyName,
      required this.tripPrice,
      required this.tripResponseTime,
      this.contactPhoneNumber,
      this.signName,
        required this.isOwner,
      required this.flightNumber,
      required this.tripAddedDate,
      required this.tripSeenStatus,
      required this.tripPaymentDate,
      required this.tripNotes,
      required this.programs,
      required this.expenses,
      required this.passengers,
      required this.transferStatus,
      required this.motionRequestStatus,
      required this.tripApprovalId,
      required this.tripDateConflictStatus,
      required this.tripChatMessagesNumber,
      required this.sourceId,
      required this.tripArchivedDate});

  TripDetailsModel.fromJson(Map<String, dynamic> jsonData , )
      : id = jsonData['Trip_Uniq_Id'].toString(),
        userId = jsonData['Trip_Driver_Id'].toString(),
        Trip_Unchangable_Id = jsonData['Trip_Unchangable_Id']!= null ? jsonData['Trip_Unchangable_Id'].toString():"",
        status = jsonData['Trip_Status'].toString(),
        tripCommission = jsonData['Trip_Commission'].toString(),
        tripCompanyName = jsonData['Trip_Owner_name'].toString(),
        tripPrice = double.parse(jsonData['Trip_Price'].toString()),
        tripResponseTime = jsonData['Trip_Response_Time'].toString(),
        contactPhoneNumber = jsonData['Trip_Contact_Phone_Number'].toString(),
        signName = jsonData['Trip_Sign_Name_If_Exisit'].toString(),
        flightNumber = jsonData['Trip_Flight_Number'].toString(),
        tripAddedDate = jsonData['Trip_Date_Added'].toString(),
        tripSeenStatus = jsonData['Trip_Seen_Status'].toString(),

        tripPaymentDate = jsonData['Trip_Payment_DueDate'],
        tripNotes = jsonData['Trip_Notes'],
        transferStatus = getTransferStatus(jsonData['Trip_Transfarable']),
        programs = getProgramsFromMap(jsonData['Trip_Program_Array']),
        expenses = getExpensesFromList(jsonData['Trip_Outlay']['Outlats']),
        passengers =
            getPassengersFromListDynamic(jsonData['Trip_Passngers_Array']),
        motionRequestStatus = getMotionRequestStatus(jsonData['Trip_approvel']['Status'].toString()),
        tripDateConflictStatus = jsonData['tripDateConflictStatus'].toString() ,
        tripApprovalId = jsonData['Trip_approvel']['Apprroval_Id'].toString() ,
        tripChatMessagesNumber = jsonData["tripChatMessagesNumber"].toString() ,
        sourceId = "",
        isOwner= jsonData["Is_Owner"].toString()=="true",
  //jsonData['Payment_Date_if_Paid']??
        tripArchivedDate = jsonData['Payment_Date_if_Paid'].toString() ;

  static List<SingleTripProgramData> getProgramsFromMap(List<dynamic> items) {
    List<SingleTripProgramData> ret = [];
    for (var element in items) {
      ret.add(SingleTripProgramData.fromJson(element));
    }
    return ret;
  }

  static List<SingleExpensesData> getExpensesFromList(List<dynamic> expenses) {
    List<SingleExpensesData> ret = [];
    for (var element in expenses) {
      ret.add(SingleExpensesData.fromJson(element));
    }

    return ret;
  }

  static List<SinglePassengerData> getPassengersFromListDynamic(
      List<dynamic> passengers) {
    List<SinglePassengerData> ret = [];

    for (var element in passengers) {
      ret.add(SinglePassengerData.fromJson(element));
    }

    return ret;
  }

  static TransferStatus getTransferStatus(String status) {
    if (status == '0')
      return TransferStatus.canNotBeTransferred;
    else if (status == '1')
      return TransferStatus.canBeTransferred;
    else
      return TransferStatus.none;
  }

  static MotionRequestStatus getMotionRequestStatus(String status) {
    if (status == '0') {
      return MotionRequestStatus.userMotionRequestRefused;
    } else if (status == '1') {
      return MotionRequestStatus.userWaitingMotionRequestAnswer;
    } else if (status == '2') {
      return MotionRequestStatus.userMotionRequestApproved;
    } else if (status == '3') {
      return MotionRequestStatus.userNotRequestMotionRequestYet;
    } else if (status == '4') {
      return MotionRequestStatus.userNotRegisterInOffice;
    } else if (status == '5') {
      return MotionRequestStatus.driverIsNotAccpetedYetByOffice;
    } else if (status == '6') {
      return MotionRequestStatus.driverIsBlockedFromOffice;
    } else {
      return MotionRequestStatus.none;
    }
  }

  static ExpensesStatusData getExpensesStatus(String status, String path) {
    if (path == '1') {
      if (status == '1') {
        return ExpensesStatusData
            .activeAndAcceptedTwoPartsButPaymentNotCompleted;
      } else if (status == '2') {
        return ExpensesStatusData.paymentIsCompleted;
      } else if (status == '3') {
        return ExpensesStatusData.waitingOfficeToAcceptExpenses;
      } else if (status == '4') {
        return ExpensesStatusData
            .waitingDriverToAcceptExpensesThatComeFromOffice;
      } else if (status == '5') {
        return ExpensesStatusData.canceldByDriver;
      } else if (status == '6') {
        return ExpensesStatusData.canceldByOffice;
      } else {
        return ExpensesStatusData.none;
      }
    } else if (path == '2') {
      if (status == '1') {
        return ExpensesStatusData
            .activeAndAcceptedTwoPartsButPaymentNotCompleted;
      } else if (status == '2') {
        return ExpensesStatusData.paymentIsCompleted;
      } else if (status == '3') {
        return ExpensesStatusData.waitingOfficeToAcceptExpenses;
      } else if (status == '4') {
        return ExpensesStatusData
            .waitingDriverToAcceptExpensesThatComeFromOffice;
      } else if (status == '5') {
        return ExpensesStatusData.canceldByDriver;
      } else if (status == '6') {
        return ExpensesStatusData.canceldByOffice;
      } else {
        return ExpensesStatusData.none;
      }
    } else if (path == '3') {
      if (status == '1') {
        return ExpensesStatusData.none;
      } else if (status == '2') {
        return ExpensesStatusData.paymentIsCompleted;
      } else if (status == '3') {
        return ExpensesStatusData
            .waitingDriverToAcceptExpensesThatComeFromOffice;
      } else if (status == '4') {
        return ExpensesStatusData.waitingOfficeToAcceptExpenses;
      } else if (status == '5') {
        return ExpensesStatusData.canceldByDriver;
      } else if (status == '6') {
        return ExpensesStatusData.canceldByOffice;
      } else {
        return ExpensesStatusData.none;
      }
    } else {
      return ExpensesStatusData.none;
    }
  }
}

class SingleTripProgramData {
  final String id;
  String status;
  final String startPoint;
  final String endPoint;
  final String date;
  final String startTime;
  final double? latitude;
  final double? longitude;

  DateTime get programDateUserDisplay {
    DateTime ret = DateTime.parse(date);

    String hour = startTime.split(':')[0];
    String min = startTime.split(':')[1];

    return DateTime(
      ret.year,
      ret.month,
      ret.day,
      int.parse(hour),
      int.parse(min),
    );
  }

  SingleTripProgramData(
      {required this.id,
      required this.status,
      required this.startPoint,
      required this.endPoint,
      required this.date,
      required this.startTime,
      this.latitude,
      this.longitude});

  SingleTripProgramData.fromJson(Map<String, dynamic> json)
      : id = json['Program_Id'],
        status = json['Status'],
        startPoint = json['Start_Point'],
        endPoint = json['End_Point'],
        date = json['Date'],
        latitude = double.parse(json["program_latitude"].toString()),
        longitude = double.parse(json["program_longitude"].toString()),
        startTime = json['Start_Point_Time'];
}

class SingleExpensesData {
  final String id;
  final String note;
  final double amount;
  final String expensesStatus;
  final String addedDate;
  final String paymentDateDone;
  final String paymentDate;
  final String paymentType;

  SingleExpensesData({
    required this.id,
    required this.note,
    required this.amount,
    required this.expensesStatus,
    required this.addedDate,
    required this.paymentDateDone,
    required this.paymentDate,
    required this.paymentType,
  });

  SingleExpensesData.fromJson(Map<String, dynamic> json)
      : id = json['Outlay_Id'],
        note = json['Outlay_Note'],
        amount = double.parse(json['Outlay_Amount']),
        expensesStatus = json['Outlay_Status'],
        addedDate = json['Outlay_DateAdded'],
        paymentDateDone = json['Outlay_Date_Patment_Done'] ?? '0000-00-00',
        paymentDate = json['Outlay_Payment_Time'],
        paymentType = json['Outlay_Payment_Type'];
}

class SinglePassengerData {
  final String id;
  final String passengerName;
  final String passengerPassport;
  final String passengerNationalityId;
  final String passengerStatus;
  final String passengerNationalityEn;
  final String passengerNationalityAr;
  final String? passengerPhone;

  SinglePassengerData({
    required this.id,
    required this.passengerName,
    required this.passengerPassport,
    required this.passengerNationalityId,
    required this.passengerStatus,
    required this.passengerNationalityEn,
    required this.passengerNationalityAr,
    required this.passengerPhone,
  });

  SinglePassengerData.fromJson(Map<String, dynamic> json)
      : id = json['Passnger_Id'],
        passengerName = json['Passnger_Name'],
        passengerPhone = json['Passnger_Phone'],
        passengerPassport = json['Passnger_Passport'],
        passengerNationalityId = json['Passnger_Nationality'],
        passengerStatus = json['Passnger_Status'],
        passengerNationalityEn =
            json['Passnger_Data_Array']['English_Nationality'],
        passengerNationalityAr =
            json['Passnger_Data_Array']['Arabic_Nationality'];
}
