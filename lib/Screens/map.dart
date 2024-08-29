import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
    final double latitude;
  final double longitude;

  const MapScreen({key, required this.latitude, required this.longitude});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey _markerKey = GlobalKey();
 
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

  }



  void _goToFullScreenMap() {
    Get.to(
        () => FullScreenMap(
              latitude: widget.latitude,
              longitude: widget.longitude,
         
            ),
        transition: Transition.rightToLeftWithFade);
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return const Center(
    //     child: CircularProgressIndicator(color: Colors.blue),
    //   );
    // }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          height: 170,
          width: MediaQuery.of(context).size.width,
          // padding: const EdgeInsets.all(8),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(15),
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(widget.latitude, widget.longitude),
                zoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: LatLng(widget.latitude, widget.longitude),
                      builder: (context) =>
                        GestureDetector(
                        onTap: () {
                          final dynamic tooltip = _markerKey.currentState;
                          tooltip?.ensureTooltipVisible();
                        },
                        child: Tooltip(
                          key: _markerKey,
                          message: 'Property Location',
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      )
                      ,
                      // child: GestureDetector(
                      //   onTap: () {
                      //     final dynamic tooltip = _markerKey.currentState;
                      //     tooltip?.ensureTooltipVisible();
                      //   },
                      //   child: Tooltip(
                      //     key: _markerKey,
                      //     message: 'Property Location',
                      //     child: const Icon(
                      //       Icons.location_pin,
                      //       color: Colors.red,
                      //       size: 40,
                      //     ),
                      //   ),
                      // ),
                    ),
                    
                      
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.zoom_out_map, color: Colors.blue),
            onPressed: _goToFullScreenMap,
          ),
        ),
      ],
    );
  }
}

class FullScreenMap extends StatelessWidget {
  final double latitude;
  final double longitude;


  const FullScreenMap({
    required this.latitude,
    required this.longitude,

  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey _markerKey = GlobalKey();
    return Scaffold(
      // appBar: AppBar(
      //   // title: Text('Full Screen Map'),

      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(latitude, longitude),
            zoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(latitude!, longitude!),
              builder: (context) =>
                GestureDetector(
                    onTap: () {
                      final dynamic tooltip = _markerKey.currentState;
                      tooltip?.ensureTooltipVisible();
                    },
                    child: Tooltip(
                      key: _markerKey,
                      message: 'Property Location',
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  )
              
                ),
               
                    
                    
              ],
            ),
          ],
        ),
        Positioned(
          top: 40,
          left: 10,
          child: IconButton(
            icon: Icon(Iconsax.arrow_left, color: Colors.blue, size: 30, weight: 30,),
            onPressed: (){
              Get.back();
            },
          ),
        ),
      ]),
    );
  }
}
