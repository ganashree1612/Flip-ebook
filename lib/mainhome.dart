import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'bookmark.dart';
import 'profile.dart';
import 'book1.dart';
import 'community.dart';
import 'book2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'travel.dart';
import 'art.dart';
import 'Great.dart';
import 'biography.dart';
import 'mystery.dart';
import 'scifi.dart';
import 'comics.dart';
import 'buisness.dart';
import 'food.dart';
import 'atomic.dart';
import 'Guide.dart';
import 'romantic.dart';
import 'adventure.dart';
import 'time.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Light blue background
          selectedItemColor: Colors.blue, // Selected item color
          unselectedItemColor: Colors.black, // Unselected item color
          elevation: 4,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: MainHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int selectedIndex = 0;

  final List<String> genres = [
    'ALL',
    'Travel',
    'Biography',
    'Novel',
    'Art & Photography',
    'Fantasy',
    'Horror',
    'Sci-Fi',
    'Comics',
    'Adventure',
    'Romance',
    'Guide/How-to',
    'Philosophy',
    'Business',
    'Food',
  ];

  String username = 'User';
  String profileImageUrl = '';
  String searchQuery = '';
  String selectedGenre = 'ALL';

  final List<Book> books = [
    Book(
        imagePath: 'assets/startpage/time.jpg',
        title: 'Time machine',
        author: 'J.D. Salinger',
        category: 'Novel',
        page: Time()),
    Book(
        imagePath: 'assets/startpage/cathcer.png',
        title: 'Catcher in the Rye',
        author: 'J.D. Salinger',
        category: 'Novel',
        page: Books1()),
    Book(
        imagePath: 'assets/startpage/someone.png',
        title: 'Someone Like You',
        author: 'Roald Dahl',
        category: 'Biography',
        page: Book2()),
    Book(
        imagePath: 'assets/startpage/travel.ipg.jpg',
        title: 'Travel Adventures',
        author: 'John Doe',
        category: 'Travel',
        page: Travel()),
    Book(
        imagePath: 'assets/startpage/artp.jpg',
        title: 'Art of Photography',
        author: 'Jane Doe',
        category: 'Art & Photography',
        page: Art()),
    Book(
        imagePath: 'assets/startpage/greatgatsby.jpeg',
        title: 'The Great Gatsby',
        author: 'F. Scott Fitzgerald',
        category: 'Novel',
        page: Great()),
    Book(
        imagePath: 'assets/startpage/biography.jpg',
        title: "Legend's Biography",
        author: 'Anonymous',
        category: 'Biography',
        page: Biography()),
    Book(
        imagePath: 'assets/startpage/mystery.jpeg',
        title: 'Mystery in Horror',
        author: 'Ghost Writer',
        category: 'Horror',
        page: Mystery()),
    Book(
        imagePath: 'assets/startpage/scifijpeg.jpeg',
        title: 'Sci-Fi Wonders',
        author: 'Sci Fi Guru',
        category: 'Sci-Fi',
        page: Scifi()),
    Book(
        imagePath: 'assets/startpage/comics.jpg',
        title: 'Comics Collection',
        author: 'Comic Fan',
        category: 'Comics',
        page: Comics()),
    Book(
        imagePath: 'assets/startpage/adventure.jpg',
        title: 'Adventure Awaits',
        author: 'Explorer',
        category: 'Adventure',
        page: Adventure()),
    Book(
        imagePath: 'assets/startpage/romantic.jpg',
        title: 'Romantic Tales',
        author: 'Love Story',
        category: 'Romance',
        page: Romantic()),
    Book(
        imagePath: 'assets/startpage/the_tales_of_thames.png',
        title: 'How-to Guide',
        author: 'Guide Master',
        category: 'Guide/How-to',
        page: Guide()),
    Book(
        imagePath: 'assets/startpage/book5.png',
        title: 'Atomic Habits',
        author: 'James Clear',
        category: 'Philosophy',
        page: Atomic()),
    Book(
        imagePath: 'assets/startpage/the_lost_world.png',
        title: 'Business Strategies',
        author: 'Business Expert',
        category: 'Business',
        page: Buisness()),
    Book(
        imagePath: 'assets/startpage/food.jpg',
        title: 'Food Lover\'s Guide',
        author: 'Chef',
        category: 'Food',
        page: Food()),
    // Add more dummy books as needed
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Future<void> fetchUserData() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();

  //     setState(() {
  //       if (userDoc.exists && userDoc['name'] != null) {
  //         username = userDoc['name'];
  //       } else {
  //         username = user.displayName ?? 'User';
  //       }

  //       profileImageUrl =
  //           'https://www.gravatar.com/avatar/?d=identicon';
  //     });
  //   }
  // }
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

        // Check if the user has a photo URL from Google sign-in
        if (user.photoURL != null && user.photoURL!.isNotEmpty) {
          profileImageUrl = user.photoURL!;
        } else {
          // Default grey person image
          profileImageUrl =
              'https://via.placeholder.com/150/cccccc/ffffff?text=User';
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    List<Book> filteredBooks = books.where((book) {
      return (selectedGenre == 'ALL' || book.category == selectedGenre) &&
          (book.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
              book.author.toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();

    filteredBooks.sort((a, b) {
      return a.title.compareTo(b.title);
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Add functionality for menu button if needed
              },
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(profileImageUrl),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, $username!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'What do you want to read today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search all books',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: genres.map((genre) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGenre = genre;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedGenre == genre
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        genre,
                        style: TextStyle(
                          color: selectedGenre == genre
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65, // Adjusted aspect ratio
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                Book book = filteredBooks[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => book.page),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.white, // Card background set to white
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          book.imagePath,
                          fit: BoxFit.contain, // Adjust as needed
                          height: 160, // Decreased size for larger images
                          width: double.infinity,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  book.author,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Navigation bar background color
        selectedItemColor: Colors.blue, // Selected icon color
        unselectedItemColor: Colors.black, // Unselected icon color
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          switch (index) {
            case 0:
              // Already on Home Page
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarkPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityPage()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
        ],
      ),
    );
  }
}

class Book {
  final String imagePath;
  final String title;
  final String author;
  final String category;
  final Widget page;

  Book({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.category,
    required this.page,
  });
}
