import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Widgets/toast.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<void> addReservation(
      String restaurantId, Map<String, dynamic> reservationData) async {
    await _firestore
        .collection('reservations')
        .doc(restaurantId)
        .set(reservationData);
  }

  Future<List<Map<String, dynamic>>> getAllBookedRestaurants() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('reservations').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> deleteReservation(String restaurantId) async {
    await _firestore.collection('reservations').doc(restaurantId).delete();
  }

  Future<void> updateReservation(
      String reservationId, Map<String, dynamic> updatedData) async {
    await _firestore
        .collection('reservations')
        .doc(reservationId)
        .update(updatedData);
  }
}
