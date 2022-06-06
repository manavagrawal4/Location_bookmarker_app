import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_places_app/models/place.dart';

import 'package:latlong2/latlong.dart';

class MapsScreen extends StatefulWidget {
  static const routeName = '/add-place-screen/maps-screen';
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapsScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 51.5, longitude: -0.09),
      this.isSelecting = false});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.pop(context, _pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
        title: Text('Your Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelecting ? _selectLocation : null,
          center: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: (widget.isSelecting && _pickedLocation == null)
                ? []
                : [
                    Marker(
                      //rotateOrigin: Offset(0, 0.5),
                      rotate: true,
                      width: 100.0,
                      height: 100.0,
                      point: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude),
                      builder: (ctx) => Container(
                        child: FractionalTranslation(
                          translation: Offset(0, -0.3),
                          child: Icon(
                            Icons.location_on,
                            size: 80,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
