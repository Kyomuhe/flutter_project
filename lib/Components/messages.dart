import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      debugShowCheckedModeBanner: false,
      home: const ChatScreen(),
    );
  }
}

class Message {
  final String text;
  final bool isMe;
  final DateTime time;
  final String? imagePath;
  final String? voiceNoteDuration;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.imagePath,
    this.voiceNoteDuration,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [
    Message(
      text: "Did you change your diet or have something unhealthy that might have caused a problem.",
      isMe: false,
      time: DateTime(2025, 4, 11, 10, 30),
    ),
    Message(
      text: "I've not been feeling well for the past few days, I've been",
      isMe: true,
      time: DateTime(2025, 4, 11, 10, 41),
    ),
    Message(
      text: "I've not been feeling well for the past few days, I've been",
      isMe: true,
      time: DateTime(2025, 4, 11, 10, 41),
    ),
    Message(
      text: "Did you change your diet or have something unhealthy",
      isMe: false,
      time: DateTime(2025, 4, 11, 11, 43),
    ),
    Message(
      text: "ate food from the stalls",
      isMe: true,
      time: DateTime(2025, 4, 11, 11, 44),
    ),
    Message(
      text: "IMG_0483.PNG\n2.83 MB",
      isMe: true,
      time: DateTime(2025, 4, 11, 11, 51),
      imagePath: "assets/food_image.png",
    ),
    Message(
      text: "",
      isMe: false,
      time: DateTime(2025, 4, 11, 12, 31),
      voiceNoteDuration: "00:13:12",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: _buildChatArea(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // Action sheet
void _showAttachmentOptions() {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => Container(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFC6C6C8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: CupertinoActionSheet(
          actions: <Widget>[
            _buildActionSheetItem(Icons.camera_alt_outlined, 'Camera', Colors.blue),
            _buildActionSheetItem(Icons.photo_library_outlined, 'Photo or Video Library', Colors.blue),
            _buildActionSheetItem(Icons.insert_drive_file_outlined, 'Document(s)', Colors.blue),
            _buildActionSheetItem(Icons.location_on_outlined, 'Share location', Colors.blue),
            _buildActionSheetItem(Icons.person_outline_rounded, 'Contact', Colors.blue),
          ],
          cancelButton: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: CupertinoActionSheetAction(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    ),
  );
}
Widget _buildActionSheetItem(IconData icon, String text, Color iconColor) {
  return CupertinoActionSheetAction(
    child: Row(
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 15),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ],
    ),
    onPressed: () {
      Navigator.pop(context);
      // Handle specific action based on selection
    },
  );
}  

Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBEB),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage('assets/profile1.png'), 
                fit: BoxFit.cover,
              ),
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Dr. Garande Hassan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Neurologist',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Icon(Icons.phone, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return Container(
      color: Colors.grey.shade100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: messages.length + 1, // +1 for the "Now" divider
        itemBuilder: (context, index) {
          if (index == 4) {
            return _buildTimeMarker("Now");
          }
          
          final actualIndex = index > 4 ? index - 1 : index;
          final message = messages[actualIndex];
          
          return _buildMessageBubble(message);
        },
      ),
    );
  }

  Widget _buildTimeMarker(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider( color: Colors.grey),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all( color:Colors.grey),
            ),
            child: Text(
              text,
              style: TextStyle( color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final time = DateFormat('HH:mm').format(message.time);
    final isMe = message.isMe;
    
    Widget messageContent;
    
    if (message.imagePath != null) {
      messageContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(message.imagePath!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.text,
            style: TextStyle(
              color: isMe ? Colors.white.withOpacity(0.9) : Colors.black87,
              fontSize: 13,
            ),
          ),
        ],
      );
    } else if (message.voiceNoteDuration != null) {
      messageContent = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, color: isMe ? Colors.blue : Colors.grey.shade400),        

          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 4,
              color: isMe ? Colors.white.withOpacity(0.5) : Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            message.voiceNoteDuration!,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
            ),
          ),
        ],
      );
    } else {
      messageContent = Text(
        message.text,
        style: TextStyle(
          color: isMe ? Colors.white : Colors.black87,
          fontSize: 14,
        ),
      );
    }

    if (!isMe) {
      // Doctor's message with profile pic and speech bubble pointer
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile pic for doctor's messages
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8, top: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/profile1.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
            ),
            
            // Message bubble with triangle pointer
            Flexible(
              child: Stack(
                children: [
                  // Triangle pointer to profile pic
                  Positioned(
                    left: -6,
                    top: 12,
                    child: CustomPaint(
                      size: const Size(10, 10),
                      painter: TrianglePainter(
                        color: const Color(0xFFEEEBEB),
                      ),
                    ),
                  ),
                  
                  // Message bubble
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEBEB),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        messageContent,
                        const SizedBox(height: 4),
                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // User's message (right-aligned blue bubble)
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              messageContent,
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'start typing...',
                        hintStyle: TextStyle(color: Colors.blue),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.send, color: Colors.blue, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
            ),
            child: const Icon(Icons.mic, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the triangle pointer
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}