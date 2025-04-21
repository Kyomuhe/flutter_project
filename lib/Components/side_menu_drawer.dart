import 'package:flutter/material.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of all menu items with their icons, titles, and background colors
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": "menu1", 
        "title": "Baby care",
        "color": const Color(0xFF96EEFF)
      },
      {
        "icon": "menu2", 
        "title": "Sexual Health",
        "color": const Color(0xFFA8FFA8)
      },
      {
        "icon": "menu3", 
        "title": "Cold and Allergies",
        "color": const Color(0xFFDCC3FF)
      },
      {
        "icon": "menu4", 
        "title": "Women's Health",
        "color": const Color(0xFFFFE6E6)
      },
      {
        "icon": "menu5", 
        "title": "Vitamins and Supplements",
        "color": const Color(0xFFFFD996)
      },
      {
        "icon": "menu6", 
        "title": "Personal Care",
        "color": const Color(0xFFB7B2FF)
      },
      {
        "icon": "menu7", 
        "title": "First Aid",
        "color": const Color(0xFFE6A7EC)
      },
      {
        "icon": "menu8", 
        "title": "Skin Care",
        "color": const Color(0xFFC9A8EF)
      },
      {
        "icon": "menu9", 
        "title": "Oral Care",
        "color": const Color(0xFFA8FFA8)
      },
      {
        "icon": "menu10", 
        "title": "Sleep Aids",
        "color": const Color(0xFFFFC3C4)
      },
      {
        "icon": "menu11", 
        "title": "Infections & Antibiotics",
        "color": const Color(0xFFFFD996)
      },
      {
        "icon": "menu12", 
        "title": "Herbal & Natural Remedies",
        "color": const Color(0xFFE6A7EC)
      },
      {
        "icon": "menu13", 
        "title": "Herbal & Natural Remedies",
        "color": const Color(0xFF96EEFF)
      },
    ];

    return Container(
      width: 272,
      height: 786.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 272,
            height: 56,
            color: const Color(0xFF0085FF),
            alignment: Alignment.center,
            child: const Text(
              "Shop by Categories",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero, // Remove default padding
              itemCount: menuItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1, thickness: 0.5),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 54, // Fixed height for each menu item
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 38.5,
                          height: 38.5,
                          decoration: BoxDecoration(
                            color: menuItems[index]["color"],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/${menuItems[index]["icon"]}.png',
                              width: 18.35,
                              height: 19.25,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            menuItems[index]["title"],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF555555),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}