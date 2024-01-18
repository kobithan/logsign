import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/restarantModal.dart';
import 'package:flutter_firebase/Model/restaurantData.dart';
import 'package:flutter_firebase/Screens/homeScreen/bookingScreen.dart';
import 'package:flutter_firebase/Services/firebase_auth_services.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final FirebaseAuthService firestoreService = FirebaseAuthService();
  List<Map<String, dynamic>> bookedRestaurants = [];

  @override
  void initState() {
    super.initState();
    fetchBookedRestaurants();
  }

  void fetchBookedRestaurants() async {
    List<Map<String, dynamic>> restaurants =
        await firestoreService.getAllBookedRestaurants();
    setState(() {
      bookedRestaurants = restaurants;
      print('bookedRestaruentsDetails $bookedRestaurants');
    });
  }

  void _showAlertDialog(BuildContext context, var check, int index) {
    // Creating the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to cancel the reservation!'),
      actions: [
        TextButton(
          onPressed: () {
            firestoreService.deleteReservation(check);
            setState(() {
              bookedRestaurants.removeAt(index);
            });
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );

    // Showing the AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookedRestaurants.length == 0 || bookedRestaurants == null
          ? Center(child: Text('There are no reservation yet'))
          : ListView.builder(
              itemCount: bookedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = bookedRestaurants[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 250,
                        // width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(restaurant['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text('Restaurant: ${restaurant['restarantname']}'),
                      Text('Location:   ${restaurant['location']}'),
                      Text('time:       ${restaurant['time']}'),
                      Text('date:       ${restaurant['date']}'),
                      Text('Persons:  ${restaurant['number_of_participants']}'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Paid:       ${restaurant['price']}'),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  final Restaurant _restaraunt = Restaurant(
                                      restaurantId: restaurant['restaurantId'],
                                      name: restaurant['name'],
                                      location: restaurant['location'],
                                      price: restaurant['price'],
                                      image: restaurant['image'],
                                      number: restaurant['number'],
                                      initialRating:
                                          restaurant['initialRating']);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookingScreen(
                                            selectedRestaurant:
                                                restaurant[index])),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.lightBlue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showAlertDialog(context,
                                      restaurant['restaurantId'], index);
                                },
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.black, // Choose your desired color
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0), // Adjust margin as needed
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
