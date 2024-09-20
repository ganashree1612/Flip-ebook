import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Timeread());
}

class Timeread extends StatefulWidget {
  @override
  _TimereadState createState() => _TimereadState();
}

class _TimereadState extends State<Timeread> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time machine',
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
    “Don’t follow you,” said Filby.
“Can a cube that does not last for any time at all, have a real existence?”
Filby became pensive. “Clearly,” the Time Traveller proceeded, “any real body must have extension in four directions: it must have Length, Breadth, Thickness, and—Duration. But through a natural infirmity of the flesh, which I will explain to you in a moment, we incline to overlook this fact. There are really four dimensions, three which we call the three planes of Space, and a fourth, Time. There is, however, a tendency to draw an unreal distinction between the former three dimensions and the latter, because it happens that our consciousness moves intermittently in one direction along the latter from the beginning to the end of our lives.”
“That,” said a very young man, making spasmodic efforts to relight his cigar over the lamp; “that . . . very clear indeed.”
“Now, it is very remarkable that this is so extensively overlooked,” continued the Time Traveller, with a slight accession of cheerfulness. “Really this is what is meant by the Fourth Dimension, though some people who talk about the Fourth Dimension do not know they mean it. It is only another way of looking at Time.
    """;

  final String chapter2 = """
    CHAPTER-2:
    “It is simply this. That Space, as our mathematicians have it, is spoken of as having three dimensions, which one may call Length, Breadth, and Thickness, and is always definable by reference to three planes, each at right angles to the others. But some philosophical people have been asking why three dimensions particularly—why not another direction at right angles to the other three?—and have even tried to construct a Four-Dimensional geometry. Professor Simon Newcomb was expounding this to the New York Mathematical Society only a month or so ago. You know how on a flat surface, which has only two dimensions, we can represent a figure of a three-dimensional solid, and similarly they think that by models of three dimensions they could represent one of four—if they could master the perspective of the thing. See?”
    """;

  final String chapter3 = """
    CHAPTER-3:
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

  final String chapter4 = """
    CHAPTER-4:
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

  final String chapter5 = """
    CHAPTER-5:
    From the high ridge on which the two men were riding, the eye could wander at will over the rolling, grassy plains and mimosa-dotted dales of Kaffraria. 
    The pure azure of the heavens was unflecked by a single cloud. The light, balmy air of this early spring day was as invigorating as wine. 
    Far away to the westward rose the jagged peaks of the Katberg mountains, seeming to melt into the deep blue of the horizon. The stillness of the morning 
    was broken by the harsh grating of the wheels of a heavily-laden ox-waggon, whose span of sixteen sleek, well-conditioned beasts came toiling up the 
    steep slope, urged by the ceaseless, and not too merciful, goad of the native cattle driver, supplemented by the shouts and shrill whistlings of the 
    Kafir “voorlooper.” Nearer, a couple of white-owned native herds, clad in a single greasy garment each, lounged listlessly on the veldt, now and again 
    hurling a listless stone at the more enterprising of the calves, who, ignoring the claims of maternal solicitude, would persist in kicking up their heels 
    in mild riot and executing an impartial promenade upon the growing mealie plants in the adjacent lands.
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
          'Time machine',
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
}
