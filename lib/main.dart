import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:intl/intl.dart';

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
    Center(child: Text('Home (Coming Soon)', style: TextStyle(fontSize: 18))),
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'PJP'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint),
            label: 'Check In',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Outlets'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class CheckInPage extends StatefulWidget {
  CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  final String userName = 'Prabin Prasain';
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
                Text(
                  NepaliDateFormat(
                    'yyyy-MM-dd',
                    Language.english,
                  ).format(NepaliDateTime.now()),
                  style: const TextStyle(fontSize: 16, color: Colors.black),
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
                            Text(
                              activity['date'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
                item['date'],
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
  OutletsPage({super.key});

  @override
  State<OutletsPage> createState() => _OutletsPageState();
}

class _OutletsPageState extends State<OutletsPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _outlets = [
    {
      'name': 'ABC Store',
      'location': 'Kathmandu',
      'contact': '9800000001',
      'pan': '123456',
      'category': 'Retail',
      'class': 'A+',
      'address': 'Kathmandu',
      'contactPerson': 'Ram Bahadur',
      'altMobile': '9800000009',
      'remarks': 'Good customer',
    },
    {
      'name': 'XYZ Mart',
      'location': 'Lalitpur',
      'contact': '9800000002',
      'pan': '654321',
      'category': 'Wholesale',
      'class': 'B',
      'address': 'Lalitpur',
      'contactPerson': 'Sita Kumari',
      'altMobile': '',
      'remarks': '',
    },
    {
      'name': 'DEF Shop',
      'location': 'Bhaktapur',
      'contact': '9800000003',
      'pan': '',
      'category': 'Retail',
      'class': 'A',
      'address': 'Bhaktapur',
      'contactPerson': '',
      'altMobile': '',
      'remarks': '',
    },
  ];

  String _searchText = '';

  TextEditingController _amountController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();
  TextEditingController _notThereRemarksController = TextEditingController();
  List<TextEditingController> _stockControllers = [];
  List<XFile> _images = [];
  bool? _onLocation = true;
  String? _notThereRemarks;
  String _selectedProduct = 'All';

  List<Map<String, String>> get _filteredOutlets {
    if (_searchText.isEmpty) return _outlets;
    return _outlets
        .where(
          (outlet) =>
              outlet['name']!.toLowerCase().contains(_searchText.toLowerCase()),
        )
        .toList();
  }

  void _openEditOutlet(Map<String, String> outlet) async {
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
    final newOutlet = await Navigator.push<Map<String, String>>(
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

  void showCheckInSheet(Map<String, String> outlet) {
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
                          void showCheckInSheet() {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (context) => OutletCheckInBottomSheet(
                                outlet: outlet,
                                amountController: _amountController,
                                remarksController: _remarksController,
                                notThereRemarksController:
                                    _notThereRemarksController,
                                stockControllers: _stockControllers,
                                images: _images,
                                onLocation: _onLocation,
                                notThereRemarks: _notThereRemarks,
                                selectedProduct: _selectedProduct,
                                onLocationChanged: (val) =>
                                    setState(() => _onLocation = val),
                                onNotThereRemarksChanged: (val) =>
                                    setState(() => _notThereRemarks = val),
                                onSelectedProductChanged: (val) =>
                                    setState(() => _selectedProduct = val),
                                onImagesChanged: (val) =>
                                    setState(() => _images = val),
                                onSubmit: _clearModalState,
                                onBack: _clearModalState,
                              ),
                            );
                          }

                          return GestureDetector(
                            onTap: showCheckInSheet,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
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
                                            outlet['name']!,
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
                                                  outlet['location']!,
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
                                        onTap: showCheckInSheet,
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
        child: const Icon(Icons.add),
        onPressed: _openAddOutlet,
      ),
    );
  }
}

class EditOutletPage extends StatefulWidget {
  final Map<String, String> outlet;
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Outlet updated (mock)')),
                    );
                  },
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
  PJPPage({super.key});

  @override
  State<PJPPage> createState() => _PJPPageState();
}

class _PJPPageState extends State<PJPPage> {
  final List<Map<String, String>> pjpList = [
    {'name': 'ABC Store', 'location': 'Kathmandu', 'contact': '9800000001'},
    {'name': 'XYZ Mart', 'location': 'Lalitpur', 'contact': '9800000002'},
    {'name': 'DEF Shop', 'location': 'Bhaktapur', 'contact': '9800000003'},
  ];
  NepaliDateTime selectedDate = NepaliDateTime.now();
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  TextEditingController _amountController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();
  TextEditingController _notThereRemarksController = TextEditingController();
  List<TextEditingController> _stockControllers = [];
  List<XFile> _images = [];
  bool? _onLocation = true;
  String? _notThereRemarks;
  String _selectedProduct = 'All';

