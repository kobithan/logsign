import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/createApiModal.dart';
import 'package:flutter_firebase/Model/restarantModal.dart';
import 'package:flutter_firebase/Model/restaurantData.dart';
import 'package:flutter_firebase/Model/userModal.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController participantsController = TextEditingController();
  TextEditingController durationController = TextEditingController();

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

  void updateReservation(var reservationId, Map<String, dynamic> updatedData) {
    firestoreService.updateReservation(reservationId, updatedData);
    fetchBookedRestaurants();
    setState(() {
      nameController.text == '';
    });
  }

  void _showAlertDialog(BuildContext context, int check, int index) {
    // Creating the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to cancel the reservation!'),
      actions: [
        TextButton(
          onPressed: () {
            firestoreService.deleteReservation(check.toString());
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

  void _showBottomSheet(
      BuildContext context, int index, Restaurant forshowres) {
    showModalBottomSheet(
        isScrollControlled: true,
        constraints: BoxConstraints.loose(Size.fromHeight(750)),
        context: context,
        builder: (context) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text('Booking Details',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Date'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid Date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: timeController,
                        decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Time'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: participantsController,
                        decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Number of Participants'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Number of Participants';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: durationController,
                        decoration: InputDecoration(
                            // hintText: 'Enter text',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Duration'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Duration';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 68),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                final UserModal userDetails = UserModal(
                                  name: nameController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  number_of_participants:
                                      participantsController.text,
                                  duration: durationController.text,
                                );
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => PaymentScreen(
                                //             selectedRestaurant:
                                //                 ,
                                //             userDetails: userDetails,
                                //           )),
                                // );
                                final CreateApiModal _creatmodal =
                                    CreateApiModal(
                                  restaurantId: forshowres.restaurantId,
                                  restarantname: forshowres.name,
                                  location: forshowres.location,
                                  price: forshowres.price,
                                  image: forshowres.image,
                                  number: forshowres.number,
                                  initialRating: forshowres.initialRating,
                                  name: nameController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  number_of_participants:
                                      participantsController.text,
                                  duration: durationController.text,
                                );

                                updateReservation(
                                    _creatmodal.restaurantId.toString(),
                                    _creatmodal.toMap());
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Update',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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
                                      name: restaurant['restarantname'],
                                      location: restaurant['location'],
                                      price: restaurant['price'],
                                      image: restaurant['image'],
                                      number: restaurant['number'],
                                      initialRating:
                                          restaurant['initialRating']);

                                  setState(() {
                                    nameController.text = restaurant['name'];
                                    dateController.text = restaurant['date'];
                                    timeController.text = restaurant['time'];
                                    participantsController.text =
                                        restaurant['number_of_participants'];
                                    durationController.text =
                                        restaurant['duration'];
                                  });

                                  _showBottomSheet(context, index, _restaraunt);
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
