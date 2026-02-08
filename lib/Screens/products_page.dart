import 'package:aura1/Screens/ProductDetailPage.dart';
import 'package:aura1/components/footer.dart';
import 'package:aura1/models/product_model.dart';
import 'package:aura1/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch products when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

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
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isLoading) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (productProvider.products.isEmpty) {
                     return const SizedBox(
                      height: 300,
                      child: Center(child: Text("No products found.")),
                    );
                  }

                  final products = productProvider.products;

                  return LayoutBuilder(
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
                            product,
                            colorScheme,
                          );
                        },
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
    Product product,
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
            child: Image.network(
              product.image, 
              fit: BoxFit.cover,
              errorBuilder: (ctx, error, stackTrace) => 
                  Container(color: Colors.grey[200], child: const Icon(Icons.broken_image)),
            ),
          ),

          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text(
                    product.name,
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
                    "\$${product.price.toStringAsFixed(2)}",
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
                              id: product.id,
                              images: [
                                product.image,
                                product.image1,
                                product.image2,
                                product.image3,
                              ].where((i) => i != null).whereType<String>().toList(), 
                              name: product.name,
                              price: "\$${product.price.toStringAsFixed(2)}",
                              description: product.description,
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
