
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_teet_rider/firebase/Rider.dart';
import 'package:t_teet_rider/models/RiderProfile.dart';
import 'package:t_teet_rider/utils/Constants.dart';

class StorageManager{
  SharedPreferences _preferences ;

  static const String LicensePhoto = "licensePhoto";
  static const String BlueBookFrontPhoto = "blueBookFrontPhoto";
  static const String BlueBookBackPhoto = "blueBookBackPhoto";

  static const String PublicOrPrivate = "publicOrPrivate";
  static const String LicenseNumber = "licenseNumber";
  static const String LicenseExpiryDate = "licenseExpiryDate";
  static const String BluebookExpiryDate = "bluebookExpiryDate";


  static const String VehicleName = "vehicleName";
  static const String VehicleNumber = "vehicleNumber";
  static const String VehicleModel = "vehicleModel";
  static const String VehicleColor = "vehicleColor";
  static const String VehicleYear = "vehicleYear";
  static const String VehicleDoor = "vehicleDoor";
  static const String VehicleSeat = "vehicleSeat";

  static const String CITY = "city";
  static const String NAME = "name";
  static const String PHONE = "phone";
  static const String EMAIL = "email";
  static const String GENDER = "gender";
  static const String PROFILEIMAGE = "profileImage";
  static const String FCMTOKEN = "fcmtoken";

  static const String ISLOGIN = "isLoggedIn";

  setLogin(bool login) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(ISLOGIN, login);
  }

  setFCMToken(String token) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(FCMTOKEN, token);
  }
  setPhoneNumber(String phone) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(PHONE, phone);
  }
  setGender(String gender) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(GENDER, gender);
  }
  setEmail(String email) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, email);
  }

  setCity(String city) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(CITY, city);
  }

  setLicensePhoto(String licensePhoto) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(LicensePhoto, licensePhoto);
  }
  setBlueBookFrontPhoto(String blueBookFrontPhoto) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(BlueBookFrontPhoto, blueBookFrontPhoto);
  }
  setBlueBookBackPhoto(String blueBookBackPhoto) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(BlueBookBackPhoto, blueBookBackPhoto);
  }

  setVehicleType(bool privateOrPublic) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(PublicOrPrivate, privateOrPublic);
  }
  setLicenseNumber(String licenseNumber) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(LicenseNumber, licenseNumber);
  }
  setLicenseExpiryDate(String licenseExpiryDate) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(LicenseExpiryDate, licenseExpiryDate);
  }
  setBluebookExpiryDate(String bluebookExpiryDate) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(BluebookExpiryDate, bluebookExpiryDate);
  }

  setVehicleName(String vehicleName) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleName, vehicleName);
  }
  setVehicleNumber(String vehicleNumber) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleNumber, vehicleNumber);
  }
  setVehicleModel(String vehicleModel) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleModel, vehicleModel);
  }
  setVehicleColor(String vehicleColor) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleColor, vehicleColor);
  }
  setVehicleYear(String vehicleYear) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleYear, vehicleYear);
  }
  setVehicleDoor(String vehicleDoor) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleDoor, vehicleDoor);
  }
  setVehicleSeat(String vehicleSeat) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(VehicleSeat, vehicleSeat);
  }


  setUserName(String name) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(NAME, name);
  }

  setProfileImage(String profile) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(PROFILEIMAGE, profile);
  }

  Future<String> getUserName() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(NAME) ?? "";
  }

  Future<String> getFcmToken() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(FCMTOKEN) ?? "";
  }
  Future<String> getProfileImage() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(PROFILEIMAGE) ?? Constants.PLACEHOLDER;
  }

  Future<String> city() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(CITY) ?? "";
  }
  Future<String> licensePhoto() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(LicensePhoto) ?? "";
  }
  Future<String> blueBookFrontPhoto() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(BlueBookFrontPhoto) ?? "";
  }
  Future<String> blueBookBackPhoto() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(BlueBookBackPhoto) ?? "";
  }
  Future<String> publicOrPrivat() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PublicOrPrivate) ?? "";
  }
  Future<String> licenseNumber() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(LicenseNumber) ?? "";
  }
  Future<String> licenseExpiryDate() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(LicenseExpiryDate) ?? "";
  }
  Future<String> vehicleName() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleName) ?? "";
  }
  Future<String> vehicleNumber() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleNumber) ?? "";
  }
  Future<String> vehicleModel() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleModel) ?? "";
  }
  Future<String> vehicleYear() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleYear) ?? "";
  }
  Future<String> vehicleDoor() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleDoor) ?? "";
  }
  Future<String> vehicleSeat() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(VehicleSeat) ?? "";
  }

  Future<bool> getIsLogin() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(ISLOGIN) ?? false;
  }
  Future<RiderProfile> getUser() async{
    var prefs = await SharedPreferences.getInstance();
    var name =  prefs.getString(NAME) ?? "";
    var phone =  prefs.getString(PHONE) ?? "";
    var gender =  prefs.getString(GENDER) ?? "";
    var email =  prefs.getString(EMAIL) ?? "";
    var profile =  prefs.getString(PROFILEIMAGE) ?? "";

    var city =  prefs.getString(CITY) ?? "";
    var licensePhoto =  prefs.getString(LicensePhoto) ?? "";
    var blueBookFrontPhoto =  prefs.getString(BlueBookFrontPhoto) ?? "";
    var blueBookBackPhoto =  prefs.getString(BlueBookBackPhoto) ?? "";
    var publicOrPrivate =  prefs.getBool(PublicOrPrivate) ?? false;
    var licenseNumbers =  prefs.getString(LicenseNumber) ?? "";
    var licenseExpiryDate =  prefs.getString(LicenseExpiryDate) ?? "";
    var vehicleName =  prefs.getString(VehicleName) ?? "";
    var vehicleNumber =  prefs.getString(VehicleNumber) ?? "";
    var vehicleModel =  prefs.getString(VehicleModel) ?? "";
    var vehicleYear =  prefs.getString(VehicleYear) ?? "";
    var vehicleDoor =  prefs.getString(VehicleDoor) ?? "";
    var vehicleSeat =  prefs.getString(VehicleSeat) ?? "";



    var user = RiderProfile(phone,phone,name,gender,email,profile,city,licensePhoto,blueBookFrontPhoto,blueBookBackPhoto,
        publicOrPrivate,licenseNumbers,licenseExpiryDate,vehicleName,vehicleNumber,vehicleModel,vehicleYear,vehicleDoor,vehicleSeat);
    return user;
  }

  Future<String> getPhone() async{
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(PHONE) ?? "";
  }


}