import 'dart:async';
import 'package:aura1/Screens/ProductDetailPage.dart';
// import 'package:aura1/Screens/products_page.dart';
import 'package:aura1/components/footer.dart';
import 'package:flutter/material.dart';
import 'package:aura1/main.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  late Timer _timer;

  final List<String> _heroImages = [
    "assets/images/bracelets.jpg",
    "assets/images/green ear.jpg",
    "assets/images/ring3.webp",
  ];

  final List<Map<String, String>> featuredProducts = [
    {
      "image": "assets/images/b1.webp",
      "name": "Aurora Diamond Bangle",
      "price": "\$2,589",
      "description":
          "A beautifully crafted diamond bangle that radiates luxury and grace. Perfect for elegant occasions."
    },
    {
      "image": "assets/images/n1.webp",
      "name": "Aphrodite Diamond Necklace",
      "price": "\$3,200",
      "description":
          "This timeless necklace sparkles with premium-cut diamonds, symbolizing love and eternity."
    },
    {
      "image": "assets/images/r1.webp",
      "name": "Marilyn Silver Ring",
      "price": "\$2,449",
      "description":
          "A refined silver ring with a sleek modern design, ideal for daily wear or gifting."
    },
    {
      "image": "assets/images/n2.webp",
      "name": "Starry Night Necklace",
      "price": "\$2,499",
      "description":
          "Deep blue sapphire surrounded by dazzling stones — a true statement of elegance."
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _heroImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    
    const desktopW = 1100.0;

    
    final double heroHeight =
        width >= desktopW ? 420 : (width >= 800 ? 320 : 250);

    
    const double maxContentWidth = 1200;

    
    final double titleSize = width >= desktopW ? 34 : (width >= 800 ? 30 : 28);
    final EdgeInsets contentHPadding =
        width >= desktopW ? const EdgeInsets.symmetric(horizontal: 40, vertical: 40)
        : width >= 800 ? const EdgeInsets.symmetric(horizontal: 30, vertical: 40)
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 40);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               
                if (width >= desktopW)
                  
                  Container(
                    height: heroHeight,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Timeless Pieces, Honestly Sourced.',
                                  style: TextStyle(
                                    fontSize: titleSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Playfair",
                                    color: colorScheme.onSurface,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  "Explore our curated collections of handcrafted jewelry, each featuring an authentic Sri Lankan gemstone with a story to tell.",
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1.6,
                                    color: colorScheme.onSurface.withOpacity(0.7),
                                    fontFamily: "Roboto",
                                  ),
                                ),
                                const SizedBox(height: 26),
                                ElevatedButton(
                                  onPressed: () {
                                    
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Wrapper(initialIndex: 1),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 56, vertical: 15),
                                    elevation: 6,
                                    shadowColor:
                                        colorScheme.primary.withOpacity(0.4),
                                  ),
                                  child: const Text(
                                    "Shop Now",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                     
                        Expanded(
                          flex: 7,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Stack(
                              fit: StackFit.expand,
                              children: _heroImages
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                final index = entry.key;
                                final image = entry.value;
                                return AnimatedOpacity(
                                  key: ValueKey(index),
                                  opacity: _currentImageIndex == index ? 1.0 : 0.0,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  
                  SizedBox(
                    height: heroHeight,
                    width: double.infinity,
                    child: Stack(
                      children: _heroImages.asMap().entries.map((entry) {
                        int index = entry.key;
                        String image = entry.value;
                        return AnimatedOpacity(
                          key: ValueKey(index),
                          opacity: _currentImageIndex == index ? 1.0 : 0.0,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

      
                if (width < desktopW)
                  Padding(
                    padding: contentHPadding,
                    child: Column(
                      children: [
                        Text(
                          'Timeless Pieces, Honestly Sourced.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Playfair",
                            color: colorScheme.onSurface,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Explore our curated collections of handcrafted jewelry, each featuring an authentic Sri Lankan gemstone with a story to tell.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width >= 800 ? 18 : 16,
                            height: 1.6,
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontFamily: "Roboto",
                          ),
                        ),
                        const SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () {
                            
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Wrapper(initialIndex: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 15),
                            elevation: 6,
                            shadowColor: colorScheme.primary.withOpacity(0.4),
                          ),
                          child: const Text(
                            "Shop Now",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                
                sectionTitle("Our Vision", colorScheme, width),
                sectionText(
                    "To become the world's most trusted online destination for authentic, handcrafted gemstone jewelry.",
                    colorScheme,
                    width),
                sectionTitle("Our Mission", colorScheme, width),
                sectionText(
                    "To deliver an exceptional experience that combines beautiful, modern design with the transparent story of our gemstones' origin.",
                    colorScheme,
                    width),

               
                sectionTitle("Pick of the Month", colorScheme, width),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width >= desktopW ? 20 : 10,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final crossAxisCount = w >= desktopW ? 4 : (w >= 800 ? 3 : 2);
                      final childAspectRatio =
                          w >= desktopW ? 0.82 : (w >= 800 ? 0.76 : 0.72);

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: featuredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final product = featuredProducts[index];
                          return buildProductCard(
                            context,
                            product["image"]!,
                            product["name"]!,
                            product["price"]!,
                            product["description"]!,
                            colorScheme,
                            w,
                          );
                        },
                      );
                    },
                  ),
                ),

                
                sectionTitle("The Aura Philosophy", colorScheme, width),
                sectionText(
                    "We believe true luxury lies in authenticity. That's why we partner with ethical suppliers in Sri Lanka to source only the finest natural gemstones.",
                    colorScheme,
                    width),

              
                sectionTitle("What Our Clients Say", colorScheme, width),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width >= desktopW ? 20 : 0),
                  child: Column(
                    children: [
                      testimonialCard(
                          "“The quality is simply exquisite. My ring is more beautiful than I could have imagined.”",
                          "Alexandra T.",
                          colorScheme),
                      testimonialCard(
                          "“Aura’s customer service was as brilliant as the sapphire I purchased.”",
                          "Benjamin L.",
                          colorScheme),
                      testimonialCard(
                          "“I was hesitant to buy fine jewelry online, but Aura made it seamless.”",
                          "Chloe R.",
                          colorScheme),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Widget sectionTitle(String text, ColorScheme colorScheme, double width) {
    final size = width >= 1100 ? 26 : 22;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.toDouble(),
          fontWeight: FontWeight.bold,
          fontFamily: "Playfair",
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget sectionText(String text, ColorScheme colorScheme, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width >= 1100 ? 60 : 20),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: width >= 1100 ? 17 : 16,
          height: 1.6,
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }


  Widget buildProductCard(
      BuildContext context,
      String image,
      String name,
      String price,
      String description,
      ColorScheme colorScheme,
      double gridWidth) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: AspectRatio(
              aspectRatio: 1.55,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: colorScheme.onSurface,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            price,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(
                    image: image,
                    name: name,
                    price: price,
                    description: description,
                  ),
                ),
              );
            },
            child: Text(
              "View",
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget testimonialCard(String text, String author, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "- $author",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
