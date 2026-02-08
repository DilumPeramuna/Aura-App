import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }

  Future<String?> getAddressFromCoordinates(Position position) async {
    // Geocoding package does not support Web out of the box.
    if (kIsWeb) {
      return "Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)} (Address lookup needs Mobile)";
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = "";
        
        if (place.street != null && place.street!.isNotEmpty) {
          address += "${place.street}, ";
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
           address += "${place.subLocality}, ";
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          address += "${place.locality}, ";
        }
        if (place.postalCode != null && place.postalCode!.isNotEmpty) {
          address += "${place.postalCode}, ";
        }
         if (place.country != null && place.country!.isNotEmpty) {
          address += place.country!;
        }

        if (address.endsWith(", ")) {
          address = address.substring(0, address.length - 2);
        }

        return address;
      }
      return null;
    } catch (e) {
      print("Error getting address: $e");
      // Fallback to coordinates on error
      return "Lat: ${position.latitude}, Lng: ${position.longitude}";
    }
  }
}
