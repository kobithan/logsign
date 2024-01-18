import 'package:flutter/material.dart';
import 'package:flutter_firebase/Model/createApiModal.dart';
import 'package:flutter_firebase/Model/restarantModal.dart';
import 'package:flutter_firebase/Model/userModal.dart';
import 'package:flutter_firebase/Screens/homeScreen/landing_Screen.dart';
import 'package:flutter_firebase/Services/firebase_auth_services.dart';

class PaymentScreen extends StatefulWidget {
  final Restaurant selectedRestaurant;
  final UserModal userDetails;
  const PaymentScreen(
      {required this.selectedRestaurant, required this.userDetails, super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuthService firestoreService = FirebaseAuthService();

  void makeReservation(
      String restaurantId, Map<String, dynamic> reservationData) {
    firestoreService.addReservation(restaurantId, reservationData);
    print('firebasecreate_call ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
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
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                        labelText: 'Expiration Date',
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid expiration date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
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
                        labelText: 'CVV',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final CreateApiModal _creatmodal = CreateApiModal(
                        restaurantId: widget.selectedRestaurant.restaurantId,
                        restarantname: widget.selectedRestaurant.name,
                        location: widget.selectedRestaurant.location,
                        price: widget.selectedRestaurant.price,
                        image: widget.selectedRestaurant.image,
                        number: widget.selectedRestaurant.number,
                        initialRating: widget.selectedRestaurant.initialRating,
                        name: widget.userDetails.name,
                        date: widget.userDetails.date,
                        time: widget.userDetails.time,
                        number_of_participants:
                            widget.userDetails.number_of_participants,
                        duration: widget.userDetails.duration);

                    Map<String, dynamic> userMap = _creatmodal.toMap();

                    makeReservation(
                        widget.selectedRestaurant.restaurantId.toString(),
                        userMap);
                    print('Payment Successful!');
                    _showAlertDialog(context);
                    AlertDialog();
                  }
                },
                child: Text('Pay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  // Creating the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Success'),
    content: Text('Payment Successful! and Reserved'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LandingScreen()),
              (route) => false);
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
