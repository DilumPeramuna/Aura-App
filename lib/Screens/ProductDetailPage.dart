import 'package:aura1/services/network_service.dart'; // Import NetworkService
import 'package:flutter/material.dart';
import 'package:aura1/components/cart_data.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final List<String> images;
  final String name;
  final String price;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.images,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.images.isNotEmpty
        ? widget.images.first
        : 'https://via.placeholder.com/300';
  }

  Widget _buildImage(String path, {double? height, double? width, BoxFit? fit}) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          width: width,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    } else {
      return Image.asset(
        path,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          width: width,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;

          Widget bounded(Widget child) => Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: child,
                  ),
                ),
              );

          if (!isDesktop) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: widget.images.isNotEmpty ? widget.images.first : widget.name,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: _buildImage(
                        selectedImage,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Gallery Thumbnails
                  if (widget.images.length > 1)
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.images.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final img = widget.images[index];
                          final isSelected = selectedImage == img;
                          return GestureDetector(
                            onTap: () => setState(() => selectedImage = img),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: isSelected
                                    ? Border.all(
                                        color: colorScheme.primary, width: 2)
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildImage(img, fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontFamily: "Playfair",
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: colorScheme.onSurface.withOpacity(0.8),
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Check network connection first
                        bool isConnected = await NetworkService.checkConnection(context);
                        if (!isConnected) return;

                        cartItems.add({
                          'id': widget.id.toString(), // Add ID
                          'image': widget.images.isNotEmpty ? widget.images.first : '',
                          'name': widget.name,
                          'price': widget.price,
                          'quantity': '1', // Add Quantity
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("🛒 Added to cart"),
                            backgroundColor: colorScheme.primary,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 6,
                        shadowColor: colorScheme.primary.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            );
          }

          // DESKTOP LAYOUT
          return bounded(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Card(
                        color: colorScheme.surface,
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        clipBehavior: Clip.antiAlias,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Hero(
                            tag: widget.images.isNotEmpty
                                ? widget.images.first
                                : widget.name,
                            child: _buildImage(selectedImage, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Desktop Gallery Thumbnails
                      if (widget.images.length > 1)
                        SizedBox(
                          height: 100,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.images.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 15),
                            itemBuilder: (context, index) {
                              final img = widget.images[index];
                              final isSelected = selectedImage == img;
                              return GestureDetector(
                                onTap: () => setState(() => selectedImage = img),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: isSelected
                                        ? Border.all(
                                            color: colorScheme.primary, width: 3)
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: _buildImage(img, fit: BoxFit.cover),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border.all(
                        color: colorScheme.onSurface.withOpacity(0.08),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            fontFamily: "Playfair",
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.price,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(
                          color: colorScheme.onSurface.withOpacity(0.12),
                          height: 1,
                          thickness: 1,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.7,
                            color: colorScheme.onSurface.withOpacity(0.85),
                            fontFamily: "Roboto",
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: 280,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Check network connection first
                              bool isConnected = await NetworkService.checkConnection(context);
                              if (!isConnected) return;

                              cartItems.add({
                                'id': widget.id.toString(),
                                'image': widget.images.isNotEmpty
                                    ? widget.images.first
                                    : '',
                                'name': widget.name,
                                'price': widget.price,
                                'quantity': '1',
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("🛒 Added to cart"),
                                  backgroundColor: colorScheme.primary,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                              elevation: 6,
                              shadowColor: colorScheme.primary.withOpacity(0.35),
                            ),
                            child: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
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
        },
      ),
    );
  }
}

