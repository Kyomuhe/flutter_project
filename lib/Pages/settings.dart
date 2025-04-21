import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pushNotificationEnabled = false;
  bool locationEnabled = true;
  String selectedLanguage = 'English (US)';
  String tempSelectedLanguage = 'English (US)'; 

  void _showLanguageBottomSheet() {
    // Set temporary selection to current selection when opening
    tempSelectedLanguage = selectedLanguage;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              height: MediaQuery.of(context).size.height * 0.65,
              child: LanguageSelectionSheet(
                currentLanguage: tempSelectedLanguage,
                onLanguageSelected: (language) {
                  setState(() {
                    tempSelectedLanguage = language;
                  });
                },
                onConfirm: () {
                  this.setState(() {
                    selectedLanguage = tempSelectedLanguage;
                  });
                  Navigator.pop(context);
                },
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: Text(
              'PROFILE',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Push Notification'),
                  trailing: Switch(
                    value: pushNotificationEnabled,
                    onChanged: (value) {
                      setState(() {
                        pushNotificationEnabled = value;
                      });
                    },
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                  ),
                ),
                ListTile(
                  title: const Text('Location'),
                  trailing: Switch(
                    value: locationEnabled,
                    onChanged: (value) {
                      setState(() {
                        locationEnabled = value;
                      });
                    },
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey.shade300,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.blue,
                  ),
                ),
                ListTile(
                  title: const Text('Language'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedLanguage.split(' ')[0], 
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    ],
                  ),
                  onTap: _showLanguageBottomSheet,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 24, bottom: 8),
            child: Text(
              'OTHER',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageSelectionSheet extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageSelected;
  final VoidCallback onConfirm;

  const LanguageSelectionSheet({
    Key? key,
    required this.currentLanguage,
    required this.onLanguageSelected,
    required this.onConfirm,
  }) : super(key: key);

  Widget _buildLanguageOption(BuildContext context, String language, String flag) {
    final isSelected = language == currentLanguage;
    
    return GestureDetector(
      onTap: () => onLanguageSelected(language),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : const Color(0xFFEAEAEA),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 12),
              Text(
                language,
                style: const TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.blue, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
            margin: const EdgeInsets.only(top: 12, bottom: 20),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildLanguageOption(context, 'Kiswahili', '🇹🇿'),
                _buildLanguageOption(context, 'English (US)', '🇺🇸'),
                _buildLanguageOption(context, 'Luganda', '🇺🇬'),
                _buildLanguageOption(context, 'Runyankore', '🇺🇬'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Select',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}