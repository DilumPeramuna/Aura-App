import 'package:flutter/material.dart';
import 'package:aura1/components/footer.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- HERO SECTION ----------
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 1000;
                final heroHeight = isDesktop ? 340.0 : 250.0;

                return Stack(
                  children: [
                    Container(
                      height: heroHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/g4.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: heroHeight,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "About AURA",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Playfair",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Every piece tells a story — one of craftsmanship, honesty, and timeless beauty.",
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
                );
              },
            ),

            const SizedBox(height: 40),

            
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth >= 1000;

                
                Widget bounded(Widget child) => Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: child,
                        ),
                      ),
                    );

                if (!isDesktop) {
                  
                  return Column(
                    children: [
                      // HOW IT STARTED
                      bounded(
                        Column(
                          children: [
                            sectionTitle("How It Started", colorScheme),
                            const SizedBox(height: 15),
                            sectionText(
                              "Aura began as a small atelier founded by Dilum Peramuna, a gem enthusiast who grew up among the vibrant gem markets of Ratnapura. What started as a passion for collecting unique stones evolved into a commitment to creating timeless jewellery — blending Sri Lankan heritage with modern design.",
                              colorScheme,
                            ),
                            const SizedBox(height: 12),
                            quoteText(
                              "“We don’t chase trends. We refine essentials—well-made pieces that carry stories.”",
                              colorScheme,
                            ),
                            const SizedBox(height: 25),
                            roundedImage("assets/images/gems1.jpg"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      // ETHICAL SOURCING
                      bounded(
                        Column(
                          children: [
                            sectionTitle("Ethical, Transparent Sourcing", colorScheme),
                            const SizedBox(height: 15),
                            sectionText(
                              "We work directly with responsible mines and trusted lapidarists across Sri Lanka. Each gemstone is handpicked for clarity, colour, and character. Transparency isn’t our selling point — it’s our standard.",
                              colorScheme,
                            ),
                            const SizedBox(height: 25),
                            roundedImage("assets/images/g4.jpg"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      
                      bounded(
                        Column(
                          children: [
                            sectionTitle("Crafted to Last", colorScheme),
                            const SizedBox(height: 15),
                            sectionText(
                              "In our Colombo atelier, master artisans hand-set each stone in precious metals like gold, silver, and bronze — balancing durability with delicate detail. Every piece is meticulously tested and finished to perfection.",
                              colorScheme,
                            ),
                            const SizedBox(height: 25),
                            roundedImage("assets/images/making gold.webp"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 50),

                      
                      Container(
                        color: colorScheme.surface.withOpacity(0.05),
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
                        child: LayoutBuilder(
                          builder: (context, c) {
                            
                            final spacing = 15.0;
                            final columns = c.maxWidth >= 520 ? 2 : 1;
                            final cardWidth =
                                (c.maxWidth - (columns - 1) * spacing) / columns;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                sectionTitle("Our Values", colorScheme),
                                const SizedBox(height: 25),
                                Wrap(
                                  spacing: spacing,
                                  runSpacing: spacing,
                                  children: [
                                    SizedBox(
                                      width: cardWidth,
                                      child: valueCard(
                                        "100% Natural",
                                        "Only untreated, responsibly sourced gemstones.",
                                        colorScheme,
                                      ),
                                    ),
                                    SizedBox(
                                      width: cardWidth,
                                      child: valueCard(
                                        "Made in LK",
                                        "Designed and handcrafted in Sri Lanka.",
                                        colorScheme,
                                      ),
                                    ),
                                    SizedBox(
                                      width: cardWidth,
                                      child: valueCard(
                                        "Lifetime Care",
                                        "Free cleaning and resizing within one year.",
                                        colorScheme,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 50),

                      // PROMISE
                      bounded(
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              sectionTitle("Our Promise", colorScheme),
                              const SizedBox(height: 12),
                              sectionText(
                                "Every AURA piece is built to be worn, cherished, and passed on. If your jewellery ever needs attention, our team will make it right.",
                                colorScheme,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 60),
                      const FooterWidget(),
                    ],
                  );
                }

                
                return Column(
                  children: [
                    
                    bounded(
                      _DesktopSectionRow(
                        colorScheme: colorScheme,
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionTitle("How It Started", colorScheme),
                            const SizedBox(height: 16),
                            sectionText(
                              "Aura began as a small atelier founded by Dilum Peramuna, a gem enthusiast who grew up among the vibrant gem markets of Ratnapura. What started as a passion for collecting unique stones evolved into a commitment to creating timeless jewellery — blending Sri Lankan heritage with modern design.",
                              colorScheme,
                            ),
                            const SizedBox(height: 16),
                            quoteText(
                              "“We don’t chase trends. We refine essentials—well-made pieces that carry stories.”",
                              colorScheme,
                            ),
                          ],
                        ),
                        right: roundedImage("assets/images/gems1.jpg"),
                      ),
                    ),

                    const SizedBox(height: 40),

                    
                    bounded(
                      _DesktopSectionRow(
                        colorScheme: colorScheme,
                        reverse: true,
                        left: roundedImage("assets/images/g4.jpg"),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionTitle("Ethical, Transparent Sourcing", colorScheme),
                            const SizedBox(height: 16),
                            sectionText(
                              "We work directly with responsible mines and trusted lapidarists across Sri Lanka. Each gemstone is handpicked for clarity, colour, and character. Transparency isn’t our selling point — it’s our standard.",
                              colorScheme,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    
                    bounded(
                      _DesktopSectionRow(
                        colorScheme: colorScheme,
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sectionTitle("Crafted to Last", colorScheme),
                            const SizedBox(height: 16),
                            sectionText(
                              "In our Colombo atelier, master artisans hand-set each stone in precious metals like gold, silver, and bronze — balancing durability with delicate detail. Every piece is meticulously tested and finished to perfection.",
                              colorScheme,
                            ),
                          ],
                        ),
                        right: roundedImage("assets/images/making gold.webp"),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // VALUES (3 cards in a row, elevated container)
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
                          decoration: BoxDecoration(
                            color: colorScheme.surface.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              sectionTitle("Our Values", colorScheme),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 12),
                                      child: valueCard(
                                        "100% Natural",
                                        "Only untreated, responsibly sourced gemstones.",
                                        colorScheme,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: valueCard(
                                        "Made in LK",
                                        "Designed and handcrafted in Sri Lanka.",
                                        colorScheme,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: valueCard(
                                        "Lifetime Care",
                                        "Free cleaning and resizing within one year.",
                                        colorScheme,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // OUR PROMISE (centered card)
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 28),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              sectionTitle("Our Promise", colorScheme),
                              const SizedBox(height: 12),
                              sectionText(
                                "Every AURA piece is built to be worn, cherished, and passed on. If your jewellery ever needs attention, our team will make it right.",
                                colorScheme,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                    const FooterWidget(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  
  static Widget sectionTitle(String title, ColorScheme colorScheme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontFamily: "Playfair",
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      textAlign: TextAlign.left,
    );
  }

  
  static Widget sectionText(String text, ColorScheme colorScheme) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.7),
        fontSize: 14.5,
        height: 1.6,
      ),
    );
  }

 
  static Widget quoteText(String quote, ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: colorScheme.onSurface.withOpacity(0.2),
            width: 2,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        quote,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorScheme.onSurface,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  
  static Widget roundedImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }


  static Widget valueCard(String title, String subtitle, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Playfair",
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.7),
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}


class _DesktopSectionRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  final bool reverse;
  final ColorScheme colorScheme;

  const _DesktopSectionRow({
    required this.left,
    required this.right,
    required this.colorScheme,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: left,
        ),
      ),
      Expanded(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: right,
        ),
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: reverse ? children.reversed.toList() : children,
    );
  }
}
