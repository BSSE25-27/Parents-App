import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String markerTitle;
  final String markerSnippet;

  const MapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.markerTitle,
    required this.markerSnippet,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  late BitmapDescriptor _markerIcon;
  
  final Set<Marker> _markers = {};
  
  @override
  void initState() {
    super.initState();
    _setCustomMarker();
  }
  
  Future<void> _setCustomMarker() async {
    _markerIcon = await BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('vanLocation'),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(
            title: widget.markerTitle,
            snippet: widget.markerSnippet,
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 15,
        ),
        markers: _markers,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}

