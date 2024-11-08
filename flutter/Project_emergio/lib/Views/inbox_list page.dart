import 'dart:convert';
import 'dart:developer';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:project_emergio/Views/chat%20screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../services/chatUserCheck.dart';
import '../services/inbox service.dart';
import 'package:timeago/timeago.dart' as timeago;


class InboxListScreen extends StatefulWidget {
  InboxListScreen({Key? key}) : super(key: key);

  @override
  _InboxListScreenState createState() => _InboxListScreenState();
}

class _InboxListScreenState extends State<InboxListScreen> with SingleTickerProviderStateMixin {
  List<InboxItems>? _inboxData;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  int? chatUserId;
  late WebSocketChannel channel;
  bool _isLoading = true;
  String? token;
  final ScrollController _scrollController = ScrollController();
  int? _selectedIndex;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeWebSocketConnection();
    _fetchInboxData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _fetchInboxData() async {
    try {
      final userId = await ChatUserCheck.fetchChatUserData();
      final inboxData = await Inbox.fetchInboxData();
      if (mounted) {
        setState(() {
          chatUserId = userId;
          _inboxData = inboxData;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error fetching inbox data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _initializeWebSocketConnection() async {
    token = await _storage.read(key: 'token');

    if (token != null) {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://13.203.36.158:8001/rooms'),
      );

      channel.stream.listen((room) {
        final roomdata = jsonDecode(room);
        var data = roomdata['room'];
        InboxItems newItem = InboxItems(
          id: data['id'].toString(),
          message: data['message'],
          first_id: data['sended_by']['id'].toString(),
          second_id: data['sended_to']['id'].toString(),
          time: data['timestamp'] ?? '',
          first_name: data['sended_by']['first_name'] ?? '',
          second_name: data['sended_to']['first_name'] ?? '',
          first_image: validateUrl(data['sended_by']['image']) ?? 'https://via.placeholder.com/400x200',
          second_image: validateUrl(data['sended_to']['image']) ?? 'https://via.placeholder.com/400x200',
          first_phone: data['sended_by']['username'] ?? '',
          second_phone: data['sended_to']['username'] ?? '',
        );

        if (mounted) {
          setState(() {
            if (_inboxData == null) {
              _inboxData = [];
            }
            int existingIndex = _inboxData!.indexWhere((item) => item.id == newItem.id);
            if (existingIndex != -1) {
              _inboxData![existingIndex] = newItem;
            } else {
              _inboxData!.insert(0, newItem);
            }
          });
        }
        _scrollToBottom();
      });
    } else {
      _showSnackBar('Token not found. Please login again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Conversations',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: _isLoading ? _buildShimmerList() : _buildInboxList(),
    );
  }

  Widget _buildInboxList() {
    if (_inboxData == null || _inboxData!.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: _inboxData!.length,
      itemBuilder: (context, index) {
        final conversation = _inboxData![index];
        bool isSelected = _selectedIndex == index;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey.withOpacity(0.1) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: ScaleTransition(
            scale: isSelected ? _scaleAnimation : const AlwaysStoppedAnimation(1.0),
            child: InkWell(
              onTapDown: (_) {
                setState(() => _selectedIndex = index);
                _animationController.forward();
              },
              onTapUp: (_) {
                _animationController.reverse();
                Future.delayed(Duration(milliseconds: 150), () {
                  _navigateToChat(conversation);
                });
              },
              onTapCancel: () {
                setState(() => _selectedIndex = null);
                _animationController.reverse();
              },
              child: _buildConversationTile(conversation),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConversationTile(InboxItems conversation) {
    final bool isFirstPerson = chatUserId == (conversation.first_id != null ? int.parse(conversation.first_id!) : null);
    final String displayName = isFirstPerson ? conversation.second_name : conversation.first_name;
    final String displayImage = isFirstPerson ? conversation.second_image ?? '' : conversation.first_image ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Hero(
            tag: 'avatar_${conversation.id}',
            child: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(displayImage),
              child: displayImage.isEmpty ? Icon(Icons.person, color: Colors.grey) : null,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  conversation.message ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDateTime(conversation.time),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToChat(InboxItems conversation) {
    final bool isFirstPerson = chatUserId == (conversation.first_id != null ? int.parse(conversation.first_id!) : null);
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeScaleTransition(
              animation: animation,
              child: ChatScreen(
                roomId: conversation.id,
                name: isFirstPerson ? conversation.second_name : conversation.first_name,
                imageUrl: isFirstPerson ? conversation.second_image ?? '' : conversation.first_image ?? '',
                chatUserId: chatUserId,
                number: conversation.first_phone,
              ),
            ),
      ),
    ).then((_) {
      setState(() => _selectedIndex = null);
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/nodata.json',
            height: 120.h,
            width: 120.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.h),
          Text(
            "No conversations yet",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Start chatting with someone!",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Colors.white,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120.w,
                      height: 14.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 200.w,
                      height: 12.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Container(
                width: 40.w,
                height: 12.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDateTime(String dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    return timeago.format(dateTime, allowFromNow: true);
  }

  static String? validateUrl(String? url) {
    const String baseUrl = 'http://13.203.36.158:8001/';

    if (url == null || url.isEmpty) {
      return null;
    }

    try {
      Uri uri = Uri.parse(url);
      if (!uri.hasScheme) {
        url = url.startsWith('/') ? url.substring(1) : url;
        url = baseUrl + url;
      }
      return url;
    } catch (e) {
      return null;
    }
  }
}
