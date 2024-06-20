import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  Widget build(BuildContext context) {
     const LatLng  eIphone15promax=LatLng(37,423-122.08);
    return Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: eIphone15promax,zoom: 15),),
    

    );
  }
}