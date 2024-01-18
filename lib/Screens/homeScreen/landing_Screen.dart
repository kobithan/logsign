import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screens/homeScreen/dashboard_Screen.dart';
import 'package:flutter_firebase/Screens/homeScreen/home_Screen.dart';
import 'package:flutter_firebase/Screens/homeScreen/profile_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Widgets/toast.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), DashBoard(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_currentIndex == 0
            ? ""
            : _currentIndex == 1
                ? 'Reserved restaurants '
                : 'Profile'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Stream<List<UserModel>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((qureySnapshot) => qureySnapshot.docs
        .map(
          (e) => UserModel.fromSnapshot(e),
        )
        .toList());
  }

  void _createData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String id = userCollection.doc().id;

    final newUser = UserModel(
      username: userModel.username,
      age: userModel.age,
      adress: userModel.adress,
      id: id,
    ).toJson();

    userCollection.doc(id).set(newUser);
  }

  void _updateData(UserModel userModel) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final newData = UserModel(
      username: userModel.username,
      id: userModel.id,
      adress: userModel.adress,
      age: userModel.age,
    ).toJson();

    userCollection.doc(userModel.id).update(newData);
  }

  void _deleteData(String id) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(id).delete();
  }
}

class UserModel {
  final String? username;
  final String? adress;
  final int? age;
  final String? id;

  UserModel({this.id, this.username, this.adress, this.age});

  static UserModel fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      username: snapshot['username'],
      adress: snapshot['adress'],
      age: snapshot['age'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "age": age,
      "id": id,
      "adress": adress,
    };
  }
}
