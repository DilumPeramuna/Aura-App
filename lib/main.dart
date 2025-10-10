import 'package:aura1/Screens/CartScreen.dart';
import 'package:aura1/Screens/HomeScreen.dart';
import 'package:aura1/Screens/products_page.dart';
import 'package:aura1/Screens/ContactUsScreen.dart';
import 'package:aura1/Screens/AboutUsScreen.dart';
import 'package:aura1/Screens/loginScreen.dart';
import 'package:aura1/Screens/signupScreen.dart';
import 'package:aura1/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
 
  const Wrapper({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late int selectedItem;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialIndex; 
    screens = const [
      Homescreen(),
      ProductsPage(),
      ContactUsScreen(),
      AboutUsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("AURA"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: colorScheme.onSurface),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart, color: colorScheme.onSurface),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: screens[selectedItem]),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedItem,
        onTap: (value) => setState(() => selectedItem = value),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.email_outlined), label: 'Contact Us'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About Us'),
        ],
      ),
    );
  }
}
