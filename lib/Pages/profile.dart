import 'package:flutter/material.dart';
import 'settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget _sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF61CEFFB8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/icon.png', 
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Profile & Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF101828),
                      fontFamily: 'poppins',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Account'),
                        ProfileItem(
                          tit: 'Abonso Hallon',
                          subtitle: 'Noire, 32 years old',
                          email: 'abonso@gmail.com',
                          hasImage: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
                            );
                          },
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          imagePath: 'assets/plan.png',
                          iconBgColor: Color(0xFFC9FFDB),
                          title: 'Your Current Plan',
                          subtitle: 'Premium, expires 08/12/2025 06:45',
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          imagePath: 'assets/pay_later.png',
                          iconBgColor: Color(0xFFC9FFDB),
                          title: 'Pay Later',
                          subtitle: '\$5,000 - your maximum health loan',
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          icon: Icons.shopping_bag_outlined,
                          iconBgColor: Color(0xFFE0F0E5),
                          iconColor: Colors.green,
                          title: 'My Orders',
                          subtitle: 'View or track your orders here',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Payments'),
                        SettingsItem(
                          imagePath: 'assets/payment.png',
                          iconBgColor: Color(0xFFFEE5A3),
                          title: 'Add payment method',
                          subtitle: 'Visa, mobile money, insurance...',
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          imagePath: 'assets/transaction.png',
                          iconBgColor: Color(0xFFE0F0E5),
                          title: 'Transaction History',
                          subtitle: 'view history',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Settings'),
                        SettingsItem(
                          icon: Icons.settings,
                          iconBgColor: const Color(0xFFECEDF0),
                          iconColor: Colors.black,
                          title: 'Settings',
                          subtitle: 'Notifications and more settings',
                            onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SettingsPage()),
                            );
                          },

                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          imagePath: 'assets/help.png',
                          iconBgColor: Color(0xFFEFE0FC),
                          title: 'Help & Support',
                          subtitle: 'Reach our customer care',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
                            );
                          },
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          imagePath: 'assets/terms.png',
                          iconBgColor: Color(0xFFFFF3DC),
                          title: 'Terms & Conditions',
                          subtitle: 'Read our terms of use',
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          icon: Icons.lock_outline,
                          iconBgColor: Color(0xFFD9E8FF),
                          iconColor: Colors.blue,
                          title: 'Privacy Policies',
                          subtitle: '',
                        ),
                        const Divider(height: 1, thickness: 1),
                        SettingsItem(
                          icon: Icons.logout,
                          iconBgColor: Color(0xFFFFE6E6),
                          iconColor: Colors.red,
                          title: 'Sign Out',
                          subtitle: 'Logout of your account',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String subtitle;
  final String email;
  final bool hasImage;
  final String tit;
  final VoidCallback? onTap;

  const ProfileItem({
    Key? key,
    required this.subtitle,
    required this.email,
    required this.tit,
    this.hasImage = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (hasImage)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tit,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                Text(
                  email,
                  style: TextStyle(color: const Color(0xFF667085), fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(15),
              child: const Icon(
                Icons.edit,
                color: Colors.blue,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final Color iconBgColor;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const SettingsItem({
    Key? key,
    this.icon,
    this.imagePath,
    required this.iconBgColor,
    this.iconColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: imagePath != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        imagePath!,
                        width: 24,
                        height: 24,
                      ),
                    )
                  : Icon(
                      icon,
                      size: 20,
                      color: iconColor,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xFF252A31),
                      fontFamily: 'poppins',
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: const Color(0xFF667085), fontSize: 13, fontFamily: 'poppins'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF61CEFFB8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/icon.png', 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101010)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.orange,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: EditableField(label: 'First Name', initialValue: 'Abonso'),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: EditableField(label: 'Last Name', initialValue: 'Hallon'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    EditableField(label: 'Date of Birth', initialValue: '19/04/1990'),
                    const SizedBox(height: 16),
                    EditableField(label: 'Phone', initialValue: '+352 700-341-609'),
                    const SizedBox(height: 16),
                    EditableField(label: 'Email', initialValue: 'abonso@gmail.com'),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditableField extends StatelessWidget {
  final String label;
  final String initialValue;

  const EditableField({
    Key? key,
    required this.label,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF61CEFFB8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 30,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/icon.png', 
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    const Text(
                      'Help Center',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                        fontFamily: 'GT Walsheim Pro',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello, how can we help you?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    HelpCenterItem(
                      imagePath: 'assets/inquire.png',
                      title: 'General Inquiries',
                      subtitle: 'Basic questions about NextDoc',
                    ),
                    const SizedBox(height: 12),
                    HelpCenterItem(
                      imagePath: 'assets/one.png',
                      title: 'Payments & Transactions',
                      subtitle: 'Basic questions about NextDoc',
                    ),
                    const SizedBox(height: 12),
                    HelpCenterItem(
                      imagePath: 'assets/two.png',
                      title: 'General Inquiries',
                      subtitle: 'Basic questions about NextDoc',
                    ),
                    const SizedBox(height: 12),
                    HelpCenterItem(
                      imagePath: 'assets/three.png',
                      title: 'Emergency',
                      subtitle: 'Help in an emergency',
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpCenterItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const HelpCenterItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: const Color(0xFF979797), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}