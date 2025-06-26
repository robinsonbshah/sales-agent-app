import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

final Map<String, int> _caseToBottle = {
  '250ml': 24,
  '500ml': 12,
  '1L': 6,
  '2L': 6,
};

final DateTime pjpStartDate = DateTime(
  2024,
  6,
  1,
); // Set your desired start date here

int getRouteIndexForDate(
  DateTime selectedDate,
  int numRoutes,
  DateTime startDate,
) {
  final daysSinceStart = selectedDate.difference(startDate).inDays;
  if (numRoutes == 0) return 0;
  return daysSinceStart % numRoutes;
}

// Remove the stray PJPPage(
//   group1: 'Sarangi',
//   group2: 'Seto Bagh',
//   sizes: const ['250ml', '500ml', '1L', '2L'],
// )

class _PJPPageState extends State<PJPPage> {
  NepaliDateTime selectedDate = NepaliDateTime.now();
  final TextEditingController _remarksController = TextEditingController();
  final Map<String, TextEditingController> _casesControllers = {};
  final Map<String, TextEditingController> _bottlesControllers = {};
  String? _currentlyEditing;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<Map<String, dynamic>> get userRoutes {
    final routes = List<Map<String, dynamic>>.from(
      nimeshProfile['routes'] ?? [],
    );
    if (routes.isEmpty) {
      return [
        {'routeId': 1, 'routeName': 'Route 1'},
        {'routeId': 2, 'routeName': 'Route 2'},
        {'routeId': 3, 'routeName': 'Route 3'},
      ];
    }
    return routes;
  }

  int get numRoutes => userRoutes.length;

  int get routeIndexForDate {
    final date = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    return getRouteIndexForDate(date, numRoutes, pjpStartDate);
  }

  Map<String, dynamic>? get currentRoute {
    if (userRoutes.isEmpty) return null;
    return userRoutes[routeIndexForDate];
  }

  String get routeName => currentRoute?['routeName'] ?? 'Route';
  int? get routeId => currentRoute?['routeId'];

  List<Map<String, dynamic>> get allCurrentRouteOutlets {
    if (routeId == null) return [];
    return List<Map<String, dynamic>>.from(
      nimeshProfile['outlets'] ?? [],
    ).where((o) => o['routeId'] == routeId).toList();
  }

  String get dateKey {
    final d = selectedDate;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  List<Map<String, dynamic>> get todaysPJPOutlets {
    final manualNames = manuallyAddedOutlets[dateKey] ?? [];
    final all = [...allCurrentRouteOutlets];
    all.addAll(
      List<Map<String, dynamic>>.from(
        nimeshProfile['outlets'] ?? [],
      ).where((o) => manualNames.contains(o['name'])),
    );
    return all;
  }

  bool isCurrentRouteOutlet(String outletName) {
    return allCurrentRouteOutlets.any((o) => o['name'] == outletName);
  }

  void onDateChanged(NepaliDateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  // ... rest of the code remains unchanged ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(routeName)),
      body: Column(
        children: [
          Text(
            routeName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todaysPJPOutlets.length,
              itemBuilder: (context, index) {
                final outlet = todaysPJPOutlets[index];
                return null;
                // ... rest of the outlet card code ...
              },
            ),
          ),
        ],
      ),
    );
  }
}

String _daysAgoString(Object? dateStr) {
  if (dateStr == null) return '';
  final date = DateTime.parse(dateStr as String);
  final now = DateTime.now();
  final diff = now.difference(date).inDays;
  if (diff == 0) return 'today';
  if (diff == 1) return '1 day ago';
  if (diff > 1) return '$diff days ago';
  return '';
}
