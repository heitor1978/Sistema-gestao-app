import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RouteService {
  double latitude = 0.0;
  double longitude = 0.0;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  late StreamSubscription<Position> positionStream;

  Future<Position> _posicaoAtual() async {
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

  getPosicao() async {
    try {
      final posicao = await _posicaoAtual();
      latitude = posicao.latitude;
      longitude = posicao.longitude;
      firestore.collection('funcionarios').doc(auth.currentUser!.uid).set({
        "latitudeAtual": latitude,
        "longitudeAtual": longitude,
      });
    } catch (e) {}
  }

  watchPosicao() async {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      if (position != null) {
        latitude = position.latitude;
        longitude = position.longitude;
      }
    });
  }


}
