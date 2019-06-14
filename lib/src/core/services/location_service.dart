import 'dart:async';

import 'package:location/location.dart';

class UserLocation {
  UserLocation({
    this.latitude,
    this.longitude,
  });

  final double latitude;
  final double longitude;
}

class LocationService {
  UserLocation _currentLocation;
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;

  var location = Location();

  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}
