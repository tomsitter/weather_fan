import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              "Location permissions are denied. Please enable location permissions for this app."),
          ElevatedButton(
            onPressed: () async {
              if (await Permission.location.isDenied) {
                await Permission.location.request();
              }
              Navigator.pop(context);
            },
            child: const Text("Grant Permission"),
          ),
        ],
      ),
    );
  }
}
