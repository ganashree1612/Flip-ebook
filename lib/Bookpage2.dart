import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Someone like you',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
      debugShowCheckedModeBanner: false,
      home: BookPage(
        toggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class BookPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  BookPage({required this.toggleTheme, required this.isDarkMode});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final FlutterTts flutterTts = FlutterTts();
  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  bool _isSpeaking = false;


  final String chapter1 = """
    CHAPTER-1:
    Round the house a dozen or so tiny ostrich chicks were picking at the ground, or disputing the possession of some unexpected dainty 
    with a tribe of long-legged fowls. Quaint enough they looked, these little, fluffy balls, with their bright eyes, and tawny, spotted necks;
    frail enough, too, and apt to come off badly at the spur or beak of any truculent rooster who should resent their share of the plunder 
    aforesaid. Nominally they are under the care of a small Kafir boy, but the little black rascal—his master being absent and his mistress 
    soft hearted—prefers the congenial associations of yonder group of beehive huts away there behind the sheep kraals, and the fun of building
    miniature kraals with mud and three or four boon companions, so the ostrich chicks are left to herd themselves. But the volleying boom of 
    their male parent, down there in the great enclosure, rolls out loudly enough on the evening air, and the huge bird may be described in all 
    the glory of his jet and snowy plumage, with inflated throat, rearing himself to his full height, rolling his fiery eye in search of an adversary.
    And now the flaming rays of the sinking sun have given place to a softer, mellower light, and the red afterglow is merging into the pearly grey
    of evening. The hillside is streaked with the dappled hides of cattle coming up the kloof, and many a responsive low greets the clamourous 
    voices of the calves, shut up in the calf hoek, hungry and expectant.
  """;

  final String chapter2 = """
    CHAPTER-2:
    It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.
    However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered the rightful property of some one or other of their daughters.
    “My dear Mr. Bennet,” said his lady to him one day, “have you heard that Netherfield Park is let at last?”
    Mr. Bennet replied that he had not.
    “But it is,” returned she; “for Mrs. Long has just been here, and she told me all about it.”
    Mr. Bennet made no answer.
    “Do you not want to know who has taken it?” cried his wife impatiently.
    “You want to tell me, and I have no objection to hearing it.”
    This was invitation enough.
    “Why, my dear, you must know, Mrs. Long says that Netherfield is taken by a young man of large fortune from the north of England; that he came down on Monday in a chaise and four to see the place, and was so much delighted with it, that he agreed with Mr. Morris immediately; that he is to take possession before Michaelmas, and some of his servants are to be in the house by the end of next week.”
    “What is his name?”
    “Bingley.”
    “Is he married or single?”
    “Oh! Single, my dear, to be sure! A single man of large fortune; four or five thousand a year. What a fine thing for our girls!”
    “How so? How can it affect them?”
    “My dear Mr. Bennet,” replied his wife, “how can you be so tiresome! You must know that I am thinking of his marrying one of them.”
    “Is that his design in settling here?”
    “Design! Nonsense, how can you talk so! But it is very likely that he may fall in love with one of them, and therefore you must visit him as soon as he comes.”
    “I see no occasion for that. You and the girls may go, or you may send them by themselves, which perhaps will be still better, for as you are as handsome as any of them, Mr. Bingley may like you the best of the party.”
  """;
  final String chapter3 = """
    CHAPTER-3:
    Eanswyth Carhayes stood on the stoep, looking out for the return of her husband and cousin. She was very tall for a woman, her erect 
    carriage causing her to appear even taller. And she was very beautiful. The face, with its straight, thoroughbred features, was one of 
    those which, at first sight, conveyed an impression of more than ordinary attractiveness, and this impression further acquaintance never 
    failed to develop into a realisation of its rare loveliness. Yet by no means a mere animal or flower-like beauty. There was character in 
    the strongly marked, arching brows, and in the serene, straight glance of the large, grey eyes. Further, there was indication that their 
    owner would not be lacking in tact or fixity of purpose; two qualities usually found hand in hand. Her hair, though dark, was many shades 
    removed from black, and of it she possessed a more than bountiful supply.
    She came of a good old Colonial family, but had been educated in England. Well educated, too; thanks to which salutary storing of a mind 
    eagerly open to culture, many an otherwise dull and unoccupied hour of her four years of married life—frequently left, as she was, alone for 
    a whole day at a time—was turned to brightness. Alone? Yes, for she was childless.
  """;
  final String chapter4 = """
    CHAPTER-4:
    “My dear, you flatter me. I certainly have had my share of beauty, but I do not pretend to be anything extraordinary now. When a woman has five grown-up daughters, she ought to give over thinking of her own beauty.”
    “In such cases, a woman has not often much beauty to think of.”
    “But, my dear, you must indeed go and see Mr. Bingley when he comes into the neighbourhood.”
    “It is more than I engage for, I assure you.”
    “But consider your daughters. Only think what an establishment it would be for one of them. Sir William and Lady Lucas are determined to go, merely on that account, for in general, you know, they visit no newcomers. Indeed you must go, for it will be impossible for us to visit him if you do not.”
    “You are over-scrupulous, surely. I dare say Mr. Bingley will be very glad to see you; and I will send a few lines by you to assure him of my hearty consent to his marrying whichever he chooses of the girls; though I must throw in a good word for my little Lizzy.”
    “I desire you will do no such thing. Lizzy is not a bit better than the others; and I am sure she is not half so handsome as Jane, nor half so good-humoured as Lydia. But you are always giving her the preference.”
    “They have none of them much to recommend them,” replied he; “they are all silly and ignorant like other girls; but Lizzy has something more of quickness than her sisters.”
    “Mr. Bennet, how can you abuse your own children in such a way? You take delight in vexing me. You have no compassion for my poor nerves.”
  """;
  final String chapter5 = """
    CHAPTER-5:
    Eanswyth Carhayes stood on the stoep, looking out for the return of her husband and cousin. She was very tall for a woman, her erect carriage 
    causing her to appear even taller. And she was very beautiful. The face, with its straight, thoroughbred features, was one of those which, at 
    first sight, conveyed an impression of more than ordinary attractiveness, and this impression further acquaintance never failed to develop into
    a realisation of its rare loveliness. Yet by no means a mere animal or flower-like beauty. There was character in the strongly marked, arching brows,
    and in the serene, straight glance of the large, grey eyes. Further, there was indication that their owner would not be lacking in tact or 
    fixity of purpose; two qualities usually found hand in hand. Her hair, though dark, was many shades removed from black, and of it she possessed
    a more than bountiful supply.
    She came of a good old Colonial family, but had been educated in England. Well educated, too; thanks to which salutary storing of a mind
     eagerly open to culture, many an otherwise dull and unoccupied hour of her four years of married life—frequently left, as she was, alone
      for a whole day at a time—was turned to brightness. Alone? Yes, for she was childless.
  """;

  final List<String> chapters = [];

  @override
  void initState() {
    super.initState();
    chapters.addAll([chapter1, chapter2, chapter3, chapter4, chapter5]);
    _pageController = PageController(initialPage: _currentPageIndex);

    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page!.round();
        _stopTts();
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
    setState(() {
      _isSpeaking = true;
    });
  }

  Future<void> _stopTts() async {
    if (_isSpeaking) {
      await flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
    }
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      iconTheme: IconThemeData(
          color: widget.isDarkMode ? Colors.white : Colors.black),
      elevation: 0,
      title: Text(
        'The Catcher in the Rye',
        style: TextStyle(
            color: widget.isDarkMode ? Colors.white : Colors.black),
      ),
      actions: [
        IconButton(
          icon: Icon(_isSpeaking ? Icons.stop : Icons.volume_up),
          onPressed: () {
            if (_isSpeaking) {
              _stopTts();
            } else {
              _speak(chapters[_currentPageIndex]);
            }
          },
        ),
        IconButton(
          icon: Icon(
              widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
          onPressed: widget.toggleTheme,
        ),
      ],
    ),
    body: PageView.builder(
      controller: _pageController,
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Text(
              chapters[index],
              style: TextStyle(
                  fontSize: 18,
                  color: widget.isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        );
      },
    ),
  );
}