  List<Map<String, String>> get _filteredPjpList {
    if (_searchText.isEmpty) return pjpList;
    return pjpList
        .where(
          (outlet) =>
              outlet['name']!.toLowerCase().contains(_searchText.toLowerCase()),
        )
        .toList();
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
    }
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
          'PJP Lists',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickDate,
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange, width: 1.5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          NepaliDateFormat(
                            'yyyy-MM-dd',
                            Language.english,
                          ).format(selectedDate),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: TextFormField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 16),
                  onChanged: (val) => setState(() => _searchText = val),
                  decoration: InputDecoration(
                    hintText: 'Search PJP',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
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
                child: _filteredPjpList.isEmpty
                    ? const Center(child: Text('No outlets found.'))
                    : ListView.separated(
                        itemCount: _filteredPjpList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final outlet = _filteredPjpList[index];
                          void showCheckInSheet() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PJPCheckInPage(
                                  outlet: outlet,
                                  amountController: _amountController,
                                  remarksController: _remarksController,
                                  notThereRemarksController:
                                      _notThereRemarksController,
                                  stockControllers: _stockControllers,
                                  images: _images,
                                  onLocation: _onLocation,
                                  notThereRemarks: _notThereRemarks,
                                  selectedProduct: _selectedProduct,
                                  onLocationChanged: (val) =>
                                      setState(() => _onLocation = val),
                                  onNotThereRemarksChanged: (val) =>
                                      setState(() => _notThereRemarks = val),
                                  onSelectedProductChanged: (val) =>
                                      setState(() => _selectedProduct = val),
                                  onImagesChanged: (val) =>
                                      setState(() => _images = val),
                                  onSubmit: _clearModalState,
                                  onBack: _clearModalState,
                                ),
                              ),
                            );
                          }

                          return GestureDetector(
                            onTap: showCheckInSheet,
                            child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
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
                                            outlet['name']!,
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
                                                  outlet['location']!,
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
                                        onTap: showCheckInSheet,
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
    );
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
}

class OutletCheckInBottomSheet extends StatefulWidget {
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
                              title: const Text('Reason for not being there'),
                              content: TextField(
                                controller: widget.notThereRemarksController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your remarks...',
                                ),
                                autofocus: true,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
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
                                      if (val != null)
                                        widget.onSelectedProductChanged(val);
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
                              _OutletStatRow(label: 'Total Stock', value: '0'),
                              _OutletStatRow(
                                label: 'Last Order Placed',
                                value: '- (-)',
                              ),
                              _OutletStatRow(
                                label: 'Due Amount',
                                value: 'NPR 0',
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Last Paid Amount',
                                value: 'NPR 0',
                                bold: true,
                              ),
                              _OutletStatRow(
                                label: 'Last Paid Date',
                                value: '- (-)',
                              ),
                              _OutletStatRow(
                                label: 'Last Visited',
                                value: '- (-)',
                              ),
                              _OutletStatRow(
                                label: 'Total Lifetime Orders',
                                value: '0',
                              ),
                              _OutletStatRow(
                                label: 'Total Sales in Amount',
                                value: 'NPR 0',
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
                  child: _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: widget.stockControllers,
                  ),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Order Management',
                  child: _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: widget.stockControllers,
                  ),
                ),
                const SizedBox(height: 16),
                _ExpandableSection(
                  title: 'Return',
                  child: Column(
                    children: [
                      _StockTable(
                        group1: 'Sarangi',
                        group2: 'Seto Bagh',
                        controllers: widget.stockControllers,
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
    this.bold = false,
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

class _ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  const _ExpandableSection({required this.title, required this.child});
  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: EdgeInsets.only(
        bottom: 8,
      ), // was EdgeInsets.symmetric(vertical: 8)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(padding: const EdgeInsets.all(12.0), child: widget.child),
        ],
      ),
    );
  }
}

class _StockTable extends StatefulWidget {
  final String group1;
  final String group2;
  final List<TextEditingController>? controllers;
  const _StockTable({
    this.group1 = 'Sarangi',
    this.group2 = 'Seto Bagh',
    this.controllers,
  });
  @override
  State<_StockTable> createState() => _StockTableState();
}

class _StockTableState extends State<_StockTable> {
  // Controllers for each product/size
  final Map<String, TextEditingController> _casesControllers = {};
  final Map<String, TextEditingController> _bottlesControllers = {};
  final Map<String, int> _caseToBottle = {
    '750ML': 12,
    '375ML': 24,
    '180ML': 48,
  };
  final List<String> sizes = ['750ML', '375ML', '180ML'];
  String? _currentlyEditing; // key of the field currently being edited

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

