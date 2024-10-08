import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'signin.dart'; // Update with the correct path to your SignInPage
import 'forgotpass.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String username = 'User';
  String? _profileImageUrl;
  Uint8List? pickedImage;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _signInWithGoogle();
  }

  Future<void> _signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        UserCredential credential = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );

        setState(() {
          _currentUser = credential.user;
          _profileImageUrl = _currentUser?.photoURL;
        });
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     try {
  //       final Uint8List imageBytes = await image.readAsBytes();
  //       setState(() {
  //         pickedImage = imageBytes;
  //       });
  //       await _uploadImage(imageBytes);
  //     } catch (e) {
  //       print('Error picking image: $e');
  //     }
  //   }
  // }

  // Future<void> _uploadImage(Uint8List imageBytes) async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     try {
  //       final storageRef = _storage
  //           .ref()
  //           .child('user_profile_images')
  //           .child(user.uid + '.jpg');
  //       await storageRef.putData(imageBytes);
  //       String downloadURL = await storageRef.getDownloadURL();
  //       setState(() {
  //         _profileImageUrl = user.photoURL ?? 'https://www.gravatar.com/avatar/?d=identicon';
  //       });
  //     } catch (e) {
  //       print('Error uploading profile image: $e');
  //     }
  //   }
  // }

  Future<void> _signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(), // Update with your SignInPage path
      ),
    );
  }
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      try {
        final Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          pickedImage = imageBytes;
        });
        await _uploadImage(imageBytes);
      } catch (e) {
        print('Error picking image: $e');
      }
    }
  }

  Future<void> _uploadImage(Uint8List imageBytes) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        final storageRef = _storage
            .ref()
            .child('user_profile_images')
            .child(user.uid + '.jpg');
        await storageRef.putData(imageBytes);
        String downloadURL = await storageRef.getDownloadURL();

        // Update the user's profile photo URL in FirebaseAuth and Firestore
        await user.updatePhotoURL(downloadURL);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'photoURL': downloadURL});

        setState(() {
          _profileImageUrl = downloadURL;
        });
      } catch (e) {
        print('Error uploading profile image: $e');
      }
    }
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        if (userDoc.exists && userDoc['name'] != null) {
          username = userDoc['name'];
        } else {
          username = user.displayName ?? 'User';
        }

        // Use the Gmail account image if no image has been uploaded
        if (user.photoURL != null && user.photoURL!.isNotEmpty) {
          _profileImageUrl = user.photoURL!;
        } else {
          _profileImageUrl = 'https://www.gravatar.com/avatar/?d=identicon';
        }
      });
    }
  }

  Future<void> _inviteFriends() async {
    final url = "https://flip.com/invite";
    Share.share('Join me on this amazing app: $url');
  }

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('English'),
                  onTap: () {
                    // Set the app language to English
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Spanish'),
                  onTap: () {
                    // Set the app language to Spanish
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('French'),
                  onTap: () {
                    // Set the app language to French
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('German'),
                  onTap: () {
                    // Set the app language to German
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Kannada'),
                  onTap: () {
                    // Set the app language to Kannada
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Hindi'),
                  onTap: () {
                    // Set the app language to Hindi
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Russian'),
                  onTap: () {
                    // Set the app language to Russian
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Tamil'),
                  onTap: () {
                    // Set the app language to Tamil
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Telugu'),
                  onTap: () {
                    // Set the app language to Telugu
                    Navigator.of(context).pop();
                  },
                ),
                // Add more languages as needed
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'This is the privacy policy for our e-book app. We respect your privacy and are committed to protecting your personal data. Our policy includes the following points:',
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Text(
                  '• We do not share your personal data with third parties without your consent.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• We use encryption to protect your data.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• We may use cookies to enhance your experience on our app.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• You have the right to access, correct, or delete your personal information.',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '• If you have any questions about our privacy practices, please contact us.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _openHelpCenter() async {
    final url = 'https://tawk.to/chat/66ccb9dd50c10f7a00a0a0a7/1i67rc2sb';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile', style: TextStyle(color: Colors.black)),
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
                  backgroundColor: Colors.grey[200],
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
                            : Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -10, // Moved 20 pixels more to the right
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black),
              title: Text('Your Profile'),
              onTap: () {
                // Navigate to Profile Details Page
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text('Settings'),
              onTap: () {
                // Navigate to Settings Page
              },
            ),
            ListTile(
              leading: Icon(Icons.language, color: Colors.black),
              title: Text('Language'),
              onTap: _showLanguageSelectionDialog,
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.black),
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
              leading: Icon(Icons.help, color: Colors.black),
              title: Text('Help Center'),
              onTap: _openHelpCenter,
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.black),
              title: Text('Invite Friends'),
              onTap: _inviteFriends,
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.black),
              title: Text('Privacy Policy'),
              onTap: _showPrivacyPolicy,
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  color: const Color.fromARGB(255, 26, 25, 25)),
              title: Text('Logout'),
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'signin.dart'; // Update with the correct path to your SignInPage
// import 'forgotpass.dart';

// class ProfilePage extends StatefulWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   String username = 'User';
//   String? _profileImageUrl;
//   Uint8List? pickedImage;
//   User? _currentUser;

//   @override
//   void initState() {
//     super.initState();
//     fetchUserData(); // Fetch the user data when the profile page is initialized
//   }

//   Future<void> fetchUserData() async {
//     User? user = _auth.currentUser;

//     if (user != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       setState(() {
//         username = userDoc.exists && userDoc['name'] != null
//             ? userDoc['name']
//             : user.displayName ?? 'User';

//         // Use the Google account image if available, otherwise show a default image
//         _profileImageUrl =
//             user.photoURL ?? 'https://via.placeholder.com/150?text=No+Image';
//       });
//     }
//   }

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       try {
//         final Uint8List imageBytes = await image.readAsBytes();
//         setState(() {
//           pickedImage = imageBytes;
//         });
//         await _uploadImage(imageBytes);
//       } catch (e) {
//         print('Error picking image: $e');
//       }
//     }
//   }

//   Future<void> _uploadImage(Uint8List imageBytes) async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       try {
//         final storageRef = _storage
//             .ref()
//             .child('user_profile_images')
//             .child(user.uid + '.jpg');
//         await storageRef.putData(imageBytes);
//         String downloadURL = await storageRef.getDownloadURL();

//         await user.updatePhotoURL(downloadURL);
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .update({'photoURL': downloadURL});

//         setState(() {
//           _profileImageUrl = downloadURL;
//         });
//       } catch (e) {
//         print('Error uploading profile image: $e');
//       }
//     }
//   }

//   Future<void> _signOut(BuildContext context) async {
//     await _auth.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SignInPage(), // Update with your SignInPage path
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Profile', style: TextStyle(color: Colors.black)),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.grey[200],
//                   child: ClipOval(
//                     child: pickedImage != null
//                         ? Image.memory(
//                             pickedImage!,
//                             fit: BoxFit.cover,
//                             width: 80,
//                             height: 80,
//                           )
//                         : _profileImageUrl != null
//                             ? Image.network(
//                                 _profileImageUrl!,
//                                 fit: BoxFit.cover,
//                                 width: 80,
//                                 height: 80,
//                               )
//                             : Icon(Icons.person, size: 50, color: Colors.grey),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: -10, // Adjust if needed
//                   child: IconButton(
//                     icon: Icon(Icons.edit, color: Colors.black),
//                     onPressed: _pickImage,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             // Other ListTiles for settings, privacy policy, etc.
//           ],
//         ),
//       ),
//     );
//   }
// }
