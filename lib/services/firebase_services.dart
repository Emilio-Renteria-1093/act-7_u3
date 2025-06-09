import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

// Obtener todos los servicios
Future<List> getServicios() async {
  List servicios = [];
  QuerySnapshot queryServicios = await db.collection("servicio").get();
  for (var doc in queryServicios.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final servicio = {
      'id_servicio': doc.id,
      'tipo_servicio': data['tipo_servicio'],
      'costo_servicio': data['costo_servicio'],
      'material': data['material'],
      'fecha_inicio': data['fecha_inicio'],
      'fecha_finalizado': data['fecha_finalizado'],
      'resolucion_problema': data['resolucion_problema'],
    };
    servicios.add(servicio);
  }

  return servicios;
}

// Agregar un nuevo servicio
Future<void> addServicio(
  String tipoServicio,
  String costoServicio,
  String material,
  String fechaInicio,
  String fechaFinalizado,
  String resolucionProblema,
) async {
  await db.collection('servicio').doc().set({
    'tipo_servicio': tipoServicio,
    'costo_servicio': double.tryParse(costoServicio) ?? 0.0,
    'material': material,
    'fecha_inicio': fechaInicio,
    'fecha_finalizado': fechaFinalizado,
    'resolucion_problema': resolucionProblema,
  });
}

// Actualizar un servicio existente
Future<void> updateServicio(
  String idServicio,
  String tipoServicio,
  double costoServicio,
  String material,
  String fechaInicio,
  String fechaFinalizado,
  String resolucionProblema,
) async {
  await db.collection("servicio").doc(idServicio).update({
    'tipo_servicio': tipoServicio,
    'costo_servicio': costoServicio,
    'material': material,
    'fecha_inicio': fechaInicio,
    'fecha_finalizado': fechaFinalizado,
    'resolucion_problema': resolucionProblema,
  });
}

// Eliminar un servicio
Future<void> deleteServicio(String idServicio) async {
  await db.collection("servicio").doc(idServicio).delete();
}
