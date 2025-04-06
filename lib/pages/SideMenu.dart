import 'package:flutter/material.dart';
import 'Widget.dart'; 
import 'Animation.dart';
import 'Form.dart';
import 'LocalStorage.dart';
import 'Fire_Base.dart';
import 'Theming.dart';
import 'Notification.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Flutter Topics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'My Research',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.widgets),
            title: Text('Flutter Widgets'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlutterWidgetsPage()),
              );
            },
            
          ),
          ListTile(
            leading: Icon(Icons.animation),
            title: Text('Animations'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FlutterAnimationsPage()),

              );
            },
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('Inputs and Forms'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormPage()),

              );
            },
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Local Storage'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocalStorage()),
              );

            },
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Firebase'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirebaseGuideApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.format_paint),
            title: Text('Theming'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ThemingPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Push Notifications'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PushNotificationApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text('Custom Widgets'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation code here when ready
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Deployment'),
            onTap: () {
              Navigator.pop(context);
              // Add navigation code here when ready
            },
          ),
        ],
      ),
    );
  }
}