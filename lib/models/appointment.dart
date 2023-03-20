class Appointment {
  final String serviceName;
  final String userName;
  final String date;
  final String time;
  final String status;
  final String cost;
  Appointment({
    required this.serviceName,
    required this.userName,
    required this.date,
    required this.time,
    required this.status,
    required this.cost,
  });
}
class ChooseCategory{
  final String category;

  ChooseCategory({
    required this.category
});
}
