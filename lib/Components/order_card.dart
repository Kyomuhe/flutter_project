import 'package:flutter/material.dart';

class PrescriptionOrderCard extends StatelessWidget {
  final String leftImagePath;
  final String uploadIconPath;
  final VoidCallback onUploadPressed;
  
  const PrescriptionOrderCard({
    Key? key,
    required this.leftImagePath,
    required this.uploadIconPath,
    required this.onUploadPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFFFD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF0085FF),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Left side image
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: 59,
              height: 56,
              child: Image.asset(
                leftImagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.medical_services_outlined,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),
          
          // Right side content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Order with prescription text
                  const SizedBox(
                    height: 21,
                    child: Text(
                      'Order with prescription',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF202244),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Description text
                  const SizedBox(
                    height: 11,
                    child: Text(
                      'Upload prescription and we will deliver your medicines',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        color: Color(0xFF667085),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Upload button
                  SizedBox(
                    width: 82,
                    height: 23,
                    child: ElevatedButton(
                      onPressed: onUploadPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0085FF),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Upload icon
                          Image.asset(
                            uploadIconPath,
                            width: 12,
                            height: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          // Upload text
                          const Text(
                            'Upload',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}