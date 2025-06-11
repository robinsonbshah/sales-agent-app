import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a constant for the background color
const Color kAppBgColor = Color(0xFFEFEBC5);

void main() {
  NepaliUtils(Language.nepali);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Agent App',
      theme: ThemeData(
        fontFamily: 'Aeonik',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w400,
          ),
          bodySmall: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w400,
          ),
          titleLarge: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
          titleMedium: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
          titleSmall: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: const TextStyle(
            fontFamily: 'Aeonik',
            fontWeight: FontWeight.w700,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: kAppBgColor,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _errorMessage;

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == 'aaa' &&
          _passwordController.text == 'aaa') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavBar()),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter username'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter password'
                            : null,
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _selectedIndex = 2; // Check In is default

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    PJPPage(),
    CheckInPage(),
    OutletsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'PJP',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withAlpha((0.3 * 255).toInt()),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.fingerprint, color: Colors.white, size: 36),
            ),
            label: 'Check In',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Outlets',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final String userName = nimeshProfile['fullName'];
  bool isCheckedIn = false;
  bool isCheckedOut = false;
  String? checkInTime;
  String? checkOutTime;

  List<Map<String, dynamic>> get recentActivity {
    final today = NepaliDateTime.now();
    final int daysSinceSunday = today.weekday % 7;
    final NepaliDateTime sunday = today.subtract(
      Duration(days: daysSinceSunday),
    );
    return List.generate(7, (i) {
      final date = sunday.add(Duration(days: i));
      final isPresent = i % 2 == 0;
      return {
        'date': NepaliDateFormat('yyyy-MM-dd', Language.english).format(date),
        'status': isPresent ? 'Present' : 'Absent',
        'hours': isPresent ? 8 : 0,
        'icon': isPresent ? Icons.check_circle : Icons.cancel,
        'color': isPresent ? Colors.green : Colors.red,
      };
    }).reversed.toList();
  }

  void _handleCheckInOut() {
    setState(() {
      if (!isCheckedIn) {
        // Check In
        isCheckedIn = true;
        isCheckedOut = false;
        checkInTime = '09:00 AM'; // mock
        checkOutTime = null;
      } else if (!isCheckedOut) {
        // Check Out
        isCheckedOut = true;
        checkOutTime = '05:10 PM'; // mock
      } else {
        // Reset for demo (allow repeated toggling)
        isCheckedIn = false;
        isCheckedOut = false;
        checkInTime = null;
        checkOutTime = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;
    IconData statusIcon;
    String subtitleText;
    String buttonLabel;
    Color buttonColor;
    IconData buttonIcon;

    if (!isCheckedIn) {
      statusText = 'Not Checked In';
      statusColor = Colors.red;
      statusIcon = Icons.info;
      subtitleText = 'You have not checked in yet';
      buttonLabel = 'Check In';
      buttonColor = Colors.green;
      buttonIcon = Icons.fingerprint;
    } else if (isCheckedIn && !isCheckedOut) {
      statusText = 'Checked In';
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
      subtitleText = 'Checked In at $checkInTime';
      buttonLabel = 'Check Out';
      buttonColor = Colors.red;
      buttonIcon = Icons.logout;
    } else {
      statusText = 'Checked Out';
      statusColor = Colors.red;
      statusIcon = Icons.logout;
      subtitleText = 'Checked Out at $checkOutTime';
      buttonLabel = 'Check In';
      buttonColor = Colors.green;
      buttonIcon = Icons.fingerprint;
    }

    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Check In',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.orange),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Afternoon,\n$userName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.black),
                const SizedBox(width: 6),
                Builder(
                  builder: (context) {
                    final nepaliDate = NepaliDateTime.now();
                    final dayNames = [
                      'Sunday',
                      'Monday',
                      'Tuesday',
                      'Wednesday',
                      'Thursday',
                      'Friday',
                      'Saturday',
                    ];
                    final dayName = dayNames[nepaliDate.weekday % 7];
                    final formattedDate = NepaliDateFormat(
                      'dd-MMMM-yyyy',
                      Language.english,
                    ).format(nepaliDate);
                    return Text(
                      '$dayName, $formattedDate',
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitleText,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _handleCheckInOut,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: buttonColor,
                      child: Icon(buttonIcon, color: Colors.white, size: 48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    buttonLabel,
                    style: TextStyle(
                      fontSize: 20,
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceHistoryPage(),
                        ),
                      );
                    },
                    child: Column(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Color(0xFFFFF3E0),
                          child: Icon(Icons.access_alarm, color: Colors.orange),
                        ),
                        SizedBox(height: 4),
                        Text('Attendance', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Activity',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...recentActivity.map(
              (activity) => Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        activity['icon'],
                        color: activity['color'],
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(
                              builder: (context) {
                                final nepaliDate = NepaliDateTime.parse(
                                  activity['date'],
                                );
                                final formattedDate = NepaliDateFormat(
                                  'dd-MMMM-yyyy',
                                  Language.english,
                                ).format(nepaliDate);
                                return Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Status: ${activity['status']} | Hours: ${activity['hours']}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceHistoryPage extends StatelessWidget {
  AttendanceHistoryPage({super.key});

  final List<Map<String, dynamic>> attendanceHistory = [
    {
      'date': '2082-02-20',
      'status': 'Present',
      'checkIn': '09:15',
      'checkOut': '17:30',
      'hours': 8,
      'minutes': 15,
    },
    {
      'date': '2082-02-19',
      'status': 'Absent',
      'checkIn': '',
      'checkOut': '',
      'hours': 0,
      'minutes': 0,
    },
    {
      'date': '2082-02-18',
      'status': 'Present',
      'checkIn': '09:10',
      'checkOut': '17:20',
      'hours': 7,
      'minutes': 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      backgroundColor: kAppBgColor,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: attendanceHistory.length,
        itemBuilder: (context, index) {
          final item = attendanceHistory[index];
          final isPresent = item['status'] == 'Present';
          String hoursMinutes = '${item['hours']}h';
          if ((item['minutes'] ?? 0) > 0) {
            hoursMinutes += ' ${item['minutes']}m';
          }
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ExpansionTile(
              leading: Icon(
                isPresent ? Icons.check_circle : Icons.cancel,
                color: isPresent ? Colors.green : Colors.red,
              ),
              title: Text(
                NepaliDateFormat(
                  'dd-MMMM-yyyy',
                  Language.english,
                ).format(NepaliDateTime.parse(item['date'])),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                isPresent ? 'Present' : 'Absent',
                style: TextStyle(
                  color: isPresent ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: isPresent
                  ? [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check In',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  item['checkIn'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check Out',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  item['checkOut'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hours',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  hoursMinutes,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]
                  : [],
            ),
          );
        },
      ),
    );
  }
}

class OutletsPage extends StatefulWidget {
  const OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _outlets = List<Map<String, dynamic>>.from(
    nimeshProfile['outlets'],
  );

  String _searchText = '';

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _notThereRemarksController =
      TextEditingController();
  final List<TextEditingController> _stockControllers = [];
  List<XFile> _images = [];
  bool? _onLocation = true;
  String? _notThereRemarks;
  String _selectedProduct = 'All';

  List<Map<String, dynamic>> get _filteredOutlets {
    if (_searchText.isEmpty) return _outlets;
    return _outlets
        .where(
          (outlet) => (outlet['name'] ?? '').toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          ),
        )
        .toList();
  }

  void _openEditOutlet(Map<String, dynamic> outlet) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditOutletPage(outlet: outlet),
        fullscreenDialog: true,
      ),
    );
    setState(() {}); // Refresh after edit (mock)
  }

  void _openAddOutlet() async {
    final newOutlet = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddOutletPage(),
        fullscreenDialog: true,
      ),
    );
    if (newOutlet != null) {
      setState(() {
        _outlets.add(newOutlet);
      });
    }
  }

  void _clearModalState() {
    _amountController.clear();
    _remarksController.clear();
    _notThereRemarksController.clear();
    for (final c in _stockControllers) {
      c.clear();
    }
    _images.clear();
    _onLocation = true;
    _notThereRemarks = null;
    _selectedProduct = 'All';
    setState(() {});
  }

  void showCheckInSheet(Map<String, dynamic> outlet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => OutletCheckInBottomSheet(
        outlet: outlet,
        amountController: _amountController,
        remarksController: _remarksController,
        notThereRemarksController: _notThereRemarksController,
        stockControllers: _stockControllers,
        images: _images,
        onLocation: _onLocation,
        notThereRemarks: _notThereRemarks,
        selectedProduct: _selectedProduct,
        onLocationChanged: (val) => setState(() => _onLocation = val),
        onNotThereRemarksChanged: (val) =>
            setState(() => _notThereRemarks = val),
        onSelectedProductChanged: (val) =>
            setState(() => _selectedProduct = val),
        onImagesChanged: (val) => setState(() => _images = val),
        onSubmit: _clearModalState,
        onBack: _clearModalState,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Outlets',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                width: double.infinity,
                child: TextFormField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 16),
                  onChanged: (val) => setState(() => _searchText = val),
                  decoration: InputDecoration(
                    hintText: 'Search outlet by name...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _filteredOutlets.isEmpty
                    ? const Center(child: Text('No outlets found.'))
                    : ListView.separated(
                        itemCount: _filteredOutlets.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final outlet = _filteredOutlets[index];
                          void showOutletInfoDialog() {
                            showDialog(
                              context: context,
                              builder: (context) {
                                // --- Mock Data for demonstration ---
                                String selectedProduct = 'All';
                                // Mock data for each product
                                Map<String, Map<String, dynamic>> productStats =
                                    {
                                      'All': {
                                        'totalStock': 120,
                                        'totalLifetimeOrders': 45,
                                        'totalSalesAmount': 150000,
                                        'lastDailyCount': 15,
                                        'lastVisitedDate': '2024-06-10',
                                        'daysSinceLastVisit': 2,
                                        'lastOrderPlacedDate': '2024-06-08',
                                        'dueAmount': 5000,
                                        'lastPaidAmount': 2000,
                                        'lastPaidDate': '2024-06-09',
                                        'totalSalesThisMonth': -32,
                                      },
                                      'Seto Bagh': {
                                        'totalStock': 60,
                                        'totalLifetimeOrders': 20,
                                        'totalSalesAmount': 70000,
                                        'lastDailyCount': 7,
                                        'lastVisitedDate': '2024-06-09',
                                        'daysSinceLastVisit': 3,
                                        'lastOrderPlacedDate': '2024-06-07',
                                        'dueAmount': 2000,
                                        'lastPaidAmount': 1000,
                                        'lastPaidDate': '2024-06-08',
                                        'totalSalesThisMonth': -15,
                                      },
                                      'Sarangi': {
                                        'totalStock': 60,
                                        'totalLifetimeOrders': 25,
                                        'totalSalesAmount': 80000,
                                        'lastDailyCount': 8,
                                        'lastVisitedDate': '2024-06-10',
                                        'daysSinceLastVisit': 2,
                                        'lastOrderPlacedDate': '2024-06-08',
                                        'dueAmount': 3000,
                                        'lastPaidAmount': 1200,
                                        'lastPaidDate': '2024-06-09',
                                        'totalSalesThisMonth': -17,
                                      },
                                    };
                                // --- End Mock Data ---
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    final stats =
                                        productStats[selectedProduct]!;
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        24,
                                        24,
                                        24,
                                        16,
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.store,
                                                  color: Colors.orange,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    outlet['name']! ?? '',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                DropdownButton<String>(
                                                  value: selectedProduct,
                                                  items:
                                                      [
                                                        'All',
                                                        'Seto Bagh',
                                                        'Sarangi',
                                                      ].map((String value) {
                                                        return DropdownMenuItem<
                                                          String
                                                        >(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                  onChanged: (val) {
                                                    if (val != null) {
                                                      setModalState(
                                                        () => selectedProduct =
                                                            val,
                                                      );
                                                    }
                                                  },
                                                  underline: SizedBox(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            // Group 1
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF7F7FA),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _OutletStatRow(
                                                    label: 'Total Stock',
                                                    value: stats['totalStock']
                                                        .toString(),
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label:
                                                        'Total Lifetime Orders',
                                                    value:
                                                        stats['totalLifetimeOrders']
                                                            .toString(),
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label:
                                                        'Total Sales in Amount',
                                                    value:
                                                        'NPR ${stats['totalSalesAmount']}',
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label:
                                                        'Total Sales This Month',
                                                    value:
                                                        stats['totalSalesThisMonth']
                                                            .toString(),
                                                    bold: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            // Group 2
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF7F7FA),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _OutletStatRow(
                                                    label: 'Last Daily Count',
                                                    value:
                                                        stats['lastDailyCount']
                                                            .toString(),
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label: 'Last Visited',
                                                    value:
                                                        '${stats['lastVisitedDate']} (${stats['daysSinceLastVisit']} days ago)',
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label: 'Last Order Placed',
                                                    value:
                                                        stats['lastOrderPlacedDate'],
                                                    bold: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            // Group 3
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF7F7FA),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _OutletStatRow(
                                                    label: 'Due Amount',
                                                    value:
                                                        'NPR ${stats['dueAmount']}',
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label: 'Last Paid Amount',
                                                    value:
                                                        'NPR ${stats['lastPaidAmount']}',
                                                    bold: true,
                                                  ),
                                                  _OutletStatRow(
                                                    label: 'Last Paid Date',
                                                    value:
                                                        stats['lastPaidDate'],
                                                    bold: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text(
                                                    'CLOSE',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }

                          return Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: showOutletInfoDialog,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.store,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            outlet['name']! ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  outlet['location']! ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.green,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Call (mock)'),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    Material(
                                      color: Color(0xFFFFB800),
                                      borderRadius: BorderRadius.circular(24),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(24),
                                        onTap: () => _openEditOutlet(outlet),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: _openAddOutlet,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    _remarksController.dispose();
    _notThereRemarksController.dispose();
    for (final c in _stockControllers) {
      c.dispose();
    }
    super.dispose();
  }
}

class EditOutletPage extends StatefulWidget {
  final Map<String, dynamic> outlet;
  const EditOutletPage({super.key, required this.outlet});

  @override
  State<EditOutletPage> createState() => _EditOutletPageState();
}

class _EditOutletPageState extends State<EditOutletPage> {
  late TextEditingController nameController;
  late TextEditingController panController;
  String? selectedCategory;
  String? selectedClass;
  late TextEditingController addressController;
  late TextEditingController contactPersonController;
  late TextEditingController mobileController;
  late TextEditingController altMobileController;

  bool contactPersonUpdated = false;
  bool mobileUpdated = false;
  bool altMobileUpdated = false;

  final List<String> categories = ['Retail', 'Wholesale', 'Supermarket'];
  final List<String> classes = ['A+', 'A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.outlet['name']);
    panController = TextEditingController(text: widget.outlet['pan']);
    selectedCategory = widget.outlet['category'];
    selectedClass = widget.outlet['class'];
    addressController = TextEditingController(text: widget.outlet['address']);
    contactPersonController = TextEditingController(
      text: widget.outlet['contactPerson'],
    );
    mobileController = TextEditingController(text: widget.outlet['contact']);
    altMobileController = TextEditingController(
      text: widget.outlet['altMobile'],
    );
    contactPersonUpdated = widget.outlet['contactPersonUpdated'] == 'true';
    mobileUpdated = widget.outlet['mobileUpdated'] == 'true';
    altMobileUpdated = widget.outlet['altMobileUpdated'] == 'true';
  }

  void _updateOutlet() {
    setState(() {
      if (!contactPersonUpdated &&
          contactPersonController.text !=
              (widget.outlet['contactPerson'] ?? '')) {
        widget.outlet['contactPerson'] = contactPersonController.text;
        widget.outlet['contactPersonUpdated'] = 'true';
        contactPersonUpdated = true;
      }
      if (!mobileUpdated &&
          mobileController.text != (widget.outlet['contact'] ?? '')) {
        widget.outlet['contact'] = mobileController.text;
        widget.outlet['mobileUpdated'] = 'true';
        mobileUpdated = true;
      }
      if (!altMobileUpdated &&
          altMobileController.text != (widget.outlet['altMobile'] ?? '')) {
        widget.outlet['altMobile'] = altMobileController.text;
        widget.outlet['altMobileUpdated'] = 'true';
        altMobileUpdated = true;
      }
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Outlet updated (mock)')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Update Outlet',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Please fill up the forms below',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Outlet Name'),
              TextField(
                controller: nameController,
                readOnly: true,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('PAN No.'),
              TextField(
                controller: panController,
                readOnly: true,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Category'),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: null,
                decoration: const InputDecoration(isDense: true),
                disabledHint: Text(selectedCategory ?? ''),
              ),
              const SizedBox(height: 16),
              const Text('Class'),
              DropdownButtonFormField<String>(
                value: selectedClass,
                items: classes
                    .map(
                      (cls) => DropdownMenuItem(value: cls, child: Text(cls)),
                    )
                    .toList(),
                onChanged: null,
                decoration: const InputDecoration(isDense: true),
                disabledHint: Text(selectedClass ?? ''),
              ),
              const SizedBox(height: 16),
              const Text('Address'),
              TextField(
                controller: addressController,
                readOnly: true,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Contact Person'),
              TextField(
                controller: contactPersonController,
                readOnly: contactPersonUpdated,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: contactPersonUpdated
                      ? const Icon(Icons.lock, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Mobile No.'),
              TextField(
                controller: mobileController,
                readOnly: mobileUpdated,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: mobileUpdated
                      ? const Icon(Icons.lock, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Alternate Mobile No.'),
              TextField(
                controller: altMobileController,
                readOnly: altMobileUpdated,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: altMobileUpdated
                      ? const Icon(Icons.lock, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.location_on, color: Colors.white),
                  label: const Text(
                    'Set Location',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed:
                      (contactPersonUpdated &&
                          mobileUpdated &&
                          altMobileUpdated)
                      ? null
                      : _updateOutlet,
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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

class AddOutletPage extends StatefulWidget {
  const AddOutletPage({super.key});

  @override
  State<AddOutletPage> createState() => _AddOutletPageState();
}

class _AddOutletPageState extends State<AddOutletPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  String? selectedCategory;
  String? selectedClass;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController altMobileController = TextEditingController();

  final List<String> categories = ['Retail', 'Wholesale', 'Supermarket'];
  final List<String> classes = ['A+', 'A', 'B', 'C'];

  void _addOutlet() {
    // TODO: Add notification/reminder for incomplete outlet details on Home page
    Navigator.pop(context, {
      'name': nameController.text,
      'location': addressController.text,
      'contact': mobileController.text,
      'pan': panController.text,
      'category': selectedCategory ?? '',
      'class': selectedClass ?? '',
      'address': addressController.text,
      'contactPerson': contactPersonController.text,
      'altMobile': altMobileController.text,
      'remarks': '',
      'contactPersonUpdated': 'false',
      'mobileUpdated': 'false',
      'altMobileUpdated': 'false',
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Outlet added (mock)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Outlet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Please fill up the forms below',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Outlet Name'),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('PAN No.'),
              TextField(
                controller: panController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Category'),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Class'),
              DropdownButtonFormField<String>(
                value: selectedClass,
                items: classes
                    .map(
                      (cls) => DropdownMenuItem(value: cls, child: Text(cls)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => selectedClass = val),
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Address'),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Contact Person'),
              TextField(
                controller: contactPersonController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Mobile No.'),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 16),
              const Text('Alternate Mobile No.'),
              TextField(
                controller: altMobileController,
                decoration: const InputDecoration(isDense: true),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.location_on, color: Colors.white),
                  label: const Text(
                    'Set Location',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // Mock: No real location logic yet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Set Location (mock)')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _addOutlet,
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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

class PJPPage extends StatefulWidget {
  const PJPPage({super.key});

  @override
  State<PJPPage> createState() => _PJPPageState();
}

class _PJPPageState extends State<PJPPage> {
  NepaliDateTime selectedDate = NepaliDateTime.now();
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final String routeName = 'Route 1'; // Always Route 1 for testing

  @override
  void initState() {
    super.initState();
    _loadPJPData();
  }

  Future<void> _loadPJPData() async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = this.dateKey;
    final pjpList = prefs.getStringList('pjpPlans_$dateKey');
    if (pjpList != null) {
      pjpPlans[dateKey] = pjpList;
    }
    final visitStatusMap = prefs.getStringList('pjpVisitStatus_$dateKey') ?? [];
    for (final entry in visitStatusMap) {
      final parts = entry.split('|');
      if (parts.length == 2) {
        pjpVisitStatus['$dateKey|${parts[0]}'] = parts[1] == '1';
      }
    }
    setState(() {});
  }

  Future<void> _savePJPPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = this.dateKey;
    await prefs.setStringList('pjpPlans_$dateKey', pjpPlans[dateKey] ?? []);
  }

  Future<void> _saveVisitStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = this.dateKey;
    final entries = pjpVisitStatus.entries
        .where((e) => e.key.startsWith('$dateKey|'))
        .map((e) => '${e.key.split('|')[1]}|${e.value ? '1' : '0'}')
        .toList();
    await prefs.setStringList('pjpVisitStatus_$dateKey', entries);
  }

  List<Map<String, dynamic>> get allRoute1Outlets {
    return List<Map<String, dynamic>>.from(
      nimeshProfile['outlets'] ?? [],
    ).where((o) => o['routeId'] == 1).toList();
  }

  String get dateKey {
    final d = selectedDate;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  List<Map<String, dynamic>> get todaysPJPOutlets {
    final plannedNames =
        pjpPlans[dateKey] ??
        allRoute1Outlets.map((o) => o['name'] as String).toList();
    return allRoute1Outlets
        .where((o) => plannedNames.contains(o['name']))
        .toList();
  }

  List<Map<String, dynamic>> get searchResults {
    if (_searchText.isEmpty) return todaysPJPOutlets;
    final allOutlets = List<Map<String, dynamic>>.from(
      nimeshProfile['outlets'] ?? [],
    );
    return allOutlets
        .where(
          (o) => (o['name'] ?? '').toString().toLowerCase().contains(
            _searchText.toLowerCase(),
          ),
        )
        .toList();
  }

  bool isInTodaysPJP(String outletName) {
    final plannedNames =
        pjpPlans[dateKey] ??
        allRoute1Outlets.map((o) => o['name'] as String).toList();
    return plannedNames.contains(outletName);
  }

  bool isVisited(String outletName) {
    return pjpVisitStatus['$dateKey|$outletName'] == true;
  }

  void _addToTodaysPJP(String outletName) async {
    setState(() {
      final planned =
          pjpPlans[dateKey] ??
          allRoute1Outlets.map((o) => o['name'] as String).toList();
      if (!planned.contains(outletName)) {
        planned.add(outletName);
        pjpPlans[dateKey] = planned;
      }
      _searchText = '';
      _searchController.clear();
    });
    await _savePJPPlans();
  }

  void _markVisited(String outletName) async {
    setState(() {
      pjpVisitStatus['$dateKey|$outletName'] = true;
    });
    await _saveVisitStatus();
  }

  void _pickDate() async {
    final picked = await showNepaliDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: NepaliDateTime(2070, 1, 1),
      lastDate: NepaliDateTime(2100, 12, 30),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      await _loadPJPData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final showSearchResults = _searchText.isNotEmpty;
    final listToShow = showSearchResults ? searchResults : todaysPJPOutlets;
    return Scaffold(
      backgroundColor: kAppBgColor,
      body: Column(
        children: [
          // Orange banner
          Container(
            width: double.infinity,
            color: Colors.orange,
            padding: const EdgeInsets.only(top: 48, bottom: 16),
            child: const Center(
              child: Text(
                'PJP Lists',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          // Date selector and route name row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange, width: 1.2),
                      ),
                      child: Text(
                        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange, width: 1.2),
                    ),
                    child: Text(
                      routeName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search PJP',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _searchText = val;
                });
              },
            ),
          ),
          // PJP List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: listToShow.length,
              itemBuilder: (context, idx) {
                final outlet = listToShow[idx];
                final outletName = outlet['name'] ?? '';
                final inPJP = isInTodaysPJP(outletName);
                final visited = isVisited(outletName);
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    leading: const Icon(
                      Icons.store,
                      color: Colors.orange,
                      size: 32,
                    ),
                    title: Text(
                      outlet['name'] ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          outlet['location'] ?? '',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    trailing: showSearchResults && !inPJP
                        ? IconButton(
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                            onPressed: () => _addToTodaysPJP(outletName),
                          )
                        : visited
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ),
                                onPressed: () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Calling ${outlet['contact']} (mock)',
                                        ),
                                      ),
                                    ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    // Simulate check-in and mark as visited
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CheckInPageForOutlet(
                                              outlet: outlet,
                                            ),
                                      ),
                                    );
                                    _markVisited(outletName);
                                  },
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

// --- CHECK IN PAGE FOR OUTLET (as per screenshot) ---
class CheckInPageForOutlet extends StatefulWidget {
  final Map<String, dynamic> outlet;
  const CheckInPageForOutlet({super.key, required this.outlet});

  @override
  State<CheckInPageForOutlet> createState() => _CheckInPageForOutletState();
}

class _CheckInPageForOutletState extends State<CheckInPageForOutlet> {
  bool isOnLocation = true;
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController notThereReasonController =
      TextEditingController();
  final List<String> products = ['All']; // Add more if needed
  String selectedProduct = 'All';
  bool expandStock = false;
  bool expandOrder = false;
  bool expandReturn = false;

  final GlobalKey _stockSectionKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  // For not-there dialog
  Future<void> _showNotThereDialog() async {
    notThereReasonController.clear();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Submit Reason'),
          content: TextField(
            controller: notThereReasonController,
            decoration: const InputDecoration(
              hintText: 'Please provide a reason...',
            ),
            maxLines: 2,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (notThereReasonController.text.trim().isEmpty) return;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool _validateStockFields() {
    final stockTableState = _stockSectionKey.currentState as _StockTableState?;
    if (stockTableState == null) return false;
    return stockTableState.validateFields();
  }

  void _scrollToStockSection() {
    final ctx = _stockSectionKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handleYesIAm() async {
    final outletLat = widget.outlet['latitude'];
    final outletLng = widget.outlet['longitude'];
    if (outletLat == null || outletLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No GPS location set for this outlet.')),
      );
      return;
    }
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied.')),
      );
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double distance = Geolocator.distanceBetween(
      outletLat,
      outletLng,
      position.latitude,
      position.longitude,
    );
    if (distance <= 20) {
      setState(() {
        isOnLocation = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You are at the outlet location.')),
      );
      // Proceed with check-in logic
    } else {
      setState(() {
        isOnLocation = false;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Not at Outlet'),
          content: Text(
            'You are not within 20 meters of the outlet location. Please provide a reason.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = {
      'totalStock': 120,
      'totalSoldThisMonth': -32,
      'totalReturned': 7,
      'lastDailyCount': 15,
      'lastVisitedDate': '2082-02-20',
      'daysSinceLastVisit': '2',
    };
    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Check In',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Are you on the location? label
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 2),
              child: Text(
                'Are you on the location?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            // Location status toggle
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isOnLocation
                            ? Colors.black
                            : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _handleYesIAm,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yes, I am',
                            style: TextStyle(
                              color: isOnLocation ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          if (isOnLocation)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isOnLocation
                            ? Colors.black
                            : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isOnLocation = false;
                        });
                        await _showNotThereDialog();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I'm not",
                            style: TextStyle(
                              color: !isOnLocation
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          if (!isOnLocation)
                            const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.radio_button_unchecked,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // (No inline reason box anymore)
            const SizedBox(height: 16),
            // Outlet card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.store, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        widget.outlet['name'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      DropdownButton<String>(
                        value: selectedProduct,
                        items: products.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedProduct = val;
                            });
                          }
                        },
                        underline: const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Location: ${widget.outlet['location'] ?? ''}'),
                  Text('Contact: ${widget.outlet['contact'] ?? ''}'),
                  const SizedBox(height: 8),
                  // Stats table
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          Text('Total Stock'),
                          Text(stats['totalStock'].toString()),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Total Sold This Month'),
                          Text(stats['totalSoldThisMonth'].toString()),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Total Returned'),
                          Text(stats['totalReturned'].toString()),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Last Daily Count'),
                          Text(stats['lastDailyCount'].toString()),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Last Visited Date'),
                          Text(
                            '${stats['lastVisitedDate']} (${stats['daysSinceLastVisit']} days ago)',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Expandable sections
            _ExpandableSection(
              title: 'Daily Stock Count *',
              expanded: expandStock,
              onHeaderTap: () => setState(() => expandStock = !expandStock),
              child: expandStock
                  ? Column(
                      children: [
                        _StockTable(
                          key: _stockSectionKey,
                          group1: 'Sarangi',
                          group2: 'Seto Bagh',
                          controllers: [],
                          numberOnly: true,
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            _ExpandableSection(
              title: 'Order Management',
              expanded: expandOrder,
              onHeaderTap: () => setState(() => expandOrder = !expandOrder),
              child: expandOrder
                  ? Column(
                      children: [
                        _StockTable(
                          group1: 'Sarangi',
                          group2: 'Seto Bagh',
                          controllers: [],
                          numberOnly: true,
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            _ExpandableSection(
              title: 'Return',
              expanded: expandReturn,
              onHeaderTap: () => setState(() => expandReturn = !expandReturn),
              child: expandReturn
                  ? Column(
                      children: [
                        _StockTable(
                          group1: 'Sarangi',
                          group2: 'Seto Bagh',
                          controllers: [],
                          numberOnly: true,
                        ),
                      ],
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            // Payment Collected
            const Text(
              'Payment Collected',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: paymentController,
              decoration: const InputDecoration(
                hintText: 'Amount in numbers...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 12),
            // Remarks
            const Text('Remarks'),
            const SizedBox(height: 4),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(
                hintText: 'Your Remarks Here',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Attach Image section (moved here)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  const Icon(Icons.camera_alt, color: Colors.green, size: 36),
                  const SizedBox(height: 8),
                  const Text(
                    'Attach Image',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'selected: 0 images',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  if (!_validateStockFields()) {
                    setState(() {
                      expandStock = true;
                    });
                    _scrollToStockSection();
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text(
                          'Incomplete Entry',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const SizedBox(
                          width: 260,
                          child: Text(
                            'Please input daily stock count',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'OK',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
                  // Mock submit action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submitted (mock)')),
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableSection extends StatelessWidget {
  final String title;
  final Widget? child;
  final bool expanded;
  final VoidCallback onHeaderTap;
  const _ExpandableSection({
    required this.title,
    this.child,
    this.expanded = false,
    required this.onHeaderTap,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onHeaderTap,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                  bottom: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Icon(expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
          if (expanded && child != null)
            Padding(padding: const EdgeInsets.all(12.0), child: child!),
        ],
      ),
    );
  }
}

class OutletCheckInBottomSheet extends StatefulWidget {
  final Map<String, dynamic> outlet;
  final TextEditingController amountController;
  final TextEditingController remarksController;
  final TextEditingController notThereRemarksController;
  final List<TextEditingController> stockControllers;
  final List<XFile> images;
  final bool? onLocation;
  final String? notThereRemarks;
  final String selectedProduct;
  final Function(bool) onLocationChanged;
  final Function(String) onNotThereRemarksChanged;
  final Function(String) onSelectedProductChanged;
  final Function(List<XFile>) onImagesChanged;
  final Function() onSubmit;
  final Function() onBack;
  const OutletCheckInBottomSheet({
    super.key,
    required this.outlet,
    required this.amountController,
    required this.remarksController,
    required this.notThereRemarksController,
    required this.stockControllers,
    required this.images,
    required this.onLocation,
    required this.notThereRemarks,
    required this.selectedProduct,
    required this.onLocationChanged,
    required this.onNotThereRemarksChanged,
    required this.onSelectedProductChanged,
    required this.onImagesChanged,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<OutletCheckInBottomSheet> createState() =>
      _OutletCheckInBottomSheetState();
}

class _OutletCheckInBottomSheetState extends State<OutletCheckInBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // --- Mock Data for demonstration ---
    final int totalStock = 120;
    final int totalReturned = 7;
    final int lastDailyCount = 15;
    final String lastVisitedDateString = NepaliDateFormat(
      'yyyy-MM-dd',
      Language.english,
    ).format(NepaliDateTime.now().subtract(Duration(days: 2)));
    // Mock daily stock counts for the current Nepali month
    final NepaliDateTime today = NepaliDateTime.now();
    final List<int> dailyCounts = [
      10,
      12,
      8,
      9,
      11,
      13,
      15,
      10,
      12,
      14,
      9,
      8,
      10,
      11,
    ]; // mock for days so far
    final int totalSoldThisMonth =
        totalStock - dailyCounts.reduce((a, b) => a + b);
    // --- End Mock Data ---
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      elevation: 8,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.95,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Check In',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Are you on the location?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.onLocationChanged(true);
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: widget.onLocation == true
                                ? Colors.black
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Yes, I am',
                                style: TextStyle(
                                  color: widget.onLocation == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                widget.onLocation == true
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: widget.onLocation == true
                                    ? Colors.white
                                    : Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Submit Reason'),
                              content: TextField(
                                controller: widget.notThereRemarksController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your remarks...',
                                ),
                                autofocus: true,
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                      widget.notThereRemarksController.text
                                          .trim(),
                                    );
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ).then((value) {
                            if (value != null && value.isNotEmpty) {
                              widget.onNotThereRemarksChanged(value);
                              setState(() {
                                widget.onLocationChanged(false);
                              });
                            } else {
                              widget.onLocationChanged(true);
                            }
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: widget.onLocation == false
                                ? Colors.black
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I'm not",
                                style: TextStyle(
                                  color: widget.onLocation == false
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                widget.onLocation == false
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: widget.onLocation == false
                                    ? Colors.white
                                    : Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.store, color: Colors.amber),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.outlet['name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: widget.selectedProduct,
                                    items: ['All', 'Seto Bagh', 'Sarangi'].map((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        widget.onSelectedProductChanged(val);
                                      }
                                    },
                                    underline: SizedBox(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Location: ${widget.outlet['location'] ?? ''}',
                              ),
                              Text(
                                'Contact: ${widget.outlet['contact'] ?? ''}',
                              ),
                              const Divider(height: 24),
                              _OutletStatRow(
                                label: 'Total Stock',
                                value: totalStock.toString(),
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Total Sold This Month',
                                value: totalSoldThisMonth.toString(),
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Total Returned',
                                value: totalReturned.toString(),
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Last Daily Count',
                                value: lastDailyCount.toString(),
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Last Visited Date',
                                value: lastVisitedDateString,
                                bold: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // HEADER BACKGROUND
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 12.0),
                //   child: Container(
                //     width: double.infinity,
                //     padding: const EdgeInsets.symmetric(
                //       vertical: 10,
                //       horizontal: 16,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Color(0xFFFFF3E0),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: const Text(
                //       'Stock & Order Entry',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
                _ExpandableSection(
                  title: 'Daily Stock Count *',
                  expanded: false,
                  onHeaderTap: () {},
                  child: _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: [],
                    numberOnly: true,
                  ),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Order Management',
                  expanded: false,
                  onHeaderTap: () {},
                  child: _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: [],
                    numberOnly: true,
                  ),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Return',
                  expanded: false,
                  onHeaderTap: () {},
                  child: Column(
                    children: [
                      _StockTable(
                        group1: 'Sarangi',
                        group2: 'Seto Bagh',
                        controllers: [],
                        numberOnly: true,
                      ),
                    ],
                  ),
                ),
                // MOVED FIELDS BELOW ALL SECTIONS
                const SizedBox(height: 16),
                // Add heading above amount input
                Padding(
                  padding: EdgeInsets.only(left: 2, bottom: 4),
                  child: Text(
                    'Payment Collected',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextField(
                  controller: widget.amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          'रु',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Amount in numbers...',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.only(left: 2, bottom: 4),
                  child: Text(
                    'Remarks',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
                TextField(
                  controller: widget.remarksController,
                  decoration: InputDecoration(
                    hintText: 'Your Remarks Here',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    widget.onImagesChanged([
                      XFile('https://via.placeholder.com/40'),
                      XFile('https://via.placeholder.com/40'),
                      XFile('https://via.placeholder.com/40'),
                    ]);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 36,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Attach Image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.images.isEmpty
                              ? 'select 3 images'
                              : 'selected: ${widget.images.length} image${widget.images.length > 1 ? 's' : ''}',
                          style: const TextStyle(color: Colors.black54),
                        ),
                        if (widget.images.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: widget.images
                                  .map(
                                    (img) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0,
                                      ),
                                      child: Image.network(
                                        img.path ?? '',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFB800),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: widget.onSubmit,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OutletStatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _OutletStatRow({
    required this.label,
    required this.value,
    required this.bold,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 15)),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _StockTable extends StatefulWidget {
  final String group1;
  final String group2;
  final List<TextEditingController>? controllers;
  final bool numberOnly;
  const _StockTable({
    super.key,
    this.group1 = 'Sarangi',
    this.group2 = 'Seto Bagh',
    this.controllers,
    this.numberOnly = false,
  });
  @override
  State<_StockTable> createState() => _StockTableState();
}

class _StockTableState extends State<_StockTable> {
  final Map<String, TextEditingController> _casesControllers = {};
  final Map<String, TextEditingController> _bottlesControllers = {};
  final Map<String, int> _caseToBottle = {
    '750ML': 12,
    '375ML': 24,
    '180ML': 48,
  };
  final List<String> sizes = ['750ML', '375ML', '180ML'];
  String? _currentlyEditing;

  @override
  void initState() {
    super.initState();
    for (final group in [widget.group1, widget.group2]) {
      for (final size in sizes) {
        final key = '${group}_$size';
        _casesControllers[key] = TextEditingController();
        _bottlesControllers[key] = TextEditingController();
        if (widget.controllers != null) {
          widget.controllers!.add(_casesControllers[key]!);
          widget.controllers!.add(_bottlesControllers[key]!);
        }
        _casesControllers[key]!.addListener(() {
          if (_currentlyEditing == 'bottles_$key') return;
          _currentlyEditing = 'cases_$key';
          final text = _casesControllers[key]!.text;
          if (text.isNotEmpty && text != '-') {
            final val = double.tryParse(text) ?? 0.0;
            final bottles = (val * _caseToBottle[size]!).round();
            final bottlesStr = bottles == 0 ? '' : bottles.toString();
            if (_bottlesControllers[key]!.text != bottlesStr) {
              _bottlesControllers[key]!.text = bottlesStr;
            }
          } else {
            if (_bottlesControllers[key]!.text.isNotEmpty) {
              _bottlesControllers[key]!.text = '';
            }
          }
          _currentlyEditing = null;
        });
        _bottlesControllers[key]!.addListener(() {
          if (_currentlyEditing == 'cases_$key') return;
          _currentlyEditing = 'bottles_$key';
          final text = _bottlesControllers[key]!.text;
          if (text.isNotEmpty && text != '-') {
            final val = int.tryParse(text) ?? 0;
            final cases = val / _caseToBottle[size]!;
            String casesStr = cases == 0
                ? ''
                : cases.toStringAsFixed(2).replaceAll(RegExp(r'\.00'), '');
            if (_casesControllers[key]!.text != casesStr) {
              _casesControllers[key]!.text = casesStr;
            }
          } else {
            if (_casesControllers[key]!.text.isNotEmpty) {
              _casesControllers[key]!.text = '';
            }
          }
          _currentlyEditing = null;
        });
      }
    }
  }

  bool validateFields() {
    bool allFilled = true;
    for (final c in _casesControllers.values) {
      if (c.text.trim().isEmpty) allFilled = false;
    }
    for (final c in _bottlesControllers.values) {
      if (c.text.trim().isEmpty) allFilled = false;
    }
    return allFilled;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF9F6FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _groupHeader(widget.group1),
            ...sizes.map((size) => _productRow(widget.group1, size)),
            const SizedBox(height: 8),
            const Divider(thickness: 1, height: 24),
            _groupHeader(widget.group2),
            ...sizes.map((size) => _productRow(widget.group2, size)),
          ],
        ),
      ),
    );
  }

  Widget _groupHeader(String group) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4, left: 2),
      child: Text(
        group,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _productRow(String group, String size) {
    final key = '${group}_$size';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: Text(size, style: const TextStyle(fontSize: 14)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _casesControllers[key],
                    decoration: InputDecoration(
                      hintText: 'Cases',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: widget.numberOnly
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters: widget.numberOnly
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _bottlesControllers[key],
                    decoration: InputDecoration(
                      hintText: 'Bottles',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: widget.numberOnly
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters: widget.numberOnly
                        ? [FilteringTextInputFormatter.digitsOnly]
                        : [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OutletDetailsPage extends StatelessWidget {
  final Map<String, String> outlet;
  const OutletDetailsPage({super.key, required this.outlet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Outlet Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: kAppBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Name: ${outlet['name'] ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Location: ${outlet['location'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Contact: ${outlet['contact'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('PAN: ${outlet['pan'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Category: ${outlet['category'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Class: ${outlet['class'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Address: ${outlet['address'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Contact Person: ${outlet['contactPerson'] ?? ''}'),
                  const SizedBox(height: 8),
                  Text('Alternate Mobile: ${outlet['altMobile'] ?? ''}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = nimeshProfile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: kAppBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.orange[100],
                        child: const Icon(
                          Icons.person,
                          color: Colors.orange,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profile['fullName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile['staffType'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.orange),
                      title: const Text('View Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewProfilePage(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.lock, color: Colors.orange),
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final oldPasswordController =
                                TextEditingController();
                            final newPasswordController =
                                TextEditingController();
                            return AlertDialog(
                              title: const Text('Change Password'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: oldPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Old Password',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: newPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'New Password',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Password changed (mock)',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = nimeshProfile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'View Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: kAppBgColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 24),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.orange[100],
                    child: const Icon(
                      Icons.person,
                      color: Colors.orange,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile['fullName'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile['staffType'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _ProfileField(
              icon: Icons.phone,
              label: 'Mobile Number',
              value: profile['mobileNumber'],
            ),
            _ProfileField(
              icon: Icons.badge,
              label: 'Role',
              value: profile['staffType'],
            ),
            _ProfileField(
              icon: Icons.category,
              label: 'Level',
              value: profile['level'].toString(),
            ),
            _ProfileField(
              icon: Icons.people,
              label: 'Reports To',
              value: profile['zoneManagerName'],
            ),
            _ProfileField(
              icon: Icons.apartment,
              label: 'Zone',
              value: profile['zone'],
            ),
            _ProfileField(icon: Icons.map, label: 'Area/Region', value: 'N/A'),
            _ProfileField(icon: Icons.home, label: 'Address', value: ''),
          ],
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ProfileField({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}

// Mock XFile if image_picker is not available
class XFile {
  final String path;
  XFile(this.path);
}

// Add this widget to the file:
class PJPCheckInPage extends StatefulWidget {
  final Map<String, String> outlet;
  final TextEditingController amountController;
  final TextEditingController remarksController;
  final TextEditingController notThereRemarksController;
  final List<TextEditingController> stockControllers;
  final List<XFile> images;
  final bool? onLocation;
  final String? notThereRemarks;
  final String selectedProduct;
  final Function(bool) onLocationChanged;
  final Function(String) onNotThereRemarksChanged;
  final Function(String) onSelectedProductChanged;
  final Function(List<XFile>) onImagesChanged;
  final Function() onSubmit;
  final Function() onBack;
  const PJPCheckInPage({
    super.key,
    required this.outlet,
    required this.amountController,
    required this.remarksController,
    required this.notThereRemarksController,
    required this.stockControllers,
    required this.images,
    required this.onLocation,
    required this.notThereRemarks,
    required this.selectedProduct,
    required this.onLocationChanged,
    required this.onNotThereRemarksChanged,
    required this.onSelectedProductChanged,
    required this.onImagesChanged,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<PJPCheckInPage> createState() => _PJPCheckInPageState();
}

class _PJPCheckInPageState extends State<PJPCheckInPage> {
  @override
  Widget build(BuildContext context) {
    // --- Mock Data for demonstration ---
    final int totalStock = 120;
    final int totalReturned = 7;
    final int lastDailyCount = 15;
    final String lastVisitedDateString = NepaliDateFormat(
      'yyyy-MM-dd',
      Language.english,
    ).format(NepaliDateTime.now().subtract(Duration(days: 2)));
    // Mock daily stock counts for the current Nepali month
    final NepaliDateTime today = NepaliDateTime.now();
    final List<int> dailyCounts = [
      10,
      12,
      8,
      9,
      11,
      13,
      15,
      10,
      12,
      14,
      9,
      8,
      10,
      11,
    ]; // mock for days so far
    final int totalSoldThisMonth =
        totalStock - dailyCounts.reduce((a, b) => a + b);
    // --- End Mock Data ---
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Check In',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            widget.onBack();
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: kAppBgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you on the location?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.onLocationChanged(true);
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: widget.onLocation == true
                            ? Colors.black
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Yes, I am',
                            style: TextStyle(
                              color: widget.onLocation == true
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            widget.onLocation == true
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: widget.onLocation == true
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Submit Reason'),
                          content: TextField(
                            controller: widget.notThereRemarksController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your remarks...',
                            ),
                            autofocus: true,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  widget.notThereRemarksController.text.trim(),
                                );
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ).then((value) {
                        if (value != null && value.isNotEmpty) {
                          widget.onNotThereRemarksChanged(value);
                          setState(() {
                            widget.onLocationChanged(false);
                          });
                        } else {
                          widget.onLocationChanged(true);
                        }
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: widget.onLocation == false
                            ? Colors.black
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "I'm not",
                            style: TextStyle(
                              color: widget.onLocation == false
                                  ? Colors.white
                                  : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            widget.onLocation == false
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: widget.onLocation == false
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.store, color: Colors.amber),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.outlet['name'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              DropdownButton<String>(
                                value: widget.selectedProduct,
                                items: ['All', 'Seto Bagh', 'Sarangi'].map((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    widget.onSelectedProductChanged(val);
                                  }
                                },
                                underline: SizedBox(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text('Location: ${widget.outlet['location'] ?? ''}'),
                          Text('Contact: ${widget.outlet['contact'] ?? ''}'),
                          const Divider(height: 24),
                          _OutletStatRow(
                            label: 'Total Stock',
                            value: totalStock.toString(),
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Total Sold This Month',
                            value: totalSoldThisMonth.toString(),
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Total Returned',
                            value: totalReturned.toString(),
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Last Daily Count',
                            value: lastDailyCount.toString(),
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Last Visited Date',
                            value: lastVisitedDateString,
                            bold: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // HEADER BACKGROUND
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 12.0),
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 10,
            //       horizontal: 16,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Color(0xFFFFF3E0),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: const Text(
            //       'Stock & Order Entry',
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //   ),
            // ),
            _ExpandableSection(
              title: 'Daily Stock Count *',
              expanded: false,
              onHeaderTap: () {},
              child: _StockTable(
                group1: 'Sarangi',
                group2: 'Seto Bagh',
                controllers: [],
                numberOnly: true,
              ),
            ),
            const SizedBox(height: 16),
            _ExpandableSection(
              title: 'Order Management',
              expanded: false,
              onHeaderTap: () {},
              child: _StockTable(
                group1: 'Sarangi',
                group2: 'Seto Bagh',
                controllers: [],
                numberOnly: true,
              ),
            ),
            const SizedBox(height: 16),
            _ExpandableSection(
              title: 'Return',
              expanded: false,
              onHeaderTap: () {},
              child: Column(
                children: [
                  _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: [],
                    numberOnly: true,
                  ),
                ],
              ),
            ),
            // MOVED FIELDS BELOW ALL SECTIONS
            const SizedBox(height: 16),
            // Add heading above amount input
            Padding(
              padding: EdgeInsets.only(left: 2, bottom: 4),
              child: Text(
                'Payment Collected',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            TextField(
              controller: widget.amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  width: 32,
                  child: Center(
                    child: Text(
                      'रु',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                hintText: 'Amount in numbers...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.only(left: 2, bottom: 4),
              child: Text(
                'Remarks',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            TextField(
              controller: widget.remarksController,
              decoration: InputDecoration(
                hintText: 'Your Remarks Here',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.orange, width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                widget.onImagesChanged([
                  XFile('https://via.placeholder.com/40'),
                  XFile('https://via.placeholder.com/40'),
                  XFile('https://via.placeholder.com/40'),
                ]);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.camera_alt, color: Colors.green, size: 36),
                    const SizedBox(height: 8),
                    const Text(
                      'Attach Image',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.images.isEmpty
                          ? 'select 3 images'
                          : 'selected: ${widget.images.length} image${widget.images.length > 1 ? 's' : ''}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    if (widget.images.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.images
                              .map(
                                (img) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Image.network(
                                    img.path ?? '',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFB800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: widget.onSubmit,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use the same mock outlets as OutletsPage
  final List<Map<String, dynamic>> _outlets = List<Map<String, dynamic>>.from(
    nimeshProfile['outlets'],
  );

  List<Map<String, dynamic>> get _incompleteOutlets {
    final requiredFields = [
      'name',
      'location',
      'contact',
      'category',
      'class',
      'address',
      'contactPerson',
      'contact',
    ];
    return _outlets.where((outlet) {
      for (final field in requiredFields) {
        if ((outlet[field] ?? '').toString().trim().isEmpty) return true;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String agentName = nimeshProfile['fullName'];
    final int salesTarget = 200000;
    final int salesThisMonth = 120000;
    final double progress = salesThisMonth / salesTarget;
    final int outletsVisited = 18;
    final int totalOrders = 25;
    final double attendancePercent = 92.5;
    final String lastOrder = '22-Jestha-2082';
    final String lastPayment = 'NPR 5,000 on 21-Jestha-2082';
    final String todayStatus = 'Checked In';

    return Scaffold(
      backgroundColor: kAppBgColor,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.orange[100],
                    child: const Icon(
                      Icons.person,
                      color: Colors.orange,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          agentName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Monthly Sales Progress',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                              backgroundColor: Colors.orange[100],
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${(progress * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'NPR $salesThisMonth / $salesTarget',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fingerprint,
                              color: Colors.green,
                              size: 28,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              todayStatus,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Today',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.store, color: Colors.orange, size: 28),
                            const SizedBox(height: 6),
                            Text(
                              '$outletsVisited',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Outlets Visited',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.blue,
                              size: 28,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$totalOrders',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Orders Placed',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.deepPurple,
                              size: 28,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'NPR $salesThisMonth',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Sales This Month',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified_user, color: Colors.teal, size: 28),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${attendancePercent.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Attendance',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Status Report',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 8),
                          Text('Last Stock Count: 22-Jestha-2082'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.shopping_cart, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text('Last Order: $lastOrder'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.assignment_return,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8),
                          Text('Last Return: 21-Jestha-2082'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            color: Colors.deepPurple,
                          ),
                          const SizedBox(width: 8),
                          Text('Last Payment: $lastPayment'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Incomplete outlets info card below status report (if any)
              if (_incompleteOutlets.isNotEmpty)
                Card(
                  color: Color(0xFFF7F2FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.only(top: 12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The following outlets have incomplete details and should be updated:',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ..._incompleteOutlets.map(
                          (o) => Text(
                            '• ${o['name'] ?? 'Unnamed Outlet'}',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
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
    );
  }
}

// --- Nimesh Subedi Staff Profile ---
final Map<String, dynamic> nimeshProfile = {
  'fullName': 'Nimesh Subedi',
  'staffType': 'Sales Agent',
  'staffCode': 'NS001',
  'phone': '9800000000',
  'email': 'nimesh.subedi@example.com',
  'zone': 'Zone A',
  'zoneManagerName': 'RSM/ASM Name',
  'routes': [
    {'routeId': 1, 'routeName': 'Route 1'},
    {'routeId': 2, 'routeName': 'Route 2'},
    {'routeId': 3, 'routeName': 'Route 3'},
  ],
  'outlets': [
    // Route 1
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1A',
      'name': 'Outlet 1A-1',
      'contact': '9800000001',
      'category': 'Retail',
      'owner': 'Owner 1A-1',
      'gps': '27.7000,85.3333',
    },
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1A',
      'name': 'Outlet 1A-2',
      'contact': '9800000002',
      'category': 'Retail',
      'owner': 'Owner 1A-2',
      'gps': '27.7001,85.3334',
    },
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1A',
      'name': 'Outlet 1A-3',
      'contact': '9800000003',
      'category': 'Retail',
      'owner': 'Owner 1A-3',
      'gps': '27.7002,85.3335',
    },
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1B',
      'name': 'Outlet 1B-1',
      'contact': '9800000004',
      'category': 'Retail',
      'owner': 'Owner 1B-1',
      'gps': '27.7003,85.3336',
    },
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1B',
      'name': 'Outlet 1B-2',
      'contact': '9800000005',
      'category': 'Retail',
      'owner': 'Owner 1B-2',
      'gps': '27.7004,85.3337',
    },
    {
      'routeId': 1,
      'routeName': 'Route 1',
      'location': 'Location 1B',
      'name': 'Outlet 1B-3',
      'contact': '9800000006',
      'category': 'Retail',
      'owner': 'Owner 1B-3',
      'gps': '27.7005,85.3338',
    },
    // Route 2
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2A',
      'name': 'Outlet 2A-1',
      'contact': '9800000011',
      'category': 'Wholesale',
      'owner': 'Owner 2A-1',
      'gps': '27.7010,85.3340',
    },
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2A',
      'name': 'Outlet 2A-2',
      'contact': '9800000012',
      'category': 'Wholesale',
      'owner': 'Owner 2A-2',
      'gps': '27.7011,85.3341',
    },
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2A',
      'name': 'Outlet 2A-3',
      'contact': '9800000013',
      'category': 'Wholesale',
      'owner': 'Owner 2A-3',
      'gps': '27.7012,85.3342',
    },
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2B',
      'name': 'Outlet 2B-1',
      'contact': '9800000014',
      'category': 'Wholesale',
      'owner': 'Owner 2B-1',
      'gps': '27.7013,85.3343',
    },
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2B',
      'name': 'Outlet 2B-2',
      'contact': '9800000015',
      'category': 'Wholesale',
      'owner': 'Owner 2B-2',
      'gps': '27.7014,85.3344',
    },
    {
      'routeId': 2,
      'routeName': 'Route 2',
      'location': 'Location 2B',
      'name': 'Outlet 2B-3',
      'contact': '9800000016',
      'category': 'Wholesale',
      'owner': 'Owner 2B-3',
      'gps': '27.7015,85.3345',
    },
    // Route 3
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3A',
      'name': 'Outlet 3A-1',
      'contact': '9800000021',
      'category': 'Retail',
      'owner': 'Owner 3A-1',
      'gps': '27.7020,85.3350',
    },
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3A',
      'name': 'Outlet 3A-2',
      'contact': '9800000022',
      'category': 'Retail',
      'owner': 'Owner 3A-2',
      'gps': '27.7021,85.3351',
    },
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3A',
      'name': 'Outlet 3A-3',
      'contact': '9800000023',
      'category': 'Retail',
      'owner': 'Owner 3A-3',
      'gps': '27.7022,85.3352',
    },
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3B',
      'name': 'Outlet 3B-1',
      'contact': '9800000024',
      'category': 'Retail',
      'owner': 'Owner 3B-1',
      'gps': '27.7023,85.3353',
    },
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3B',
      'name': 'Outlet 3B-2',
      'contact': '9800000025',
      'category': 'Retail',
      'owner': 'Owner 3B-2',
      'gps': '27.7024,85.3354',
    },
    {
      'routeId': 3,
      'routeName': 'Route 3',
      'location': 'Location 3B',
      'name': 'Outlet 3B-3',
      'contact': '9800000026',
      'category': 'Retail',
      'owner': 'Owner 3B-3',
      'gps': '27.7025,85.3355',
    },
  ],
};

// --- Nimesh Subedi Routes ---
final List<Map<String, String>> nimeshRoutes = [
  {'routeName': 'Airport-Tilganga', 'location': 'Airport', 'zone': '3'},
  {'routeName': 'Airport-Tilganga', 'location': 'Tilganga', 'zone': '3'},
  {'routeName': 'Anamnagar-Thapagaun', 'location': 'Anamnagar', 'zone': '3'},
  {'routeName': 'Anamnagar-Thapagaun', 'location': 'Thapagaun', 'zone': '3'},
  {
    'routeName': 'Battisputali-Old Baneshwor',
    'location': 'Battisputali',
    'zone': '3',
  },
  {
    'routeName': 'Battisputali-Old Baneshwor',
    'location': 'Old Baneshwor',
    'zone': '3',
  },
  // ... (add more from your list as needed)
];

// --- Nimesh Subedi Outlets (sample, fill/expand as needed) ---
final List<Map<String, dynamic>> nimeshOutlets = [
  {
    'name': 'Airport Mart',
    'location': 'Airport',
    'route': 'Airport-Tilganga',
    'zone': '3',
    'contact': '9801111111',
    'pan': '123456',
    'category': 'Retail',
    'class': 'A+',
    'address': 'Airport Road',
    'contactPerson': 'Suman Shrestha',
    'altMobile': '9801111122',
    'remarks': 'Frequent flyer customers',
    'assignedTo': 'Nimesh Subedi',
    'contactPersonUpdated': 'false',
    'mobileUpdated': 'false',
    'altMobileUpdated': 'false',
    'latitude': 27.6975, // Example GPS
    'longitude': 85.3591,
  },
  {
    'name': 'Tilganga Store',
    'location': 'Tilganga',
    'route': 'Airport-Tilganga',
    'zone': '3',
    'contact': '9802222222',
    'pan': '654321',
    'category': 'Wholesale',
    'class': 'B',
    'address': 'Tilganga Marg',
    'contactPerson': 'Rita Lama',
    'altMobile': '',
    'remarks': '',
    'assignedTo': 'Nimesh Subedi',
    'contactPersonUpdated': 'false',
    'mobileUpdated': 'false',
    'altMobileUpdated': 'false',
    'latitude': 27.6980, // Example GPS
    'longitude': 85.3600,
  },
];

// --- PJP Plan and Visit Status Data Structures ---
// Map of date string (yyyy-MM-dd) to list of outlet names for that day's plan
Map<String, List<String>> pjpPlans = {};
// Map of 'date|outletName' to visit status (true/false)
Map<String, bool> pjpVisitStatus = {};
