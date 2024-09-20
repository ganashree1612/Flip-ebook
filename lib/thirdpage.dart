import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Thirdpage());
}

class Thirdpage extends StatefulWidget {
  @override
  _ThirdpageState createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
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
    As soon as Tom was back we cut along the path, around the garden fence, and by and by fetched up on the steep top of the hill the other side 
    of the house.  Tom said he slipped Jim’s hat off of his head and hung it on a limb right over him, and Jim stirred a little, but he didn’t 
    wake. Afterwards Jim said the witches be witched him and put him in a trance, and rode him all over the State, and then set him under the trees
     again, and hung his hat on a limb to show who done it.  And next time Jim told it he said they rode him down to New Orleans; and, after that, 
     every time he told it he spread it more and more, till by and by he said they rode him all over the world, and tired him most to death, and 
     his back was all over saddle-boils.  Jim was monstrous proud about it, and he got so he wouldn’t hardly notice the other niggers.  Niggers 
     would come miles to hear Jim tell about it, and he was more looked up to than any nigger in that country.  Strange niggers would stand with 
     their mouths open and look him all over, same as if he was a wonder.  Niggers is always talking about witches in the dark by the kitchen fire;
      but whenever one was talking and letting on to know all about such things, Jim would happen in and say, “Hm!  What you know ’bout witches?” 
      and that nigger was corked up and had to take a back seat.  Jim always kept that five-center piece round his neck with a string, and said it 
      was a charm the devil give to him with his own hands, and told him he could cure anybody with it and fetch witches whenever he wanted to just 
      by saying something to it; but he never told what it was he said to it.  Niggers would come from all around there and give Jim anything they
       had, just for a sight of that five-center piece; but they wouldn’t touch it, because the devil had had his hands on it.  Jim was most ruined 
       for a servant, because he got stuck up on account of having seen the devil and been rode by witches.
  """;

  final String chapter2 = """
    CHAPTER-2:

    We played robber now and then about a month, and then I resigned.  All the boys did.  We hadn’t robbed nobody, hadn’t killed any people, but
    only just pretended.  We used to hop out of the woods and go charging down on hog-drivers and women in carts taking garden stuff to market, 
    but we never hived any of them.  Tom Sawyer called the hogs “ingots,” and he called the turnips and stuff “julery,” and we would go to the 
    cave and powwow over what we had done, and how many people we had killed and marked.  But I couldn’t see no profit in it.  One time Tom sent a
     boy to run about town with a blazing stick, which he called a slogan (which was the sign for the Gang to get together), and then he said he 
     had got secret news by his spies that next day a whole parcel of Spanish merchants and rich A-rabs was going to camp in Cave Hollow with two 
     hundred elephants, and six hundred camels, and over a thousand “sumter” mules, all loaded down with di’monds, and they didn’t have only a 
     guard of four hundred soldiers, and so we would lay in ambuscade, as he called it, and kill the lot and scoop the things.  He said we must 
     slick up our swords and guns, and get ready.  He never could go after even a turnip-cart but he must have the swords and guns all scoured up 
     for it, though they was only lath and broomsticks, and you might scour at them till you rotted, and then they warn’t worth a mouthful of ashes
      more than what they was before.  I didn’t believe we could lick such a crowd of Spaniards and A-rabs, but I wanted to see the camels and 
      elephants, so I was on hand next day, Saturday, in the ambuscade; and when we got the word we rushed out of the woods and down the hill.  
      But there warn’t no Spaniards and A-rabs, and there warn’t no camels nor no elephants.  It warn’t anything but a Sunday-school picnic, and 
      only a primer-class at that.  
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

  // List<String> get chapters => [chapter1, chapter2, chapter3];
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
  }

