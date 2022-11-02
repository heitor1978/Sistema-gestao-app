import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sistemagestao_app/Services/RoutesService/routes_service.dart';
import 'package:sistemagestao_app/Widgets/export_all_widget.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RoutesView extends StatefulWidget {
  LatLng? localizacaoEntrega;
  RoutesView({super.key, this.localizacaoEntrega});

  @override
  State<RoutesView> createState() => _RoutesViewState();
}


class _RoutesViewState extends State<RoutesView> {
  var routeService = RouteService();
  PolylinePoints polylinePoints = PolylinePoints();
  String googleApiKey = 'AIzaSyCxOtHAIzH1OYU2NTSNcr97eoFmaT725FA';
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {}; 

  double latitudeAtual = 0;
  double longitudeAtual = 0;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double latitude = widget.localizacaoEntrega!.latitude;
    return Scaffold(
      appBar: CustomAppBarHome(
        title: 'Rota da Viagem',
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: routeService.position,
          zoom: 13,
        ),
        onMapCreated: routeService.onMapCreated,
        myLocationEnabled: true,
        markers: {
          Marker(
            markerId: MarkerId('Atual'),
            position: LatLng(latitudeAtual,longitudeAtual),
          ),
          Marker(
              markerId: MarkerId('Destino'),
              position: widget.localizacaoEntrega!),
        },
        polylines: Set<Polyline>.of(polylines.values),
      ),
    );
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }
  
  void getPolyLine(double latitudeDestino, double longitudeDestino) async {
    List<LatLng> polylineCoordinates = [];
    final posicao = await routeService.posicaoAtual();
    latitudeAtual = posicao.latitude;
    longitudeAtual = posicao.longitude;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey, 
      PointLatLng(latitudeAtual, longitudeAtual), 
      PointLatLng(latitudeDestino, longitudeDestino),
      travelMode: TravelMode.driving,
    );
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) { 
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
