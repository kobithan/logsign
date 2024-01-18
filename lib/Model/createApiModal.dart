class CreateApiModal {
  // final int CreateApiModalId;
  final String restarantname;
  final String location;
  final String price;
  final String image;
  final String number;
  final double initialRating;
  final int restaurantId;

  final String name;
  final String date;
  final String time;
  final String number_of_participants;
  final String duration;

  CreateApiModal({
    // required this.CreateApiModalId,
    required this.restaurantId,
    required this.restarantname,
    required this.location,
    required this.price,
    required this.image,
    required this.number,
    required this.initialRating,
    required this.name,
    required this.date,
    required this.time,
    required this.number_of_participants,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'restarantname': restarantname,
      'location': location,
      'price': price,
      'image': image,
      'number': number,
      'initialRating': initialRating,
      'name': name,
      'date': date,
      'time': time,
      'number_of_participants': number_of_participants,
      'duration': duration,
    };
  }
}
