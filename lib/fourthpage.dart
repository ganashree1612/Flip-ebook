import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Fourthpage());
}

class Fourthpage extends StatefulWidget {
  @override
  _FourthpageState createState() => _FourthpageState();
}

class _FourthpageState extends State<Fourthpage> {
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

    At first I hated the school, but by and by I got so I could stand it. Whenever I got uncommon tired I played hookey, and the hiding I got next 
    day done me good and cheered me up.  So the longer I went to school the easier it got to be.  I was getting sort of used to the widow’s ways,
     too, and they warn’t so raspy on me.  Living in a house and sleeping in a bed pulled on me pretty tight mostly, but before the cold weather I
      used to slide out and sleep in the woods sometimes, and so that was a rest to me.  I liked the old ways best, but I was getting so I liked 
      the new ones, too, a little bit. The widow said I was coming along slow but sure, and doing very satisfactory.  She said she warn’t ashamed 
      of me.
      One morning I happened to turn over the salt-cellar at breakfast.  I reached for some of it as quick as I could to throw over my left 
      shoulder and keep off the bad luck, but Miss Watson was in ahead of me, and crossed me off. She says, “Take your hands away, Huckleberry;
       what a mess you are always making!”  The widow put in a good word for me, but that warn’t going to keep off the bad luck, I knowed that 
       well enough.  I started out, after breakfast, feeling worried and shaky, and wondering where it was going to fall on me, and what it was 
       going to be.  There is ways to keep off some kinds of bad luck, but this wasn’t one of them kind; so I never tried to do anything, but just 
       poked along low-spirited and on the watch-out.
        went down to the front garden and clumb over the stile where you go through the high board fence.  There was an inch of new snow on the ground, and I seen somebody’s tracks.  
        They had come up from the quarry and stood around the stile a while, and then went on around the garden fence.  It was funny they hadn’t come in, after standing around so.
          I couldn’t make it out.  It was very curious, somehow.  I was going to follow around, but I stooped down to look at the tracks first.  I 
          didn’t notice anything at first, but next I did.  There was a cross in the left boot-heel made with big nails, to keep off the devil
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
      only a primer-class at that.  We busted it up, and chased the children up the hollow; but we never got anything but some doughnuts and jam, 
      though Ben Rogers got a rag doll, and Jo Harper got a hymn-book and a tract; and then the teacher charged in, and made us drop everything and 
      cut.
  """;

  final String chapter3 = """
    CHAPTER-3:
    
    WELL, pretty soon the old man was up and around again, and then he went for Judge Thatcher in the courts to make him give up that money, and 
    he went for me, too, for not stopping school.  He catched me a couple of times and thrashed me, but I went to school just the same, and dodged
     him or outrun him most of the time.  I didn’t want to go to school much before, but I reckoned I’d go now to spite pap.  That law trial was a 
     slow business—appeared like they warn’t ever going to get started on it; so every now and then I’d borrow two or three dollars off of the 
     judge for him, to keep from getting a cowhiding.  Every time he got money he got drunk; and every time he got drunk he raised Cain around 
     town; and every time he raised Cain he got jailed.  He was just suited—this kind of thing was right in his line.
     He got to hanging around the widow’s too much and so she told him at last that if he didn’t quit using around there she would make trouble 
     for him. Well, wasn’t he mad?  He said he would show who was Huck Finn’s boss.  So he watched out for me one day in the spring, and catched 
     me, and took me up the river about three mile in a skiff, and crossed over to the Illinois shore where it was woody and there warn’t no houses
      but an old log hut in a place where the timber was so thick you couldn’t find it if you didn’t know where it was.
      He kept me with him all the time, and I never got a chance to run off. We lived in that old cabin, and he always locked the door and put the
     key under his head nights.  He had a gun which he had stole, I reckon, and we fished and hunted, and that was what we lived on.  Every little
      while he locked me in and went down to the store, three miles, to the ferry, and traded fish and game for whisky, and fetched it home and got
       drunk and had a good time, and licked me.  The widow she found out where I was by and by, and she sent a man over to try to get hold of me; 
       but pap drove him off with the gun, and it warn’t long after that till I was used to being where I was, and liked it—all but the cowhide 
       part.
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

//   List<String> get chapters => [chapter1, chapter2, chapter3];

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
//           // title: Text('The Catcher in the Rye'),
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
