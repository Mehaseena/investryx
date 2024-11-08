// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:intl/intl.dart';
// import '../services/messages get service.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String roomId;
//   final String name;
//   final String? imageUrl;
//   final int? chatUserId;
//
//   ChatScreen({
//     required this.roomId,
//     required this.name,
//     this.imageUrl,
//     this.chatUserId,
//   });
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final FlutterSecureStorage _storage = FlutterSecureStorage();
//   late WebSocketChannel channel;
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, String>> messages = [];
//   String? token;
//   bool isLoading = true;
//   bool hasError = false;
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeWebSocketConnection();
//     _fetchMessages();
//   }
//
//   Future<void> _fetchMessages() async {
//     try {
//       List<MessageData>? fetchedMessages = await MessageService.fetchMessageData(widget.roomId);
//       if (fetchedMessages != null) {
//         setState(() {
//           messages.addAll(fetchedMessages.map((message) => {
//             'message': message.message!,
//             'sendedBy': message.sendedBy,
//             'sendedTo': message.sendedTo,
//             'time': message.time!,
//           }));
//           isLoading = false;
//         });
//         _scrollToBottom();
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _initializeWebSocketConnection() async {
//     token = await _storage.read(key: 'token');
//
//     if (token != null) {
//       channel = WebSocketChannel.connect(
//         Uri.parse('ws://13.203.36.158:8001/${widget.roomId}?token=$token'),
//       );
//
//       channel.stream.listen((message) {
//         final data = jsonDecode(message);
//         if (data['token'] != null && data['roomId'] == widget.roomId) {
//           setState(() {
//             messages.insert(0, {
//               'message': data['message'],
//               'token': data['token'],
//               'sendedBy': data['sendedBy'].toString(),
//               'sendedTo': data['sendedTo'].toString(),
//               'time': data['time']
//             });
//           });
//           _scrollToBottom();
//         }
//       });
//     } else {
//       _showSnackBar('Token not found. Please login again.');
//     }
//   }
//
//   Future<void> sendMessage() async {
//     final message = _messageController.text.trim();
//     if (message.isEmpty) {
//       _showSnackBar('The message is empty');
//     } else {
//       if (token != null) {
//         final data = jsonEncode({
//           'token': token,
//           'message': message,
//           'roomId': widget.roomId
//         });
//
//         channel.sink.add(data);
//         _messageController.clear();
//         _scrollToBottom();
//       } else {
//         _showSnackBar('Token not found. Please login again.');
//       }
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       behavior: SnackBarBehavior.floating,
//     ));
//   }
//
//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           0,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     channel.sink.close();
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black87),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
//                   ? NetworkImage(widget.imageUrl!)
//                   : AssetImage('assets/default_avatar.png')
//               ,
//               radius: 20,
//             ),
//             SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.name,
//                   style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Active now',
//                   style: TextStyle(color: Colors.green, fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.call_outlined, color: Colors.black87),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: isLoading
//                 ? _buildShimmerChatEffect()
//                 : hasError
//                 ? Center(child: Text('Failed to load messages', style: TextStyle(color: Colors.red)))
//                 : ListView.builder(
//               controller: _scrollController,
//               reverse: true,
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 bool isSentMessage = widget.chatUserId.toString() ==
//                     (message['sendedBy'] is String ? message['sendedBy'] : message['sendedBy'].toString());
//
//                 return MessageBubble(
//                   isFromUser: isSentMessage,
//                   message: message['message'] ?? 'No message',
//                   time: message['time'] ?? '...',
//                 );
//               },
//             ),
//           ),
//           _buildMessageComposer(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildShimmerChatEffect() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           bool isSentMessage = index % 2 == 0;
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
//             child: Align(
//               alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: isSentMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 150.0,
//                       height: 12.0,
//                       color: Colors.white,
//                     ),
//                     SizedBox(height: 4.0),
//                     Container(
//                       width: 100.0,
//                       height: 12.0,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildMessageComposer() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -2),
//             blurRadius: 6.0,
//             color: Colors.black.withOpacity(0.08),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: _messageController,
//                 decoration: InputDecoration(
//                   hintText: 'Type a message...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(25.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                 ),
//                 textInputAction: TextInputAction.send,
//                 onSubmitted: (value) => sendMessage(),
//               ),
//             ),
//             SizedBox(width: 8.0),
//             FloatingActionButton(
//               onPressed: sendMessage,
//               child: Icon(Icons.send, color: Colors.white),
//               backgroundColor: Color(0xff003C82),
//               elevation: 0,
//               mini: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MessageBubble extends StatelessWidget {
//   final bool isFromUser;
//   final String message;
//   final String time;
//
//   const MessageBubble({
//     required this.isFromUser,
//     required this.message,
//     required this.time,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
//       child: Align(
//         alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 21.0, vertical: 8.0),
//           decoration: BoxDecoration(
//             color: isFromUser ? Color(0xff003C82) : Colors.grey[200],
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(isFromUser ? 20.0 : 0.0),
//               topRight: Radius.circular(isFromUser ? 0.0 : 20.0),
//               bottomLeft: Radius.circular(20.0),
//               bottomRight: Radius.circular(20.0),
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 message,
//                 style: TextStyle(
//                   color: isFromUser ? Colors.white : Colors.black87,
//                   fontSize: 15.sp,
//                 ),
//               ),
//               SizedBox(height: 4.0),
//               Text(
//                 _formatDateTime(time),
//                 style: TextStyle(
//                   color: isFromUser ? Colors.white70 : Colors.black54,
//                   fontSize: 9.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String _formatDateTime(String dateTimeStr) {
//     DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();
//     return DateFormat('hh:mm a').format(dateTime);
//   }
// }
//
//
//



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import '../services/messages get service.dart';


