import 'dart:async';
import 'package:flutter/material.dart';

class ImageSwiper extends StatefulWidget {
  final List<String> imageUrls;
  final bool autoSwipe;
  final int swipeIntervalSeconds;
  
  const ImageSwiper({
    Key? key,
    required this.imageUrls,
    this.autoSwipe = false,
    this.swipeIntervalSeconds = 3,
  }) : super(key: key);

  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });

    // Set up auto-swiping if enabled
    if (widget.autoSwipe) {
      _startAutoSwipe();
    }
  }

  void _startAutoSwipe() {
    _timer = Timer.periodic(Duration(seconds: widget.swipeIntervalSeconds), (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _pageController.animateToPage(
          _currentPage + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // Loop back to first page
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      height: 150,
      child: Stack(
        children: [
          // Image PageView
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 335,
              height: 130,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget.imageUrls[index],
                      width: 335,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 335,
                          height: 130,
                          color: Colors.grey[300],
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.image_not_supported, color: Colors.grey[600]),
                                const SizedBox(height: 8),
                                Text(
                                  'Image not found',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text(
                                  widget.imageUrls[index],
                                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Pagination indicators
          Positioned(
            top: 139,
            left: 131,
            child: SizedBox(
              width: 73,
              height: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageUrls.length, (index) {
                  return Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index 
                          ? const Color(0xFF0085FF)
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}