import 'package:flutter/material.dart';
import 'package:aura1/main.dart';
import 'package:provider/provider.dart';
import 'package:aura1/providers/auth_provider.dart';
import 'package:aura1/components/footer.dart';
import 'package:aura1/Screens/signupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Wrapper()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontFamily: "Playfair",
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign in to view your orders and saved items.",
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Expanded(child: loginCard(context, colorScheme)),
                        const SizedBox(width: 25),
                        
                        Expanded(child: infoCard(colorScheme)),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        loginCard(context, colorScheme),
                        const SizedBox(height: 25),
                        infoCard(colorScheme),
                      ],
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 60),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email", style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
          const SizedBox(height: 6),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "you@example.com",
              hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: colorScheme.surface,
            ),
          ),
          const SizedBox(height: 18),
          Text("Password", style: TextStyle(fontWeight: FontWeight.w500, color: colorScheme.onSurface)),
          const SizedBox(height: 6),
          TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(color: colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "********",
              hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: colorScheme.primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: colorScheme.surface,
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Consumer<AuthProvider>(
              builder: (context, auth, _) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 6,
                    shadowColor: colorScheme.primary.withOpacity(0.4),
                  ),
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          final success = await auth.login(
                            _emailController.text,
                            _passwordController.text,
                          );

                          if (success && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Wrapper()),
                            );
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login failed. Check credentials.")),
                            );
                          }
                        },
                  child: auth.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "New to AURA? ",
                  style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  children: [
                    TextSpan(
                      text: "Create an account",
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Jewellery, Your Story",
            style: TextStyle(
              fontFamily: "Playfair",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Access your order history, manage addresses, and save your favourite pieces. Every account includes priority support and early access to new collections.",
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const BulletPoint(text: "Fast checkout with saved details"),
          const BulletPoint(text: "Order tracking & updates"),
          const BulletPoint(text: "Wishlists and back-in-stock alerts (soon)"),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: TextStyle(fontSize: 18, color: colorScheme.onSurface.withOpacity(0.7))),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
