import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryService {
  final Battery _battery = Battery();

  /// Returns the current battery level as an integer percentage.
  Future<int> getBatteryLevel() async {
    try {
      return await _battery.batteryLevel;
    } catch (e) {
      print("Error fetching battery level: $e");
      return -1; // Indicate error or unknown
    }
  }

  /// Returns the current battery state (charging, discharging, full, unknown).
  Future<BatteryState> getBatteryState() async {
    try {
      return await _battery.batteryState;
    } catch (e) {
      print("Error fetching battery state: $e");
      return BatteryState.unknown;
    }
  }

  /// Checks battery level and shows a warning SnackBar if low (< 20%) and not charging.
  Future<void> checkBatteryAndWarn(BuildContext context) async {
    try {
      final level = await getBatteryLevel();
      final state = await getBatteryState();

      if (level != -1 && level < 20 && state != BatteryState.charging && state != BatteryState.full) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("⚠️ Low Battery ($level%). Please plug in to avoid interruption."),
              backgroundColor: Colors.orangeAccent,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      }
    } catch (e) {
      print("Error checking battery: $e");
    }
  }
}
