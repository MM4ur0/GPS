import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  MapScreen({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 238, 255, 3),
          title: Text('Mapa'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 8.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId('ubicacion'),
              position: LatLng(latitude, longitude),
              infoWindow: InfoWindow(title: 'Ubicación'),
            ),
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 238, 255, 3),
          onPressed: () {
            Navigator.pop(
                context); // Navega hacia atrás al presionar el botón de retroceso
          },
          child: Icon(Icons.arrow_back),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked);
  }
}
