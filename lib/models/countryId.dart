

class Country{


  String country_ID;
  String english_Name;
  String arabic_Name;
  String English_Nationality;
  String Arabic_Nationality;

  Country({
    required this.country_ID,
    required this.english_Name,
    required this. English_Nationality,
    required this. arabic_Name,
    required this.Arabic_Nationality,

  });

  static Country fromJson(Map<String , dynamic > map){
    return  Country(
      country_ID:map["country_ID"].toString(),
      english_Name: map["English_Name"].toString() ,
      arabic_Name: map["Arabic_Name"].toString() ,
      English_Nationality:map["English_Nationality"],
      Arabic_Nationality:map["Arabic_Nationality"],

    );
  }






}