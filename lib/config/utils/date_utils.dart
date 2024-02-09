import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp timestamp) {
  // Convierte el timestamp en un objeto DateTime
  final dateTime = timestamp.toDate();

  // Define el formato deseado (10 de octubre de 2024)
  final formato = DateFormat('dd \'de\' MMMM \'de\' y', 'es');

  // Formatea la fecha y devuelve el resultado
  return formato.format(dateTime);
}