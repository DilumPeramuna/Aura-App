import 'package:aura1/Screens/ProductDetailPage.dart';
import 'package:aura1/components/footer.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  final List<Map<String, String>> products = const [
    {
      "image": "assets/images/b2.webp",
      "name": "Aurora Diamond Bangle",
      "price": "\$2,589",
      "description":
          "A beautifully crafted diamond bangle that radiates luxury and grace. Perfect for elegant occasions."
    },
    {
      "image": "assets/images/n3.webp",
      "name": "Aphrodite Diamond Necklace",
      "price": "\$3,200",
      "description":
          "This timeless necklace sparkles with premium-cut diamonds, symbolizing love and eternity."
    },
    {
      "image": "assets/images/r2.webp",
      "name": "Marilyn Silver Ring",
      "price": "\$2,449",
      "description":
          "A refined silver ring with a sleek modern design, ideal for daily wear or gifting."
    },
    {
      "image": "assets/images/n3.webp",
      "name": "Starry Night Sapphire Necklace",
      "price": "\$2,499",
      "description":
          "Deep blue sapphire surrounded by dazzling stones — a true statement of elegance."
    },
    {
      "image": "assets/images/green ear.jpg",
      "name": "Emerald Elegance Earrings",
      "price": "\$1,899",
      "description":
          "Elegant emerald earrings with a radiant green hue that adds sophistication to any outfit."
    },
    {
      "image": "assets/images/ring3.webp",
      "name": "Celestial Ruby Ring",
      "price": "\$2,799",
      "description":
          "A fiery ruby centerpiece ring that captures the brilliance of the cosmos in fine craftsmanship."
    },
    {
      "image": "assets/images/bracelets.jpg",
      "name": "Golden Aura Bracelet",
      "price": "\$2,099",
      "description":
          "Delicately designed gold bracelet symbolizing warmth, strength, and timeless charm."
    },
    {
      "image": "assets/images/b1.webp",
      "name": "Moonlight Pearl Bracelet",
      "price": "\$3,450",
      "description":
          "Elegant pearls that shimmer with every movement, inspired by the tranquility of moonlight."
    },
    {
      "image": "assets/images/n2.webp",
      "name": "Blue Topaz Gemstone Necklace",
      "price": "\$2,799",
      "description":
          "Captivating topaz gemstone pendant that embodies serenity, purity, and radiant blue beauty."
    },
    {
      "image": "assets/images/r1.webp",
      "name": "Royal Onyx Men's Ring",
      "price": "\$2,299",
      "description":
          "Bold and masculine, this onyx ring exudes power and sophistication in every detail."
    },
    {
      "image": "assets/images/b2.webp",
      "name": "Map of Love Bracelet",
      "price": "\$1,499",
      "description":
          "A minimalist pendant engraved with a global map design — symbolizing unity and connection."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Our Exclusive Collection",
          style: TextStyle(
            fontFamily: "Playfair",
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  
                  final double w = constraints.maxWidth;
                  final int crossAxisCount =
                      w >= 1100 ? 4 : (w >= 700 ? 3 : 2);

                  
                  final double childAspectRatio =
                      w >= 1100 ? 0.88 : (w >= 700 ? 0.78 : 0.62);

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(
                        context,
                        product["image"]!,
                        product["name"]!,
                        product["price"]!,
                        product["description"]!,
                        colorScheme,
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String image,
    String name,
    String price,
    String description,
    ColorScheme colorScheme,
  ) {
    return Card(
      color: colorScheme.surface,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          AspectRatio(
            aspectRatio: 1.5, 
            child: Image.asset(image, fit: BoxFit.cover),
          ),

          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto",
                      color: colorScheme.onSurface,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: colorScheme.primary.withOpacity(0.3),
                      ),
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
