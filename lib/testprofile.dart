import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'signin.dart'; // Update with the correct path to your SignInPage
import 'forgotpass.dart';
class testprofile extends StatefulWidget {
  testprofile({Key? key}) : super(key: key);

  @override
  _testprofileState createState() => _testprofileState();
}

class _testprofileState extends State<testprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _profileImageUrl;
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final storageRef = _storage
            .ref()
            .child('user_profile_images')
            .child(user.uid + '.jpg');
        String downloadURL = await storageRef.getDownloadURL();
        setState(() {
          _profileImageUrl = downloadURL;
        });
      } catch (e) {
        print('Error loading profile image: $e');
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // final storageref = FirebaseStorage.instance.ref();
    // final imageref = storageref.child("unser_1.jpg");
    // final imagebytes = await image.readAsBytes();
    // await imageref.putData(imagebytes);
    try {
      final Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        pickedImage = imageBytes;
      });
      // await _uploadImage(imageBytes);
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(), // Update with your SignInPage path
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile'),
        // backgroundColor: const Color.fromARGB(255, 243, 242, 242),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: pickedImage != null
                        ? Image.memory(
                            pickedImage!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          )
                        : _profileImageUrl != null
                            ? Image.network(
                                _profileImageUrl!,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              )
                            : Icon(Icons.person, size: 50),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Your Profile'),
              onTap: () {
                // Navigate to Profile Details Page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              onTap: () {
                // Navigate to Language Settings Page
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help Center'),
              onTap: () {
                // Navigate to Help Center Page
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Invite Friends'),
              onTap: () {
                // Implement Invite Friends functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Navigate to Privacy Policy Page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}