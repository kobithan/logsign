class UserModal {
  // final int UserModalId;
  final String name;
  final String date;
  final String time;
  final String number_of_participants;
  final String duration;

  UserModal({
    // required this.UserModalId,
    required this.name,
    required this.date,
    required this.time,
    required this.number_of_participants,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'number_of_participants': number_of_participants,
      'duration': duration
    };
  }
}
