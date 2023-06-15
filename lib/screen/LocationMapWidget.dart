import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class LocationMapWidget extends StatelessWidget {
  final String latitude;
  final String longitude;
  final String name;
  final loc;

  const LocationMapWidget({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    final double parsedLatitude = double.tryParse(latitude) ?? 0.0;
    final double parsedLongitude = double.tryParse(longitude) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Where to find $name'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   'Latitude: $latitude',
            //   style: const TextStyle(fontSize: 16),
            // ),
            Text(
              '$loc',
              style: const TextStyle(fontSize: 16),
              
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                launchMapsApp(parsedLatitude, parsedLongitude);
              },
              child: const Text('Open Maps'),
            ),
          ],
        ),
      ),
    );
  }

  void launchMapsApp(double latitude, double longitude) {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

}
