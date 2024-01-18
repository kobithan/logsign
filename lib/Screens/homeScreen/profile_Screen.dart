import 'package:flutter/material.dart';
import 'package:flutter_firebase/Screens/authScreen/login_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Fake Profile'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png'), // Add your avatar image
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mark'),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: 'Mark@gmail.com'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(labelText: '011-243587542'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
