import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A simple model class
class Task {
  final String id;
  final String title;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// StateNotifier to manage task list state
class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([
    Task(id: '1', title: 'Learn Riverpod'),
    Task(id: '2', title: 'Create a demo app'),
    Task(id: '3', title: 'Present to supervisor'),
  ]);

  void addTask(String title) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    state = [...state, newTask];
  }

  void toggleTaskCompletion(String taskId) {
    state = state.map((task) {
      if (task.id == taskId) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
  }

  void removeTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }
}

// A simple counter for StateProvider example
final counterProvider = StateProvider<int>((ref) => 0);

// Provider for a static value
final appTitleProvider = Provider<String>((ref) => 'Riverpod Demo');

// StateNotifierProvider for tasks
final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

// Provider that depends on tasksProvider (derived state)
final completedTaskCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider);
  return tasks.where((task) => task.isCompleted).length;
});

// Provider that depends on tasksProvider (derived state)
final pendingTaskCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider);
  return tasks.where((task) => !task.isCompleted).length;
});

// FutureProvider with parameter to change data
final weatherProvider = FutureProvider.family<String, String>((ref, city) async {
  // Simulate network request for weather data
  await Future.delayed(const Duration(seconds: 2));
  
  // Return different data based on city
  switch (city.toLowerCase()) {
    case 'london':
      return 'Cloudy, 15°C';
    case 'new york':
      return 'Sunny, 22°C';
    case 'tokyo':
      return 'Rainy, 18°C';
    case 'sydney':
      return 'Windy, 24°C';
    default:
      return 'Weather data not available';
  }
});

void main() {
  runApp(
    // ProviderScope enables Riverpod for the entire app
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTitle = ref.watch(appTitleProvider);

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTitle = ref.watch(appTitleProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riverpod Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            
            // Counter Example (StateProvider)
            const CounterWidget(),
            const Divider(height: 32),
            
            // Task List Example (StateNotifierProvider)
            const TaskListWidget(),
            const Divider(height: 32),
            
            // FutureProvider Example
            const AsyncDataWidget(),
          ],
        ),
      ),
    );
  }
}

// Example 1: Simple Counter with StateProvider
class CounterWidget extends ConsumerWidget {
  const CounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the counter state
    final count = ref.watch(counterProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'StateProvider Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Simple counter state management:'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).state--,
                  child: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '$count',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterProvider.notifier).state++,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Example 2: Task List with StateNotifierProvider
class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the tasks state
    final tasks = ref.watch(tasksProvider);
    final completedCount = ref.watch(completedTaskCountProvider);
    final pendingCount = ref.watch(pendingTaskCountProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'StateNotifierProvider Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Task list with derived state:'),
            const SizedBox(height: 8),
            
            // Task Stats
            Row(
              children: [
                Chip(
                  label: Text('Pending: $pendingCount'),
                  backgroundColor: Colors.orange.shade100,
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('Completed: $completedCount'),
                  backgroundColor: Colors.green.shade100,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Task List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) {
                      ref.read(tasksProvider.notifier).toggleTaskCompletion(task.id);
                    },
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(tasksProvider.notifier).removeTask(task.id);
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            
            // Add Task Button
            AddTaskWidget(),
          ],
        ),
      ),
    );
  }
}

// Widget to add new tasks
class AddTaskWidget extends ConsumerStatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends ConsumerState<AddTaskWidget> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_textController.text.isNotEmpty) {
      ref.read(tasksProvider.notifier).addTask(_textController.text);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter a new task',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _addTask(),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _addTask,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

// Example 3: FutureProvider for async data
class AsyncDataWidget extends ConsumerStatefulWidget {
  const AsyncDataWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<AsyncDataWidget> createState() => _AsyncDataWidgetState();
}

class _AsyncDataWidgetState extends ConsumerState<AsyncDataWidget> {
  String selectedCity = 'London';
  final List<String> cities = ['London', 'New York', 'Tokyo', 'Sydney'];

  @override
  Widget build(BuildContext context) {
    // Watch the async state with the selected city
    final weatherData = ref.watch(weatherProvider(selectedCity));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FutureProvider.family Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Weather data with async loading:'),
            const SizedBox(height: 16),
            
            // City selection dropdown
            DropdownButton<String>(
              value: selectedCity,
              isExpanded: true,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCity = newValue;
                  });
                }
              },
              items: cities.map<DropdownMenuItem<String>>((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 24),
            
            // Weather data display
            Center(
              child: weatherData.when(
                data: (data) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getWeatherIcon(data),
                          color: _getWeatherColor(data),
                          size: 48,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          data,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(weatherProvider(selectedCity)),
                      child: const Text('Refresh Weather'),
                    ),
                  ],
                ),
                loading: () => const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Loading weather data...'),
                  ],
                ),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String weather) {
    if (weather.contains('Sunny')) {
      return Icons.wb_sunny;
    } else if (weather.contains('Cloudy')) {
      return Icons.cloud;
    } else if (weather.contains('Rainy')) {
      return Icons.beach_access; // Umbrella icon
    } else if (weather.contains('Windy')) {
      return Icons.air;
    } else {
      return Icons.question_mark;
    }
  }

  Color _getWeatherColor(String weather) {
    if (weather.contains('Sunny')) {
      return Colors.orange;
    } else if (weather.contains('Cloudy')) {
      return Colors.grey;
    } else if (weather.contains('Rainy')) {
      return Colors.blue;
    } else if (weather.contains('Windy')) {
      return Colors.cyan;
    } else {
      return Colors.black;
    }
  }
}