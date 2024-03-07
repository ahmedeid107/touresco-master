// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSample extends StatefulWidget {
  MapSample({Key? key, this.latLang}) : super(key: key);
  final String? latLang;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    if (widget.latLang == "") {
      _getCurrentPosition();
    } else {
      _controller.future.then((controller) {
        CameraPosition _kLake = CameraPosition(
            target: LatLng(
                double.parse(widget.latLang!.split(",")[0].toString()),
                double.parse(widget.latLang!.split(",")[1].toString())),
            zoom: 17.151926040649414);
        controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
        _onAddMarkerButtonPressed(LatLng(
            double.parse(widget.latLang!.split(",")[0].toString()),
            double.parse(widget.latLang!.split(",")[1].toString())));
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap: (latlang) {
          if (_markers.length >= 1) {
            _markers.clear();
          }

          _onAddMarkerButtonPressed(latlang);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text(lang.next),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    if (_markers.isNotEmpty) {
      var p = _markers.first.position;
      Navigator.pop(context, "${p.latitude},${p.longitude}");
    } else {
      Navigator.pop(context, "");
    }
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: const MarkerId("1"),
        position: latlang,
        infoWindow: const InfoWindow(
          title: "address",
          //  snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Map<Permission, PermissionStatus> permissions = await [
        Permission.location,
      ].request();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Position? _currentPosition;

  _getCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;

    if (await Permission.location.status.isGranted) {
      try {
        var isGpsEnabled = await Geolocator.isLocationServiceEnabled();
        if (isGpsEnabled) {
          await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high)
              .then((Position position) {
            setState(() => _currentPosition = position);
            CameraPosition _kLake = CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 17.151926040649414);
            controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
            _onAddMarkerButtonPressed(
                LatLng(position.latitude, position.longitude));
          }).catchError((e) {
            debugPrint(e);
          });
        } else {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("permissionToStorage"),
                content:
                    const Text("application needs This permission to work properly"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Geolocator.openLocationSettings().then((value) {
                        _getCurrentPosition();
                      });
                    },
                    child: const Text("ok"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("cancel"),
                  ),
                ],
              );
            },
          );
        }
      } catch (Ex) {}
    } else {
      Map<Permission, PermissionStatus> permissions = await [
        Permission.location,
      ].request();
      _getCurrentPosition();
    }
  }
}
