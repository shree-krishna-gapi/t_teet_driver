class RideRequest {
  String id;
  String userid;
  String name;
  int capacity;
  String fromcity;
  double fromlat;
  double fromlng;
  String tocity;
  double tolat;
  double tolng;
  double distance;
  String userToken;
  String riderToken;
  String vehicleType;
  int basefare;
  int fare;
  String paymentType;


  RideRequest();

  RideRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userid = json['userid'],
        capacity = json['capacity'],
        name = json['name'],
        fromcity = json['fromcity'],
        fromlat = json['fromlat'],
        fromlng = json['fromlng'],
        tocity = json['tocity'],
        tolat = json['tolat'],
        tolng = json['tolng'],
        distance = json['distance'],
        userToken = json['userToken'],
        riderToken = json['riderToken'],
        vehicleType = json['vehicleType'],
        basefare = json['basefare'],
        fare = json['fare'],
        paymentType = json['paymentType'];
}
