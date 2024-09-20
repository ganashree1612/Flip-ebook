import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart.dart'; // Import CartPage
import 'Bookmark.dart'; // Import BookmarkPage
import 'Bookpage1.dart';
import 'Allpagechap.dart'; // Import AdventureReadPage
class Adventure extends StatefulWidget {
  @override
  _AdventureState createState() => _AdventureState();
}

class _AdventureState extends State<Adventure> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isBookmarked = false;
  final String bookId = 'Adventure Awaits';
  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
    // Check initial bookmark status
    // isBookmarked = BookmarkPage.items.any((item) =>
    //     item['title'] == 'Adventure Awaits' &&
    //     item['author'] == 'Explorer');
  }
  Future<void> _checkBookmarkStatus() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('bookmarks').doc(bookId).get();
      setState(() {
        isBookmarked = doc.exists;
      });
    } catch (e) {
      print('Error checking bookmark status: $e');
    }
  }
 Future<void> toggleBookmark() async {
    try {
      if (!isBookmarked) {
        // Add bookmark to Firestore
        await _firestore.collection('bookmarks').doc(bookId).set({
          'imagePath': 'assets/startpage/adventure.jpg',
          'title': 'Adventure Awaits',
          'author': 'Explorer',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book Saved!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Remove bookmark from Firestore
        await _firestore.collection('bookmarks').doc(bookId).delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Book removed from Saved.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      setState(() {
        isBookmarked = !isBookmarked;
      });
    } catch (e) {
      print('Error toggling bookmark: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to toggle save: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> addToCart() async {
    // Add item to local cart
    Cart.items.add({
      'image': 'assets/startpage/adventure.jpg',
      'title': 'Adventure Awaits',
      'author': 'Explorer',
      'price': 250, // Replace with actual price
      'quantity': 1,
    });

    // Update Firestore cart collection
    try {
      await _firestore.collection('cart_items').add({
        'image': 'assets/startpage/adventure.jpg',
        'title': 'Adventure Awaits',
        'author': 'Explorer',
        'price': 250,
        'quantity': 1,
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Added to Cart'),
            content: Text('Successfully added to cart!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add to cart: $error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
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
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.red : null,
            ),
            onPressed: toggleBookmark,
          ),
        ],
        title: Text('Book Detail'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 243, 242, 242),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/startpage/adventure.jpg',
                height: 140,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Adventure Awaits',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Explorer',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border),
                SizedBox(width: 8),
                Text('4.0', style: TextStyle(fontSize: 18)),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'About the author',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Explorer was an American writer, best known for his 1951 novel The Adventure Awaits. Before its publication, Salinger published several short stories in Story magazine.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The Adventure Awaits is a novel by J. D. Salinger, partially published in serial form in 1945-1946 and as a novel in 1951. It was originally intended for adults but is often read by adolescents for its theme of angst, alienation, and as a critique of superficiality in society.',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to AdventureReadPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Allpage()), // Corrected navigation
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Read Preview'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: addToCart,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    child: Text(' + Add to Cart'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
