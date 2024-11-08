import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class loc extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<loc> {
  String _currentAddress = 'My Address';
  Position? _currentPosition;

  LocationService locationService = LocationService();

  // Method to fetch the current location and address
  Future<void> _getCurrentLocation() async {
    Position? position = await locationService.getCurrentLocation(context);  // Pass context here
    setState(() {
      _currentPosition = position;
    });

    if (position != null) {
      String address = await locationService.getAddressFromLatLng(position);
      setState(() {
        _currentAddress = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator & Geocoding Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                'LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}',
              ),
            SizedBox(height: 10),
            Text(
              'Address: $_currentAddress',
            ),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationService {
  // Method to check and request location permissions
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog(context);  // Show dialog if services are disabled
      return false;
    }

    // Check the current permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return false;
      }
    }

    // Handle permission denied forever
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return false;
    }

    return true;
  }

  // Method to show a dialog to prompt the user to enable location services
  void _showLocationServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enable Location Services'),
          content: Text('Location services are disabled. Please enable them in your device settings.'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to get the current location
  Future<Position?> getCurrentLocation(BuildContext context) async {
    // Check and handle location permissions
    bool hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return null;

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  // Method to get address from latitude and longitude
  Future<String> getAddressFromLatLng(Position position) async {
    try {
      // Retrieve the list of placemarks from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Extract city, state, and country details from the first placemark
      Placemark place = placemarks[0];
      String address = '${place.locality}, ${place.administrativeArea}, ${place.country}';
      return address;
    } catch (e) {
      print(e);
      return 'Error occurred while retrieving address';
    }
  }
}
