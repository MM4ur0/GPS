import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
final List<_PositionItem> _positionItems = <_PositionItem>[];
String _kLocationServicesDisabledMessage =
    'Servicio de Localización está deshabilitado.';
String _kPermissionDeniedMessage = 'Permiso denegado.';
String _kPermissionDeniedForeverMessage = 'Permiso denegado por siempre.';
String _kPermissionGrantedMessage = 'Permiso concedido.';

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geolocalizador")),
      body: ListView.builder(
        itemCount: _positionItems.length,
        itemBuilder: (context, index) {
          final positionItem = _positionItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/show',
                //arguments: '${partidoActual.id}',
              );
            },
            child: Card(
              child: ListTile(
                tileColor: Colors.green,
                title: Text(
                  positionItem.displayValue,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: _getCurrentPosition,
            child: const Icon(Icons.my_location),
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: _getClearList,
            child: const Icon(Icons.clear_all),
          ),
        ],
      ),
    );
  }

  void _getClearList() {
    setState(_positionItems.clear);
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print(_kLocationServicesDisabledMessage);
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print(_kPermissionDeniedMessage);

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(_kPermissionDeniedForeverMessage);
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print(_kPermissionGrantedMessage);
    return true;
  }
}
