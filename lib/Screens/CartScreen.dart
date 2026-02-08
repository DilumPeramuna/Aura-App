import 'package:aura1/Screens/checkout.dart';
import 'package:aura1/components/cart_data.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double getTotal() {
    double total = 0;
    for (var item in cartItems) {
      final price = item['price']!.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.tryParse(price) ?? 0;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotal();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Your Cart",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontFamily: "Playfair",
            letterSpacing: 0.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 48, color: colorScheme.onSurface.withOpacity(0.4)),
                  const SizedBox(height: 12),
                  Text(
                    "Your Cart is Empty",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                      fontFamily: "Playfair",
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Discover pieces crafted to last a lifetime.",
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.onSurface.withOpacity(0.06),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Curated Selections",
                        style: TextStyle(
                          fontFamily: "Playfair",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Timeless pieces, honestly sourced.",
                        style: TextStyle(
                          fontSize: 12.5,
                          letterSpacing: 0.2,
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                // Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colorScheme.onSurface.withOpacity(0.08),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                              child: item['image']!.startsWith('http')
                                  ? Image.network(
                                      item['image']!,
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 96,
                                        height: 96,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.broken_image,
                                            color: Colors.grey),
                                      ),
                                    )
                                  : Image.asset(
                                      item['image']!,
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 96,
                                        height: 96,
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.broken_image,
                                            color: Colors.grey),
                                      ),
                                    ),
                            ),

                            
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 12, 8, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name']!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: colorScheme.onSurface,
                                        fontSize: 15.5,
                                        height: 1.25,
                                        fontFamily: "Playfair",
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(Icons.diamond_rounded,
                                            size: 16,
                                            color: colorScheme.primary
                                                .withOpacity(0.9)),
                                        const SizedBox(width: 6),
                                        Text(
                                          item['price']!,
                                          style: TextStyle(
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                   
                                    Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            colorScheme.onSurface
                                                .withOpacity(0.04),
                                            colorScheme.onSurface
                                                .withOpacity(0.08),
                                            colorScheme.onSurface
                                                .withOpacity(0.04),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Complimentary polishing & care",
                                      style: TextStyle(
                                        fontSize: 12,
                                        letterSpacing: 0.2,
                                        color: colorScheme.onSurface
                                            .withOpacity(0.55),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 4),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(24),
                                  onTap: () {
                                    setState(() {
                                      cartItems.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.redAccent.withOpacity(0.2),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: colorScheme.onSurface.withOpacity(0.08),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Total
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.6),
                                fontSize: 12.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.primary,
                                fontFamily: "Playfair",
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Checkout button
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CheckoutScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.lock_outline, size: 18),
                        label: const Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 6,
                          shadowColor: colorScheme.primary.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
