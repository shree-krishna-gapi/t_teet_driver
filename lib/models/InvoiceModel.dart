class RideInvoice {
  String customer_id;
  String trip_id;
  String time;
  String base_fare;
  String distance;
  String payment_type;
  String waiting_amount;

  RideInvoice(this.customer_id, this.trip_id, this.time, this.base_fare,
      this.distance, this.payment_type, this.waiting_amount);

  RideInvoice.fromJson(Map<String, dynamic> json)
      : customer_id = json['id'],
        trip_id = json['trip_id'],
        time = json['time'],
        base_fare = json['base_fare'],
        distance = json['distance'],
        waiting_amount = json['waiting_amount'],
        payment_type = json['payment_type'];


}