//   List<String> get chapters => [chapter1, chapter2,chapter3,chapter4,chapter5];

//   @override
//   void initState() {
//     super.initState();
//     _pageController.addListener(() {
//       setState(() {
//         _currentPageIndex = _pageController.page?.toInt() ?? 0;
//       });
//     });
//   }
//   @override
//   void dispose() {
//     flutterTts.stop();
//     _pageController.dispose();
//     super.dispose();
//   }

//   Future<void> _speak(String text) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1.0);

//     // Splitting the text into chunks to prevent TTS issues
//     List<String> splits = text.split('\n\n');

//     for (String chunk in splits) {
//       await flutterTts.speak(chunk);
//       await flutterTts.awaitSpeakCompletion(true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         flutterTts.stop(); // Stop TTS when navigating back
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Someone like you'),
//           actions: [
//             IconButton(
//               icon: Icon(
//                   widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
//               onPressed: widget.toggleTheme,
//             ),
//             IconButton(
//               icon: Icon(Icons.volume_up),
//               onPressed: () {
//                 _speak(chapters[_pageController.page?.toInt() ?? 0]);
//               },
//             ),
//           ],
//         ),
//         body: PageView.builder(
//           controller: _pageController,
//           itemCount: chapters.length,
//           itemBuilder: (context, index) {
//             return SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   chapters[index],
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
}
