import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Allpage());
}

class Allpage extends StatefulWidget {
  @override
  _AllpageState createState() => _AllpageState();
}

class _AllpageState extends State<Allpage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    Were he wise he would elect to leave them alone entirely, and would withdraw quietly without betraying his presence. He might 
   indeed derive some modicum of satisfaction by subsequently sjambokking the defaulting Goníwe for deserting his post, though the wisdom 
   of that act of consolation may be doubted. But a thoroughly angry man is seldom wise, and Tom Carhayes forms no exception to the general
   rule. With a savage curse he breaks from his cover and rides furiously down upon the offending group.
   But if he imagines his unlooked for arrival is going to strike terror to the hearts of those daring and impudent poachers, he soon becomes 
   alive to his mistake. Two of them, including his own herd, are already standing. The others make no attempt to rise from their careless and 
   squatting posture. All contemplate him with absolute unconcern, and the half-concealed and contemptuous grin spread across the broad 
   countenance of his retainer in no wise tends to allay his fury.
   “What the devil are you doing here, Goníwe?” he cries. “Get away back to your flock at once, or I’ll tan your hide to ribbons. Here. Get out of the 
   light you two—I’m going to shoot that dog—unless you want the charge through yourselves instead.”
  """;

  final String chapter2 = """
    CHAPTER-2:
    The offence is an aggravated one. Not only is the act of poaching a very capital crime in his eyes, 
    but the perpetrator ought to be at that moment at least three miles away, herding about eleven hundred of his master’s sheep.
    These he has left to take care of themselves while he indulges in an illicit buck-hunt. Small wonder indeed that his said master, 
    at no time a good-tempered man, vows to make a condign example of him.
    The buck has nearly gained the crest of the ridge. Once over it his chances are good. The pursuing hound, running more by
    sight than by scent, may easily be foiled, by a sudden turn to right or left, and a double or two. The dog is a long way behind now,
    and the spectator has to rise in his stirrups to command a view of the situation. Fifty yards more and the quarry will be over the ridge 
    and in comparative safety.
    But from just that distance above there suddenly darts forth another dog—a white one. It has sprung from a patch of bush similar to 
    that which conceals the spectator. The buck, thoroughly demoralised by the advent of this new enemy, executes a rapid double, and thus pressed
    back into the very jaws of its first pursuer has no alternative but to head up the valley as fast as its legs can carry it.
  """;
  final List<String> chapters = [];

  @override
  void initState() {
    super.initState();
    chapters.addAll([chapter1, chapter2]);
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
          '',
          style:
              TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
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


  // final String chapter3 = """
  //   CHAPTER-3:
  //   It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.
  //   However little known the feelings or views of such a man may be on his first entering a neighbourhood, this truth is so well fixed in the minds of the surrounding families, that he is considered the rightful property of some one or other of their daughters.
  //   “My dear Mr. Bennet,” said his lady to him one day, “have you heard that Netherfield Park is let at last?”
  //   Mr. Bennet replied that he had not.
  //   “But it is,” returned she; “for Mrs. Long has just been here, and she told me all about it.”
  //   Mr. Bennet made no answer.
  //   “Do you not want to know who has taken it?” cried his wife impatiently.
  //   “You want to tell me, and I have no objection to hearing it.”
  //   This was invitation enough.
  //   “Why, my dear, you must know, Mrs. Long says that Netherfield is taken by a young man of large fortune from the north of England; that he came down on Monday in a chaise and four to see the place, and was so much delighted with it, that he agreed with Mr. Morris immediately; that he is to take possession before Michaelmas, and some of his servants are to be in the house by the end of next week.”
  //   “What is his name?”
  //   “Bingley.”
  //   “Is he married or single?”
  //   “Oh! Single, my dear, to be sure! A single man of large fortune; four or five thousand a year. What a fine thing for our girls!”
  //   “How so? How can it affect them?”
  //   “My dear Mr. Bennet,” replied his wife, “how can you be so tiresome! You must know that I am thinking of his marrying one of them.”
  //   “Is that his design in settling here?”
  //   “Design! Nonsense, how can you talk so! But it is very likely that he may fall in love with one of them, and therefore you must visit him as soon as he comes.”
  //   “I see no occasion for that. You and the girls may go, or you may send them by themselves, which perhaps will be still better, for as you are as handsome as any of them, Mr. Bingley may like you the best of the party.”
  // """;

  // final String chapter4 = """
  //   CHAPTER-4:
  //   Were he wise he would elect to leave them alone entirely, and would withdraw quietly without betraying his presence. He might
  //   indeed derive some modicum of satisfaction by subsequently sjambokking the defaulting Goníwe for deserting his post, though the wisdom
  //   of that act of consolation may be doubted. But a thoroughly angry man is seldom wise, and Tom Carhayes forms no exception to the general
  //   rule. With a savage curse he breaks from his cover and rides furiously down upon the offending group.
  //   But if he imagines his unlooked for arrival is going to strike terror to the hearts of those daring and impudent poachers, he soon becomes
  //   alive to his mistake. Two of them, including his own herd, are already standing. The others make no attempt to rise from their careless and
  //   squatting posture. All contemplate him with absolute unconcern, and the half-concealed and contemptuous grin spread across the broad
  //   countenance of his retainer in no wise tends to allay his fury.
  //   “What the devil are you doing here, Goníwe?” he cries. “Get away back to your flock at once, or I’ll tan your hide to ribbons. Here. Get out of the
  //   light you two—I’m going to shoot that dog—unless you want the charge through yourselves instead.”
  // """;

  // final String chapter5 = """
  //   CHAPTER-5:
  //   From the high ridge on which the two men were riding, the eye could wander at will over the rolling, grassy plains and mimosa-dotted dales of Kaffraria.
  //   The pure azure of the heavens was unflecked by a single cloud. The light, balmy air of this early spring day was as invigorating as wine.
  //   Far away to the southeast the sweep of undulating grass land melted into an indistinct blue haze—the Indian Ocean—while in the opposite
  //   direction the panorama was barred by the hump-like Kabousie Heights, their green slopes alternating with lines of dark forest in a straggling
  //   labyrinth of intersecting kloofs. Far away over the golden, sunlit plains, the white walls of a farmhouse or two were discernible, and here
  //   and there, rising in a line upon the still atmosphere, a column of grey smoke marked the locality of many a distant kraal lying along the spurs
  //   of the hills. So still, so transparent, indeed, was the air that even the voices of their savage inhabitants and the low of cattle floated
  //   faintly across the wide and intervening space. Beneath—against the opposite ridge, about half a mile distant, the red ochre on their clothing
  //   and persons showing in vivid and pleasing contrast against the green of the hillside, moved ten or a dozen Kafirs—men, women, and children.
  //   They stepped out in line at a brisk, elastic pace, and the lazy hum of their conversation drifted to the ears of the two white men so plainly
  //   that they could almost catch its burden.
  // """;

//   List<String> get chapters => [chapter1, chapter2];

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
//           actions: [
//             IconButton(
//               icon: Icon(
//                   widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
//               onPressed: widget.toggleTheme,
//             ),
//             IconButton(
//               icon: Icon(Icons.volume_up),
//               onPressed: () {
//                 _speak(chapters[_currentPageIndex]);
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
