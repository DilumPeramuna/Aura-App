import 'package:aura1/Screens/loginScreen.dart';
import 'package:aura1/main.dart';
import 'package:aura1/components/footer.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool showPassword = false;
  bool showConfirmPassword = false;

  void _signUp() {
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Account Created Successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Wrapper()),
      );
    });
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

            // ---------- HEADER ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new,
                        color: colorScheme.onSurface),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Wrapper()),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontFamily: "Playfair",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ---------- SIGNUP SECTION ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: signUpCard(colorScheme)),
                        const SizedBox(width: 25),
                        const Expanded(child: InfoCard()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        signUpCard(colorScheme),
                        const SizedBox(height: 25),
                        const InfoCard(),
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

  Widget signUpCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel("Full Name", colorScheme),
          buildTextField(
            controller: fullNameController,
            hint: "Full Name",
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 18),
          buildLabel("Email", colorScheme),
          buildTextField(
            controller: emailController,
            hint: "you@example.com",
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 18),
          buildLabel("Password", colorScheme),
          buildTextField(
            controller: passwordController,
            hint: "Minimum 8 characters",
            obscure: !showPassword,
            toggleObscure: () =>
                setState(() => showPassword = !showPassword),
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 18),
          buildLabel("Confirm Password", colorScheme),
          buildTextField(
            controller: confirmPasswordController,
            hint: "Re-enter password",
            obscure: !showConfirmPassword,
            toggleObscure: () =>
                setState(() => showConfirmPassword = !showConfirmPassword),
            colorScheme: colorScheme,
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: _signUp,
              child: const Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  children: [
                    TextSpan(
                      text: "Sign in",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
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

  Widget buildLabel(String label, ColorScheme colorScheme) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
    VoidCallback? toggleObscure,
    required ColorScheme colorScheme,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withOpacity(0.5),
        ),
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
                onPressed: toggleObscure,
              )
            : null,
        filled: true,
        fillColor: colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Designed for Peace of Mind",
            style: TextStyle(
              fontFamily: "Playfair",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "We verify every gemstone’s origin and craftsmanship. Your account helps us personalise care and maintain records for services like resizing, repairs, and cleaning.",
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          BulletPoint(text: "Personalised recommendations"),
          BulletPoint(text: "Free cleaning within 1 year"),
          BulletPoint(text: "Priority support"),
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
        children: [
          Text(
            "• ",
            style: TextStyle(
              fontSize: 18,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
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
