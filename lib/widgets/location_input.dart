import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as locat;

import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    Key? key,
    required this.onSelectPlace,
  }) : super(key: key);
  final Function onSelectPlace;

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.push<LatLng?>(
        context,
        MaterialPageRoute(
            builder: (ctx) => MapsScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  Future<void> _getCurretUserLocation() async {
    try {
      final locationData = await locat.Location().getLocation();
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
          latitude: locationData.latitude!, longitude: locationData.longitude!);
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });

      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(_previewImageUrl!,
                  fit: BoxFit.cover, width: double.infinity,
                  loadingBuilder: (ctx, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? (loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!)
                          : null,
                    ),
                  );
                }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: _getCurretUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
