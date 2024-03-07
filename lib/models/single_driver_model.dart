class SingleDriverModel {
  final String id;
  final String name;
  final String phoneNumber;

  SingleDriverModel(
      {required this.id, required this.name, required this.phoneNumber});

  SingleDriverModel.fromJson(Map<String, dynamic> json)
      : id = json['Driver_Id'],
        name = json['Driver_Name'],
        phoneNumber = json['Phone_Number'];
}
