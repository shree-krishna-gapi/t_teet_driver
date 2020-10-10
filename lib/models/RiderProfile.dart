
class RiderProfile{
   String id;
   String phone;
   String name;
   String gender;
   String email;
   String profile;
   String city;
   String licensePhoto;
   String blueBookFrontPhoto;
   String blueBookBackPhoto;
   bool publicOrPrivate;
   String licenseNumber;
   String licenseExpiryDate;
   String vehicleName;
   String vehicleNumber;
   String vehicleModel;
   String vehicleYear;
   String vehicleDoor;
   String vehicleSeat;

  RiderProfile(this.id, this.phone, this.name, this.gender, this.email, this.profile, this.city,
      this.licensePhoto,this.blueBookFrontPhoto,this.blueBookBackPhoto,this.publicOrPrivate,this.licenseNumber,
      this.licenseExpiryDate,this.vehicleName,this.vehicleNumber,this.vehicleModel,this.vehicleYear,this.vehicleDoor,this.vehicleSeat);

  RiderProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phone = json['phone'],
        name = json['name'],
        gender = json['gender'],
        email = json['email'],
        profile = json['profile'],

      city = json['city'],
      licensePhoto = json['licensePhoto'],
      blueBookFrontPhoto = json['blueBookFrontPhoto'],
      blueBookBackPhoto = json['blueBookBackPhoto'],
      publicOrPrivate = json['publicOrPrivate'],
      licenseNumber = json['licenseNumber'],
      licenseExpiryDate = json['licenseExpiryDate'],
      vehicleName = json['vehicleName'],
      vehicleNumber = json['vehicleNumber'],
      vehicleModel = json['vehicleModel'],
      vehicleYear = json['vehicleYear'],
      vehicleDoor = json['vehicleDoor'],
   vehicleSeat = json['vehicleSeat'];

}