class ChatScreen extends StatefulWidget {
  final String roomId;
  final String name;
  final String number;
  final String? imageUrl;
  final int? chatUserId;

  const ChatScreen({
    Key? key,
    required this.roomId,
    required this.name,
    this.imageUrl,
    this.chatUserId,
    required this.number,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  late WebSocketChannel channel;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> messages = [];
  String? token;
  bool isLoading = true;
  bool hasError = false;
  final ScrollController _scrollController = ScrollController();
  bool isEmojiVisible = false;
  final FocusNode _focusNode = FocusNode();
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    _initializeWebSocketConnection();
    _fetchMessages();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isEmojiVisible = false;
        });
      }
    });
  }

  Future<void> _showPhoneRedirectDialog(BuildContext context, String phoneNumber) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Circle with phone icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xff003C82).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_outlined,
                    size: 40,
                    color: Color(0xff003C82),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  'Make a Phone Call',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  'You are about to call:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),

                // Phone Number
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff003C82),
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel Button
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Call Button
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Color(0xff003C82),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: phoneNumber,
                          );
                          try {
                            if (await launcher.canLaunchUrl(launchUri)) {
                              await launcher.launchUrl(launchUri);
                            } else {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Could not launch phone dialer'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: ${e.toString()}'),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Call Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone number not available'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    await _showPhoneRedirectDialog(context, phoneNumber);
  }

  Future<void> _fetchMessages() async {
    try {
      MessageDataResponse? response = await MessageService.fetchMessageData(widget.roomId);
      if (response != null) {
        setState(() {
          messages.addAll(response.messages.map((message) => {
            'message': message.message!,
            'sendedBy': message.sendedBy,
            'sendedTo': message.sendedTo,
            'time': message.time!,
          }));
          phoneNumber = response.phoneNumber;
          isLoading = false;
        });
        _scrollToBottom();
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Future<void> _initializeWebSocketConnection() async {
    token = await _storage.read(key: 'token');

    if (token != null) {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://13.203.36.158:8001/${widget.roomId}?token=$token'),
      );

      channel.stream.listen((message) {
        final data = jsonDecode(message);
        if (data['token'] != null && data['roomId'] == widget.roomId) {
          setState(() {
            messages.insert(0, {
              'message': data['message'],
              'token': data['token'],
              'sendedBy': data['sendedBy'].toString(),
              'sendedTo': data['sendedTo'].toString(),
              'time': data['time']
            });
          });
          _scrollToBottom();
        }
      });
    } else {
      _showSnackBar('Token not found. Please login again.');
    }
  }

  Future<void> sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      _showSnackBar('The message is empty');
    } else {
      if (token != null) {
        final data = jsonEncode({
          'token': token,
          'message': message,
          'roomId': widget.roomId
        });

        channel.sink.add(data);
        _messageController.clear();
        _scrollToBottom();
      } else {
        _showSnackBar('Token not found. Please login again.');
      }
    }
  }

  void onEmojiSelected(Category? category, Emoji emoji) {
    final text = _messageController.text;
    final selection = _messageController.selection;
    final newText = text.replaceRange(selection.start, selection.end, emoji.emoji);
    final newSelection = TextSelection.collapsed(offset: selection.start + emoji.emoji.length);

    _messageController.value = TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }

  void toggleEmojiPicker() {
    setState(() {
      isEmojiVisible = !isEmojiVisible;
      if (isEmojiVisible) {
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    channel.sink.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isEmojiVisible) {
          setState(() {
            isEmojiVisible = false;
          });
        }
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildChatDate(),
            Expanded(
              child: isLoading
                  ? _buildShimmerChatEffect()
                  : hasError
                  ? _buildErrorState()
                  : _buildMessagesList(),
            ),
            _buildMessageComposer(),
            Offstage(
              offstage: !isEmojiVisible,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    onEmojiSelected(category, emoji);
                  },
                  textEditingController: _messageController,
                  config: Config(
                    height: 250,
                    checkPlatformCompatibility: true,
                    emojiViewConfig: EmojiViewConfig(
                      columns: 7,
                      emojiSizeMax: 32.0,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      // initCategory: Category.RECENT,
                      // bgColor: const Color(0xFFF2F2F2),
                      loadingIndicator: const SizedBox.shrink(),
                      noRecents: const Text(
                        'No Recent',
                        style: TextStyle(fontSize: 20, color: Colors.black26),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    categoryViewConfig: CategoryViewConfig(
                      tabBarHeight: 46,
                      indicatorColor: const Color(0xff003C82),
                      iconColor: Colors.grey,
                      iconColorSelected: const Color(0xff003C82),
                      backspaceColor: const Color(0xff003C82),
                      categoryIcons: const CategoryIcons(),
                      // buttonMode: ButtonMode.MATERIAL,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget
  _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Hero(
            tag: 'avatar_${widget.roomId}',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                    ? NetworkImage(widget.imageUrl!)
                    : AssetImage('assets/profile_picture.jpg') as ImageProvider,
                radius: 20,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Active now',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.call_outlined, color: Color(0xff003C82)),
          onPressed: phoneNumber != null && phoneNumber!.isNotEmpty
              ? () => _makePhoneCall(phoneNumber!)
              : () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Phone number not available'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _buildChatDate() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            'Today',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red[300], size: 48),
          SizedBox(height: 8),
          Text(
            'Failed to load messages',
            style: TextStyle(
              color: Colors.red[300],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        bool isSentMessage = widget.chatUserId.toString() ==
            (message['sendedBy'] is String ? message['sendedBy'] : message['sendedBy'].toString());

        return MessageBubble(
          isFromUser: isSentMessage,
          message: message['message'] ?? 'No message',
          time: message['time'] ?? '...',
        );
      },
    );
  }

  Widget _buildShimmerChatEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          bool isSentMessage = index % 2 == 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            child: Align(
              alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: isSentMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150.0,
                      height: 12.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      width: 100.0,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
    color: Colors.white,
    boxShadow: [
    BoxShadow(
    offset: Offset(0, -2),
    blurRadius: 6.0,
    color: Colors.black.withOpacity(0.08),
    ),
    ],
    ),
    child: SafeArea(
    child: Row(
    children: [
    IconButton(
    icon: Icon(Icons.attach_file_outlined, color: Colors.grey[600]),
    onPressed: () {},
    ),
    Expanded(
    child: Container(
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(25.0),
    border: Border.all(
    color: Colors.grey[300]!,
    width: 1,
    ),
    ),
    child: Row(
    children: [
    Expanded(
    child: TextField(
    controller: _messageController,
    focusNode: _focusNode,
    decoration: InputDecoration(
    hintText: 'Type a message...',
    hintStyle: TextStyle(color: Colors.grey[500]),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 10.0,
    ),
    ),
      textInputAction: TextInputAction.send,
      onSubmitted: (value) => sendMessage(),
      maxLines: null,
      keyboardType: TextInputType.multiline,
    ),
    ),
      IconButton(
        icon: Icon(
          isEmojiVisible
              ? Icons.keyboard
              : Icons.emoji_emotions_outlined,
          color: isEmojiVisible ? Color(0xff003C82) : Colors.grey[600],
        ),
        onPressed: toggleEmojiPicker,
      ),
    ],
    ),
    ),
    ),
      SizedBox(width: 8.0),
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff003C82), Color(0xff004C99)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xff003C82).withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: sendMessage,
          child: Icon(Icons.send, color: Colors.white, size: 20),
          backgroundColor: Colors.transparent,
          elevation: 0,
          mini: true,
        ),
      ),
    ],
    ),
    ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isFromUser;
  final String message;
  final String time;

  const MessageBubble({
    Key? key,
    required this.isFromUser,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: Align(
        alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery
                .of(context)
                .size
                .width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isFromUser ? Color(0xff003C82) : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isFromUser ? 20.0 : 0.0),
              topRight: Radius.circular(isFromUser ? 0.0 : 20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isFromUser ? Colors.white : Colors.black87,
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                _formatDateTime(time),
                style: TextStyle(
                  color: isFromUser ? Colors.white70 : Colors.black45,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();
    return DateFormat('hh:mm a').format(dateTime);
  }
}


