import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
      body: FutureBuilder(
        future: getServicios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final servicio = snapshot.data?[index];
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteServicio(servicio['id_servicio']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            '¿Eliminar servicio de tipo "${servicio['tipo_servicio']}"?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Sí, eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(servicio['id_servicio']),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 132, 180, 243)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          const Icon(Icons.build, color: Colors.black54),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              servicio['tipo_servicio'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, size: 18),
                              const SizedBox(width: 6),
                              Text('Costo: \$${servicio['costo_servicio']?.toString() ?? '0.0'}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.category, size: 18),
                              const SizedBox(width: 6),
                              Text('Material: ${servicio['material'] ?? ''}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.date_range, size: 18),
                              const SizedBox(width: 6),
                              Text('Inicio: ${servicio['fecha_inicio'] ?? ''}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.event_available, size: 18),
                              const SizedBox(width: 6),
                              Text('Finalizado: ${servicio['fecha_finalizado'] ?? ''}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 18),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text('Resolución: ${servicio['resolucion_problema'] ?? ''}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: {
                            'id_servicio': servicio['id_servicio'],
                            'tipo_servicio': servicio['tipo_servicio'],
                            'costo_servicio': servicio['costo_servicio'],
                            'material': servicio['material'],
                            'fecha_inicio': servicio['fecha_inicio'],
                            'fecha_finalizado': servicio['fecha_finalizado'],
                            'resolucion_problema': servicio['resolucion_problema'],
                          },
                        );
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 132, 180, 243),
      ),
    );
  }
}
