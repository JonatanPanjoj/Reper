import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  // Convierte el timestamp en un objeto DateTime
  final dateTime = timestamp.toDate();

  // Define el formato deseado (10 de octubre de 2024)
  final formato = DateFormat('dd \'de\' MMMM \'de\' y', 'es');

  // Formatea la fecha y devuelve el resultado
  return formato.format(dateTime);
}

String formatTimeFromTimeOfDay(TimeOfDay time) {
  String formattedTime =
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} hrs';

  return formattedTime;
}

String formatTimeFromTimeStamp(Timestamp timestamp){

  // Convierte el Timestamp a DateTime
  DateTime dateTime = timestamp.toDate();

  // Formatea la hora en el formato deseado
  String formattedTime = DateFormat('HH:mm').format(dateTime); 
  return '$formattedTime hrs';
}