import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String title;

  ChatPage({required this.title});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> _messages = [
    {'sender': 'You', 'text': 'Hello!'},
    {'sender': 'Group Member', 'text': 'Hi there!'},
  ];

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'sender': 'You',
          'text': _controller.text,
        });
        _controller.clear();
      });

      // Save message to Firestore
      await _firestore
          .collection('chats')
          .doc(widget.title)
          .collection('messages')
          .add({
        'sender': 'You',
        'text': _controller.text,
        'time': DateTime.now(),
      });

      // Simulate automated reply after a short delay
      _simulateReply();
    }
  }

  void _simulateReply() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'sender': 'Group Member',
          'text': 'Hello.',
        });
      });

      // Save automated reply to Firestore
      _firestore
          .collection('chats')
          .doc(widget.title)
          .collection('messages')
          .add({
        'sender': 'Group Member',
        'text': 'Hello.',
        'time': DateTime.now(),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == 'You';
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200], // Grey background for message input box
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
