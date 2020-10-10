class UserProfile{
  String id;
  String phone;
  String name;
  String gender;
  String email;
  String profile;

  UserProfile({name, phone});



  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phone = json['phone'],
        name = json['name'],
        gender = json['gender'],
        email = json['email'],
        profile = json['profile'];
}




