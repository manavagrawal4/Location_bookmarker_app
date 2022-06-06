import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/maps_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/places-detail-screen';

  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
              ),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(selectedPlace.location.address!),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => MapsScreen(
                                initialLocation: selectedPlace.location,
                                isSelecting: false,
                              )));
                },
                icon: Icon(Icons.map),
                label: Text('Show on Map'))
          ],
        ),
      ),
    );
  }
}
