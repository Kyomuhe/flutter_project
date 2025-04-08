import 'package:flutter/material.dart';

class NCareExpertContact extends StatelessWidget {
  final String expertImagePath;
  final String callIconPath;
  final String chatIconPath;
  final VoidCallback onCallPressed;
  final VoidCallback onChatPressed;
  
  const NCareExpertContact({
    Key? key,
    required this.expertImagePath,
    required this.callIconPath,
    required this.chatIconPath,
    required this.onCallPressed,
    required this.onChatPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main container with image and text
        Container(
          height: 66,
          child: Row(
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(expertImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Text content (right side)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title text
                  Container(
                    height: 21,
                    child: const Text(
                      'Talk to Ncare experts to book tests',
                      style: TextStyle(
                        color: const Color(0xFF272727),
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Description text
                  Container(
                    width: 243,
                    height: 30,
                    child: const Text(
                      'You will be connected with Ncare expert on call to book tests.',
                      style: TextStyle(
                        color: const Color(0xFF5E5E5E),
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 145,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF0085FF),
                  width: 1.5,
                ),
              ),
              child: TextButton(
                onPressed: onCallPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      callIconPath,
                      width: 16,
                      height: 16,
                      color: const Color(0xFF0085FF),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Call now',
                      style: TextStyle(
                        color: Color(0xFF0085FF),
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Chat now button (blue filled)
            Container(
              width: 145,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF0085FF),
              ),
              child: TextButton(
                onPressed: onChatPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      chatIconPath,
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Chat now',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 14,
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
    );
  }
}