import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Secondpage());
}

class Secondpage extends StatefulWidget {
  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'The Catcher in the Rye',
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
    Now the way that the book winds up is this:  Tom and me found the money that the robbers hid in the cave, and it made us rich.  
    We got six thousand dollars apiece—all gold.  It was an awful sight of money when it was piled up.  Well, Judge Thatcher he took it 
    and put it out at interest, and it fetched us a dollar a day apiece all the year round—more than a body could tell what to do with.  The
     Widow Douglas she took me for her son, and allowed she would sivilize me; but it was rough living in the house all the time, considering 
     how dismal regular and decent the widow was in all her ways; and so when I couldn’t stand it no longer I lit out.  I got into my old rags 
     and my sugar-hogshead again, and was free and satisfied.  But Tom Sawyer he hunted me up and said he was going to start a band of robbers, 
     and I might join if I would go back to the widow and be respectable.  So I went back.
    The widow she cried over me, and called me a poor lost lamb, and she called me a lot of other names, too, but she never meant no harm by it.
     She put me in them new clothes again, and I couldn’t do nothing but sweat and sweat, and feel all cramped up.  Well, then, the old thing
      commenced again.  The widow rung a bell for supper, and you had to come to time. When you got to the table you couldn’t go right to eating,
       but you had to wait for the widow to tuck down her head and grumble a little over the victuals, though there warn’t really anything the
        matter with them,—that is, nothing only everything was cooked by itself.  In a barrel of odds and ends it is different; things get mixed 
    up, and the juice kind of swaps around, and the things go better.
  """;

  final String chapter2 = """
    CHAPTER-2:
    Pretty soon I wanted to smoke, and asked the widow to let me.  But she wouldn’t.  She said it was a mean practice and wasn’t 
    clean, and I must try to not do it any more.  That is just the way with some people.  They get down on a thing when they don’t
    know nothing about it.  Here she was a-bothering about Moses, which was no kin to her, and no use to anybody, being gone, you see, 
    yet finding a power of fault with me for doing a thing that had some good in it.  And she took snuff, too; of course that was all right,
    because she done it herself.
    Her sister, Miss Watson, a tolerable slim old maid, with goggles on, had just come to live with her, and took a set at me now with a
    spelling-book. She worked me middling hard for about an hour, and then the widow made her ease up.  I couldn’t stood it much longer.  
    Then for an hour it was deadly dull, and I was fidgety.  Miss Watson would say, “Don’t put your feet up there, Huckleberry;” and “Don’t 
    scrunch up like that, Huckleberry—set up straight;” and pretty soon she would say, “Don’t gap and stretch like that, Huckleberry—why don’t
    you try to behave?”  Then she told me all about the bad place, and I said I wished I was there. She got mad then, but I didn’t mean no harm.  
    All I wanted was to go somewheres; all I wanted was a change, I warn’t particular.  She said it was wicked to say what I said; said she
    wouldn’t say it for the whole world; she was going to live so as to go to the good place.  Well, I couldn’t see no advantage in going where 
    she was going, so I made up my mind I wouldn’t try for it.  But I never said so, because it would only make trouble, and wouldn’t do no good.
  """;

  final String chapter3 = """
    CHAPTER-3:
    Miss Watson she kept pecking at me, and it got tiresome and lonesome.  By and by they fetched the niggers in and had prayers, and then
     everybody was off to bed.  I went up to my room with a piece of candle, and put it on the table.  Then I set down in a chair by the window 
     and tried to think of something cheerful, but it warn’t no use.  I felt so lonesome I most wished I was dead.  The stars were shining, and
      the leaves rustled in the woods ever so mournful; and I heard an owl, away off, who-whooing about somebody that was dead, and a whippowill 
      and a dog crying about somebody that was going to die; and the wind was trying to whisper something to me, and I couldn’t make out what it 
      was, and so it made the cold shivers run over me. Then away out in the woods I heard that kind of a sound that a ghost makes when it wants 
      to tell about something that’s on its mind and can’t make itself understood, and so can’t rest easy in its grave, and has to go about that 
      way every night grieving.  I got so down-hearted and scared I did wish I had some company.  Pretty soon a spider went crawling up my 
      shoulder, and I flipped it off and it lit in the candle; and before I could budge it was all shriveled up.  I didn’t need anybody to tell me 
      that that was an awful bad sign and would fetch me some bad luck, so I was scared and most shook the clothes off of me. I got up and turned 
      around in my tracks three times and crossed my breast every time; and then I tied up a little lock of my hair with a thread to keep witches
       away.  But I hadn’t no confidence.  You do that when you’ve lost a horseshoe that you’ve found, instead of nailing it up over the door, but
        I hadn’t ever heard anybody say it was any way to keep off bad luck when you’d killed a spider.
  """;
  final List<String> chapters = [];

  @override
  void initState() {
    super.initState();
    chapters.addAll([chapter1, chapter2, chapter3]);
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

  // List<String> get chapters => [chapter1, chapter2,chapter3];
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController.addListener(() {
  //     setState(() {
  //       _currentPageIndex = _pageController.page?.toInt() ?? 0;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   flutterTts.stop();
  //   _pageController.dispose();
  //   super.dispose();
  // }

  // Future<void> _speak(String text) async {
  //   await flutterTts.setLanguage("en-US");
  //   await flutterTts.setPitch(1.0);

  //   // Splitting the text into chunks to prevent TTS issues
  //   List<String> splits = text.split('\n\n');

  //   for (String chunk in splits) {
  //     await flutterTts.speak(chunk);
  //     await flutterTts.awaitSpeakCompletion(true);
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: () async {
  //       flutterTts.stop(); // Stop TTS when navigating back
  //       return true;
  //     },
  //     child: Scaffold(
  //       appBar: AppBar(
  //         // title: Text('The Catcher in the Rye'),
  //         actions: [
  //           IconButton(
  //             icon: Icon(
  //                 widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
  //             onPressed: widget.toggleTheme,
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.volume_up),
  //             onPressed: () {
  //               _speak(chapters[_pageController.page?.toInt() ?? 0]);
  //             },
  //           ),
  //         ],
  //       ),
  //       body: PageView.builder(
  //         controller: _pageController,
  //         itemCount: chapters.length,
  //         itemBuilder: (context, index) {
  //           return SingleChildScrollView(
  //             child: Padding(
  //               padding: EdgeInsets.all(16.0),
  //               child: Text(
  //                 chapters[index],
  //                 style: TextStyle(
  //                   fontSize: 16.0,
  //                   letterSpacing: 0.5,
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
