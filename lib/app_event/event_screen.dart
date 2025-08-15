import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'event_model.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _eventNameCtrl = TextEditingController();
  final _kotaCtrl = TextEditingController();

  List<EventModel> _eventList = [];
  EventModel? _editingEvent;

  @override

  /// Initializes the widget and loads the events.
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final data = await DBHelper.instance.getEvents();
    setState(() {
      _eventList = data;
    });
  }

  Future<void> _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      if (_editingEvent == null) {
        // INSERT
        await DBHelper.instance.insertEvent(
          EventModel(
            nama: _namaCtrl.text,
            email: _emailCtrl.text,
            event: _eventNameCtrl.text,
            kota: _kotaCtrl.text,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan')),
        );
      } else {
        // UPDATE
        await DBHelper.instance.updateEvent(
          EventModel(
            id: _editingEvent!.id,
            nama: _namaCtrl.text,
            email: _emailCtrl.text,
            event: _eventNameCtrl.text,
            kota: _kotaCtrl.text,
          ),
        );
        _editingEvent = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil diupdate')),
        );
      }

      _clearForm();
      _loadEvents();
    }
  }

  void _clearForm() {
    _namaCtrl.clear();
    _emailCtrl.clear();
    _eventNameCtrl.clear();
    _kotaCtrl.clear();
  }

  void _editEvent(EventModel event) {
    setState(() {
      _editingEvent = event;
      _namaCtrl.text = event.nama;
      _emailCtrl.text = event.email;
      _eventNameCtrl.text = event.event;
      _kotaCtrl.text = event.kota;
    });
  }

  Future<void> _deleteEvent(int id) async {
    await DBHelper.instance.deleteEvent(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus')),
    );
    _loadEvents();
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    _eventNameCtrl.dispose();
    _kotaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendaftaran Aktivitas Sehari-hari"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaCtrl,
                    decoration:
                        const InputDecoration(labelText: "Nama Peserta"),
                    validator: (value) =>
                        value!.isEmpty ? "Nama tidak boleh kosong" : null,
                  ),
                  TextFormField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) =>
                        value!.contains('@') ? null : "Email tidak valid",
                  ),
                  TextFormField(
                    controller: _eventNameCtrl,
                    decoration: const InputDecoration(labelText: "Nama Event"),
                    validator: (value) =>
                        value!.isEmpty ? "Nama event wajib diisi" : null,
                  ),
                  TextFormField(
                    controller: _kotaCtrl,
                    decoration: const InputDecoration(labelText: "Kota Asal"),
                    validator: (value) =>
                        value!.isEmpty ? "Kota wajib diisi" : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _saveEvent,
                    child: Text(_editingEvent == null ? "Daftar" : "Update"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _eventList.length,
                itemBuilder: (context, index) {
                  final e = _eventList[index];
                  return Card(
                    child: ListTile(
                      title: Text("${e.nama} (${e.kota})"),
                      // <- perbaikan: properti 'event' huruf kecil
                      subtitle: Text("${e.email} - ${e.event}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editEvent(e),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteEvent(e.id!),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
