import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditServicioPage extends StatefulWidget {
  const EditServicioPage({super.key});

  @override
  State<EditServicioPage> createState() => _EditServicioPageState();
}

class _EditServicioPageState extends State<EditServicioPage> {
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController costoController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinalizadoController = TextEditingController();
  final TextEditingController resolucionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (tipoController.text.isEmpty) {
      tipoController.text = arguments['tipo_servicio'] ?? '';
      costoController.text = (arguments['costo_servicio'] ?? '').toString();
      materialController.text = arguments['material'] ?? '';
      fechaInicioController.text = arguments['fecha_inicio'] ?? '';
      fechaFinalizadoController.text = arguments['fecha_finalizado'] ?? '';
      resolucionController.text = arguments['resolucion_problema'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Servicio'),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tipoController,
                decoration: const InputDecoration(hintText: 'Tipo de servicio'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: costoController,
                decoration: const InputDecoration(hintText: 'Costo del servicio'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: materialController,
                decoration: const InputDecoration(hintText: 'Material utilizado'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: fechaInicioController,
                decoration: const InputDecoration(hintText: 'Fecha de inicio'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: fechaFinalizadoController,
                decoration: const InputDecoration(hintText: 'Fecha de finalización'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: resolucionController,
                decoration: const InputDecoration(hintText: 'Resolución del problema'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 132, 180, 243),
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final double costo = double.tryParse(costoController.text) ?? 0.0;
                  final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

                  await updateServicio(
                    arguments['id_servicio'],
                    tipoController.text,
                    costo,
                    materialController.text,
                    fechaInicioController.text,
                    fechaFinalizadoController.text,
                    resolucionController.text,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
