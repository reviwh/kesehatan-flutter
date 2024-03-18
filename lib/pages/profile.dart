import 'package:flutter/material.dart';
import 'package:kesehatan/pages/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'images/logo.jpg'), // Ganti dengan path gambar profil Anda
            ),
            SizedBox(height: 20),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'johndoe@gmail.com',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan fungsi untuk mengedit profil
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
              child: Text('Edit Profil'),
            ),
          ],
        ),
      ),
    );
  }
}
