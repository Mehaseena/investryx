import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  final String roomName;
  final String token;
  final String toName;
  final String threadId;
  final String userId;

  ChatScreen({
    required this.roomName,
    required this.token,
    required this.toName,
    required this.threadId,
    required this.userId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();

    // Connect to WebSocket
    channel = WebSocketChannel.connect(
      Uri.parse('ws://13.203.36.158:8001/${widget.roomName}'),
    );

    // Listen for incoming messages
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      setState(() {
        messages.add({
          'message': data['message'],
          'username': data['username'],
        });
      });
      scrollToBottom();
    });
  }

  void sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('The message is empty'),
      ));
    } else {
      final data = jsonEncode({
        'message': message,
        'username': widget.token,
        'msgto': widget.toName,
        'threadid': widget.threadId,
        'uid': widget.userId,
      });

      channel.sink.add(data);
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    _messageController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    // Implement scroll logic if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Room')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message['username'] == widget.token;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message['message']!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter your message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
