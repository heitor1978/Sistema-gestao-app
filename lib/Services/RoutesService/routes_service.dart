import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

class RouteService {
  double latitude = 0.0;
  double longitude = 0.0;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  late StreamSubscription<Position> positionStream;
  LatLng position = LatLng(-20.804976, -49.497273);
  GoogleMapController? mapsController;
  final markers = Set<Marker>();

  Future<Position> posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone.');
    }

    permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }

    return await Geolocator.getCurrentPosition();
  }

  savePosition() async {
    try {
      final posicao = await posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      firestore.collection('funcionarios').doc(auth.currentUser!.uid).collection('localizacaoAtual').doc(auth.currentUser!.uid).set({
        "localizacaoAtual": GeoPoint(latitude, longitude),
      });
    } catch (e) {}
  }

  onMapCreated(GoogleMapController gmc) async {
    mapsController = gmc;
    savePosition();

    var style = await rootBundle.loadString('assets/map/map.json');
    mapsController!.setMapStyle(style);
  }
}
