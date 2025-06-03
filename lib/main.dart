import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    // Mock data
    final String userName = 'Ram Bahadur';
    final String nepaliDate = '2081-02-20';
    final String attendanceStatus = 'Checked In at 9:05 AM';
    final IconData attendanceIcon = Icons.check_circle_outline;
    final List<Map<String, String>> pjpTasks = [
      {'title': 'Visit: Shree Store', 'subtitle': '10:00 AM'},
      {'title': 'Order: Himalayan Mart', 'subtitle': '12:30 PM'},
      {'title': 'Follow-up: Bhatbhateni', 'subtitle': '3:00 PM'},
    ];
    final int presentDays = 18;
    final int totalOrders = 42;
    final int target = 50;
    final int achieved = 42;
    final List<Map<String, String>> notifications = [
      {'title': 'New Scheme!', 'body': 'Earn double points this week.'},
      {'title': 'Meeting', 'body': 'Team meeting at 5 PM today.'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Namaste, $userName',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Today's Nepali Date: $nepaliDate",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              // Attendance Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: ListTile(
                  leading: Icon(attendanceIcon, color: Colors.green, size: 36),
                  title: const Text('Attendance'),
                  subtitle: Text(attendanceStatus),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // PJP/Tasks Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.list_alt, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Today\'s Tasks',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...pjpTasks
                          .take(3)
                          .map(
                            (task) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(task['title']!),
                              subtitle: Text(task['subtitle']!),
                              leading: const Icon(
                                Icons.check_box_outline_blank,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Performance Summary Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _SummaryItem(
                        label: 'Present Days',
                        value: presentDays.toString(),
                        icon: Icons.calendar_today,
                      ),
                      _SummaryItem(
                        label: 'Orders',
                        value: totalOrders.toString(),
                        icon: Icons.shopping_cart,
                      ),
                      _SummaryItem(
                        label: 'Target',
                        value: '$achieved/$target',
                        icon: Icons.flag,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuickActionButton(icon: Icons.login, label: 'Check In'),
                  _QuickActionButton(icon: Icons.store, label: 'Outlets'),
                  _QuickActionButton(icon: Icons.bar_chart, label: 'Reports'),
                ],
              ),
              const SizedBox(height: 24),
              // Notifications Section
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ...notifications
                  .take(2)
                  .map(
                    (notice) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.yellow[50],
                      child: ListTile(
                        leading: const Icon(
                          Icons.notifications,
                          color: Colors.orange,
                        ),
                        title: Text(notice['title']!),
                        subtitle: Text(notice['body']!),
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[50],
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
