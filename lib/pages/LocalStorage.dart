import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For simple key-value storage
import 'package:path_provider/path_provider.dart'; // For file storage
import 'package:sqflite/sqflite.dart'; // For SQLite database
import 'package:path/path.dart' as path; // For path operations
import 'dart:io';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this for async operations in main
  runApp(const LocalStorage());
}

class LocalStorage extends StatelessWidget {
  const LocalStorage({super.key}); // Updated to use super.key

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Local Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Added Material 3 for modern look
      ),
      home: const LocalStorageExample(),
    );
  }
}

class LocalStorageExample extends StatefulWidget {
  const LocalStorageExample({super.key}); // Updated to use super.key

  @override
  State<LocalStorageExample> createState() => _LocalStorageExampleState();
}

class _LocalStorageExampleState extends State<LocalStorageExample> {
  // Controllers
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  
  // Values to display
  String _savedPreference = "No data yet";
  List<Map<String, dynamic>> _notes = [];
  String _fileContent = "No file content yet";
  
  @override
  void initState() {
    super.initState();
    _loadSavedPreference();
    _loadNotes();
    _loadFileContent();
  }
  
  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // SECTION 1: SHARED PREFERENCES (Key-Value Storage)
  Future<void> _saveUsingSharedPreferences() async {
    if (_keyController.text.isEmpty || _valueController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both key and value')),
      );
      return;
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyController.text, _valueController.text);
    
    _loadSavedPreference();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to SharedPreferences')),
    );
  }
  
  Future<void> _loadSavedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_keyController.text.isNotEmpty && prefs.containsKey(_keyController.text)) {
        _savedPreference = prefs.getString(_keyController.text) ?? "No data found";
      } else {
        _savedPreference = "Enter a key and value to save data";
      }
    });
  }
  
  // SECTION 2: FILE STORAGE
  Future<void> _saveToFile() async {
    if (_valueController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a value to save')),
      );
      return;
    }
    
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      await file.writeAsString(_valueController.text);
      
      _loadFileContent();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to file')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving file: $e')),
      );
    }
  }
  
  Future<void> _loadFileContent() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/my_file.txt');
      
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _fileContent = content;
        });
      } else {
        setState(() {
          _fileContent = "File doesn't exist yet. Save something first.";
        });
      }
    } catch (e) {
      setState(() {
        _fileContent = "Error reading file: $e";
      });
    }
  }
  
  // SECTION 3: SQLite DATABASE
  Future<Database> _getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, 'notes_database.db'); // Fixed path import usage
    
    return openDatabase(
      dbPath,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, timestamp TEXT)',
        );
      },
      version: 1,
    );
  }
  
  Future<void> _saveNote() async {
    if (_noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a note to save')),
      );
      return;
    }
    
    try {
      final db = await _getDatabase();
      
      await db.insert(
        'notes',
        {
          'content': _noteController.text,
          'timestamp': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace, // Added conflict handling
      );
      
      _noteController.clear();
      _loadNotes();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note saved to database')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving note: $e')),
      );
    }
  }
  
  Future<void> _loadNotes() async {
    try {
      final db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(
        'notes', 
        orderBy: 'timestamp DESC', 
        limit: 5
      );
      
      setState(() {
        _notes = List<Map<String, dynamic>>.from(maps); // Properly create a new list
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading notes: $e')),
      );
    }
  }
  
  Future<void> _deleteNote(int id) async {
    try {
      final db = await _getDatabase();
      await db.delete(
        'notes',
        where: 'id = ?',
        whereArgs: [id],
      );
      
      _loadNotes();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting note: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Local Storage'),
        elevation: 2, // Added elevation for visual separation
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Shared Preferences Section
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('1. Shared Preferences (Key-Value Storage)', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _keyController,
                decoration: const InputDecoration(
                  labelText: 'Key',
                  border: OutlineInputBorder(),
                  hintText: 'Enter storage key',
                ),
                onChanged: (_) => _loadSavedPreference(), // Load value when key changes
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(),
                  hintText: 'Enter value to store',
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveUsingSharedPreferences,
                child: const Text('Save to SharedPreferences'),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Saved value: $_savedPreference'),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // File Storage Section
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('2. File Storage', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveToFile,
                child: const Text('Save to File'),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('File content: $_fileContent'),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // SQLite Database Section
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('3. SQLite Database', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Note Content',
                  border: OutlineInputBorder(),
                  hintText: 'Enter note to save in database',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Save Note to Database'),
              ),
              const SizedBox(height: 16),
              const Text('Recent Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
              _notes.isEmpty 
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No notes saved yet'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _notes.length,
                    itemBuilder: (context, index) {
                      final formatDate = DateTime.parse(_notes[index]['timestamp']).toString().substring(0, 16);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(_notes[index]['content']),
                          subtitle: Text('Created: $formatDate'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteNote(_notes[index]['id']),
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}