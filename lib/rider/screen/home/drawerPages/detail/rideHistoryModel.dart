class RideHistoryModel{
  String date;
  String time;
  double distance;
  String transactionId;
  String time_taken;
  double amount;

//  RideHistoryModel(this.date,this.time,this.distance, this.time_taken,this.amount);
  RideHistoryModel();

  RideHistoryModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        time = json['time'],
        distance = json['distance'],
        transactionId = json['transactionId'],
        time_taken = json['time_taken'],
        amount = json['amount'];
}