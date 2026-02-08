import 'package:aura1/components/cart_data.dart';
import 'package:aura1/main.dart';
import 'package:aura1/providers/auth_provider.dart';
import 'package:aura1/services/api_service.dart';
import 'package:aura1/services/battery_service.dart'; // Import BatteryService
import 'package:aura1/services/location_service.dart'; // Import LocationService
import 'package:aura1/services/network_service.dart'; // Import NetworkService
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController addressController = TextEditingController();
  bool _isLoadingLocation = false;
  int _batteryLevel = -1; // Initialize battery level

  @override
  void initState() {
    super.initState();
    _checkBattery(); // Check battery on init
  }

  Future<void> _checkBattery() async {
    final batteryService = BatteryService();
    // Get level for display
    final level = await batteryService.getBatteryLevel();
    if (mounted) {
      setState(() {
        _batteryLevel = level;
      });
      // Check for low battery warning
      await batteryService.checkBatteryAndWarn(context);
    }
  }

  Future<void> _getCurrentLocation() async {
    // Check network connection first
    bool isConnected = await NetworkService.checkConnection(context);
    if (!isConnected) return;

    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position = await LocationService().getCurrentLocation();
      if (position != null) {
        final address = await LocationService().getAddressFromCoordinates(position);
        if (address != null) {
          setState(() {
            addressController.text = address;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Address updated from location!")),
          );
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Could not determine address from location.")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  double getTotal() {
    double total = 0;
    for (var item in cartItems) {
      final price = item['price']!.replaceAll(RegExp(r'[^\d.]'), '');
      total += double.tryParse(price) ?? 0;
    }
    return total;
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 56,
          height: 56,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 20),
        ),
      );
    } else {
      return Image.asset(
        path,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 56,
          height: 56,
          color: Colors.grey[200],
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 20),
        ),
      );
    }
  }

  Future<void> confirmOrder(BuildContext context) async {
    // Check network connection first
    bool isConnected = await NetworkService.checkConnection(context);
    if (!isConnected) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must be logged in to place an order."),
          backgroundColor: Colors.redAccent,
        ),
      );
      // Optional: Navigate to login if you have a direct route, 
      // or rely on user using the header/menu to login.
      // Given the current structure, let's guide them.
      // Since Wrapper controls the main view, we might need to pop to it?
      // But Checkout is likely pushed on top.
      return;
    }

    final colorScheme = Theme.of(context).colorScheme;
    final address = addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your delivery address."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final nameParts = (user?.name ?? 'Guest User').trim().split(' ');
    final firstName = nameParts.isNotEmpty ? nameParts.first : 'Guest';
    // Laravel 'required' fails on empty string. Ensure last name is not empty.
    final lastName = (nameParts.length > 1 && nameParts.last.isNotEmpty) 
        ? nameParts.sublist(1).join(' ') 
        : '-'; 

    final total = getTotal();
    final items = cartItems.map((item) {
      final priceString = item['price']!.replaceAll(RegExp(r'[^\d.]'), '');
      final price = double.tryParse(priceString) ?? 0.0;
      
      return {
        'id': item['id'],
        'name': item['name'],
        'quantity': item['quantity'],
        'price': price,
        'image': item['image'],
      };
    }).toList();

    final orderData = {
      'total_amount': total,
      'payment_method': 'COD',
      'first_name': firstName,
      'last_name': lastName,
      'email': user?.email ?? 'no-email@example.com',
      'street': address,
      'city': 'N/A', // Placeholder as UI input is single field
      'postal_code': '00000',
      'country': 'Sri Lanka',
      'items': items,
    };

    print("Sending Order Data: $orderData"); // Debug log

    final apiService = ApiService();
    final result = await apiService.createOrder(orderData);

    // Remove loading indicator
    Navigator.of(context).pop();

    print("Order Result: $result"); // Debug log

    if (result['success']) {
      cartItems.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("✅ Order Confirmed! Thank you for your purchase."),
          backgroundColor: colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const Wrapper()),
          (route) => false,
        );
      });
    } else {
      String errorMessage = result['message'] ?? "Failed to place order.";
      if (result['errors'] != null) {
        final errors = result['errors'] as Map<String, dynamic>;
        errorMessage += "\n\n";
        errors.forEach((key, value) {
          errorMessage += "$key: ${(value as List).join(', ')}\n";
        });
      }

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Order Failed"),
          content: SingleChildScrollView(
            child: Text(errorMessage),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = getTotal();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_batteryLevel != -1)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Icon(
                    _batteryLevel > 20 ? Icons.battery_full : Icons.battery_alert,
                    color: _batteryLevel > 20 ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$_batteryLevel%",
                    style: TextStyle(
                      color: colorScheme.onSurface, 
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        ],

      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 1000;

          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                "No items in cart!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            );
          }

        
          if (!isDesktop) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return Card(
                          color: colorScheme.surface,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _buildImage(item['image']!),
                            ),
                            title: Text(
                              item['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            subtitle: Text(
                              item['price']!,
                              style: TextStyle(color: colorScheme.primary),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 10),

                  // Location Button for Mobile
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoadingLocation ? null : _getCurrentLocation,
                      icon: _isLoadingLocation 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.my_location, color: Colors.white),
                      label: Text(
                        _isLoadingLocation ? "Detecting..." : "Use Current Location",
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary, // Use primary color
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Delivery Address",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter your full delivery address...",
                      filled: true,
                      fillColor: colorScheme.surface,
                      hintStyle:
                          TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Total: \$${total.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: ElevatedButton(
                      onPressed: () => confirmOrder(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        "Confirm Purchase",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }

          
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Summary",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            color: colorScheme.surface,
                            elevation: 4,
                            shadowColor: Colors.black.withOpacity(0.12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(12),
                              itemCount: cartItems.length,
                              separatorBuilder: (_, __) => Divider(
                                color: colorScheme.onSurface.withOpacity(0.08),
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                final item = cartItems[index];
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 6),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _buildImage(item['image']!),
                                  ),
                                  title: Text(
                                    item['name']!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  trailing: Text(
                                    item['price']!,
                                    style: TextStyle(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w700,
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
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Location Button for Desktop
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _isLoadingLocation ? null : _getCurrentLocation,
                                icon: _isLoadingLocation 
                                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                  : const Icon(Icons.my_location, color: Colors.white),
                                label: Text(
                                  _isLoadingLocation ? "Detecting..." : "Use Current Location",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary, 
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Text(
                              "Delivery Address",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: addressController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Enter your full delivery address...",
                                filled: true,
                                fillColor: colorScheme.surface.withOpacity(0.6),
                                hintStyle: TextStyle(
                                  color: colorScheme.onSurface.withOpacity(0.5),
                                ),
                                contentPadding: const EdgeInsets.all(14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: colorScheme.primary),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: colorScheme.onSurface),
                            ),

                            const SizedBox(height: 18),
                            Divider(
                              color: colorScheme.onSurface.withOpacity(0.12),
                              height: 1,
                              thickness: 1,
                            ),
                            const SizedBox(height: 18),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: colorScheme.onSurface.withOpacity(0.9),
                                  ),
                                ),
                                Text(
                                  "\$${total.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () => confirmOrder(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  elevation: 6,
                                  shadowColor:
                                      colorScheme.primary.withOpacity(0.35),
                                ),
                                child: const Text(
                                  "Confirm Purchase",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
