import 'package:flutter/material.dart';
import 'package:aura1/components/footer.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gems1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Contact AURA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: "Playfair",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "We’d love to hear from you. Send us a message and our team will get back to you within one business day.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 1000;

                
                Widget constrained(Widget child) => Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: child,
                      ),
                    );

                if (!isDesktop) {

                  return Column(
                    children: [
                    
                      constrained(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Send Us a Message",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Playfair",
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 25),

                              _buildTextField(
                                label: "Full Name",
                                icon: Icons.person_outline,
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(height: 15),

                              _buildTextField(
                                label: "Email Address",
                                icon: Icons.email_outlined,
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(height: 15),

                              _buildTextField(
                                label: "Phone Number (Optional)",
                                icon: Icons.phone_outlined,
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(height: 15),

                              _buildTextField(
                                label: "Your Message",
                                icon: Icons.message_outlined,
                                maxLines: 5,
                                colorScheme: colorScheme,
                              ),
                              const SizedBox(height: 25),

                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Message Sent Successfully!"),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 15),
                                  elevation: 6,
                                  shadowColor:
                                      colorScheme.primary.withOpacity(0.4),
                                ),
                                child: const Text(
                                  "Send Message",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),
                              Text(
                                "Thank you for taking the time to reach out. We value your thoughts and feedback — every message helps us grow.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                   
                      constrained(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Text(
                                "Other Ways to Reach Us",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Playfair",
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),

                              infoTile(
                                Icons.email_outlined,
                                "support@aura.com",
                                "For inquiries, returns, and product support.",
                                colorScheme,
                              ),
                              const SizedBox(height: 15),
                              infoTile(
                                Icons.phone_outlined,
                                "+94 76 123 4567",
                                "Available 9 AM – 6 PM, Monday to Saturday.",
                                colorScheme,
                              ),
                              const SizedBox(height: 15),
                              infoTile(
                                Icons.location_on_outlined,
                                "Colombo, Sri Lanka",
                                "Our headquarters and design studio.",
                                colorScheme,
                              ),
                              const SizedBox(height: 15),
                              infoTile(
                                Icons.access_time,
                                "Office Hours",
                                "Monday - Friday: 9:00 AM to 6:00 PM\nSaturday: 9:00 AM to 3:00 PM\nSunday: Closed",
                                colorScheme,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      
                      constrained(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Text(
                                "Follow Us",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Playfair",
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  socialIcon(Icons.facebook, colorScheme),
                                  const SizedBox(width: 20),
                                  socialIcon(
                                      Icons.camera_alt_outlined, colorScheme),
                                  const SizedBox(width: 20),
                                  socialIcon(Icons.work_outline, colorScheme),
                                  const SizedBox(width: 20),
                                  socialIcon(
                                      Icons.play_circle_outline, colorScheme),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),

                    
                      constrained(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Text(
                                "Find Us on Map",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Playfair",
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _mapPreview(colorScheme),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),
                    ],
                  );
                }

              
                return constrained(
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Send Us a Message",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Playfair",
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 20),

                             
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        label: "Full Name",
                                        icon: Icons.person_outline,
                                        colorScheme: colorScheme,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildTextField(
                                        label: "Email Address",
                                        icon: Icons.email_outlined,
                                        colorScheme: colorScheme,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildTextField(
                                        label: "Phone Number (Optional)",
                                        icon: Icons.phone_outlined,
                                        colorScheme: colorScheme,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildTextField(
                                        label: "Your Message",
                                        icon: Icons.message_outlined,
                                        maxLines: 5,
                                        colorScheme: colorScheme,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Message Sent Successfully!"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 42, vertical: 14),
                                      elevation: 6,
                                      shadowColor:
                                          colorScheme.primary.withOpacity(0.4),
                                    ),
                                    child: const Text(
                                      "Send Message",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),
                                Text(
                                  "Thank you for taking the time to reach out. We value your thoughts and feedback — every message helps us grow.",
                                  style: TextStyle(
                                    color:
                                        colorScheme.onSurface.withOpacity(0.7),
                                    fontSize: 13.5,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 24),

                      
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 14,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Other Ways to Reach Us",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "Playfair",
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 18),

                                    infoTile(
                                      Icons.email_outlined,
                                      "support@aura.com",
                                      "For inquiries, returns, and product support.",
                                      colorScheme,
                                    ),
                                    const SizedBox(height: 12),
                                    infoTile(
                                      Icons.phone_outlined,
                                      "+94 76 123 4567",
                                      "Available 9 AM – 6 PM, Monday to Saturday.",
                                      colorScheme,
                                    ),
                                    const SizedBox(height: 12),
                                    infoTile(
                                      Icons.location_on_outlined,
                                      "Colombo, Sri Lanka",
                                      "Our headquarters and design studio.",
                                      colorScheme,
                                    ),
                                    const SizedBox(height: 12),
                                    infoTile(
                                      Icons.access_time,
                                      "Office Hours",
                                      "Monday - Friday: 9:00 AM to 6:00 PM\nSaturday: 9:00 AM to 3:00 PM\nSunday: Closed",
                                      colorScheme,
                                    ),

                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        socialIcon(Icons.facebook, colorScheme),
                                        const SizedBox(width: 14),
                                        socialIcon(Icons.camera_alt_outlined,
                                            colorScheme),
                                        const SizedBox(width: 14),
                                        socialIcon(
                                            Icons.work_outline, colorScheme),
                                        const SizedBox(width: 14),
                                        socialIcon(Icons.play_circle_outline,
                                            colorScheme),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      blurRadius: 14,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: _mapPreview(colorScheme),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          
            const SizedBox(height: 60),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

 
  static Widget _buildTextField({
    required String label,
    required IconData icon,
    required ColorScheme colorScheme,
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: colorScheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        filled: true,
        fillColor: colorScheme.surface,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.2),
            width: 1,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }


  static Widget infoTile(
      IconData icon, String title, String subtitle, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary, size: 26),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  
  static Widget socialIcon(IconData icon, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: colorScheme.primary, size: 24),
    );
  }

  
  Widget _mapPreview(ColorScheme colorScheme) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          image: AssetImage("assets/images/map.png"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          "Map Location Preview",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