  @override
  void dispose() {
    for (final c in _casesControllers.values) {
      c.dispose();
    }
    for (final c in _bottlesControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TableRow _headerRow() => TableRow(
    decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
    children: [
      // Removed 'Product Name' header row
    ],
  );

  TableRow _groupHeader(String label) => TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, top: 12, bottom: 2),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ],
  );

  TableRow _dividerRow() => TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          height: 1,
          color: Color(0xFFE0E0E0),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          height: 1,
          color: Color(0xFFE0E0E0),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Container(
          margin: const EdgeInsets.only(top: 2, bottom: 2),
          height: 1,
          color: Color(0xFFE0E0E0),
        ),
      ),
    ],
  );

  TableRow _productRow(String group, String size) {
    final key = '${group}_$size';
    return TableRow(
      // Ensure vertical alignment for all cells
      decoration: null,
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: _tableCell(
            size,
            align: TextAlign.left,
            border: false,
            fontSize: 15,
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: _inputCell(_casesControllers[key]!, 'Cases'),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: _inputCell(_bottlesControllers[key]!, 'Bottles'),
        ),
      ],
    );
  }

  Widget _tableCell(
    String text, {
    bool bold = false,
    TextAlign align = TextAlign.center,
    bool border = false,
    bool header = false,
    double fontSize = 15,
  }) {
    return Container(
      alignment: align == TextAlign.left
          ? Alignment.centerLeft
          : Alignment.center,
      padding: EdgeInsets.symmetric(vertical: header ? 8 : 4, horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          color: Colors.black,
        ),
        textAlign: align,
      ),
    );
  }

  Widget _inputCell(TextEditingController controller, String hint) {
    return SizedBox(
      width: 70,
      height: 36,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7FA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontSize: 13,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 0,
            ),
          ),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        // _headerRow(), // Removed header row
        _groupHeader(widget.group1),
        ...[
          '750ML',
          '375ML',
          '180ML',
        ].map((size) => _productRow(widget.group1, size)),
        _dividerRow(),
        _groupHeader(widget.group2),
        ...[
          '750ML',
          '375ML',
          '180ML',
        ].map((size) => _productRow(widget.group2, size)),
      ],
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
                      const Text(
                        'Prabin Prasain',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sales Agent',
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
                  const Text(
                    'Prabin Prasain',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sales Agent',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _ProfileField(
              icon: Icons.phone,
              label: 'Mobile Number',
              value: '9800000000',
            ),
            _ProfileField(
              icon: Icons.badge,
              label: 'Role',
              value: 'Sales Agent',
            ),
            _ProfileField(
              icon: Icons.category,
              label: 'Category',
              value: 'Field Staff',
            ),
            _ProfileField(
              icon: Icons.people,
              label: 'Reports To',
              value: 'Bikash Shrestha',
            ),
            _ProfileField(
              icon: Icons.apartment,
              label: 'Zone',
              value: 'Bagmati',
            ),
            _ProfileField(
              icon: Icons.map,
              label: 'Area/Region',
              value: 'Kathmandu 2',
            ),
            _ProfileField(
              icon: Icons.home,
              label: 'Address',
              value: 'Baneshwor, KTM',
            ),
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
                          title: const Text('Reason for not being there'),
                          content: TextField(
                            controller: widget.notThereRemarksController,
                            decoration: const InputDecoration(
                              hintText: 'Enter your remarks...',
                            ),
                            autofocus: true,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
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
                                  if (val != null)
                                    widget.onSelectedProductChanged(val);
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
                          _OutletStatRow(label: 'Total Stock', value: '0'),
                          _OutletStatRow(
                            label: 'Last Order Placed',
                            value: '- (-)',
                          ),
                          _OutletStatRow(
                            label: 'Due Amount',
                            value: 'NPR 0',
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Last Paid Amount',
                            value: 'NPR 0',
                            bold: true,
                          ),
                          _OutletStatRow(
                            label: 'Last Paid Date',
                            value: '- (-)',
                          ),
                          _OutletStatRow(label: 'Last Visited', value: '- (-)'),
                          _OutletStatRow(
                            label: 'Total Lifetime Orders',
                            value: '0',
                          ),
                          _OutletStatRow(
                            label: 'Total Sales in Amount',
                            value: 'NPR 0',
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
              child: _StockTable(
                group1: 'Sarangi',
                group2: 'Seto Bagh',
                controllers: widget.stockControllers,
              ),
            ),
            const SizedBox(height: 16),
            _ExpandableSection(
              title: 'Order Management',
              child: _StockTable(
                group1: 'Sarangi',
                group2: 'Seto Bagh',
                controllers: widget.stockControllers,
              ),
            ),
            const SizedBox(height: 16),
            _ExpandableSection(
              title: 'Return',
              child: Column(
                children: [
                  _StockTable(
                    group1: 'Sarangi',
                    group2: 'Seto Bagh',
                    controllers: widget.stockControllers,
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
