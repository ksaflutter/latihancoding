import 'package:flutter/material.dart';

import '../models/biodata.dart';
import '../services/db_helper.dart';
import '../services/shared_prefs_service.dart';
import 'biodata_form_screen.dart';

class BiodataListScreenAll1 extends StatefulWidget {
  const BiodataListScreenAll1({super.key});

  @override
  State<BiodataListScreenAll1> createState() => _BiodataListScreenAll1State();
}

class _BiodataListScreenAll1State extends State<BiodataListScreenAll1> {
  List<Biodata> _biodataList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBiodataList();
  }

  Future<void> _loadBiodataList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userId = await SharedPrefsServiceAll1.getCustomerId();
      if (userId != null) {
        final biodataList = await DBHelperAll1.instance.getAllBiodata(userId);
        setState(() {
          _biodataList = biodataList;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _deleteBiodata(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Biodata'),
        content: const Text('Are you sure you want to delete this biodata?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await DBHelperAll1.instance.deleteBiodata(id);
        await _loadBiodataList();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biodata deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting biodata: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _editBiodata(Biodata biodata) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BiodataFormScreenAll1(biodata: biodata),
      ),
    );

    if (result == true) {
      await _loadBiodataList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _biodataList.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No biodata found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add new biodata from the Form tab',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadBiodataList,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: _biodataList.length,
                    itemBuilder: (context, index) {
                      final biodata = _biodataList[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 4,
                        ),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              biodata.fullName[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            biodata.fullName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Class: ${biodata.studentClass} | Course: ${biodata.course}'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfoRow('Gender', biodata.gender),
                                  _buildInfoRow(
                                    'Date of Birth',
                                    '${biodata.dateOfBirth.day}/${biodata.dateOfBirth.month}/${biodata.dateOfBirth.year}',
                                  ),
                                  _buildInfoRow('Phone', biodata.phone),
                                  _buildInfoRow('Address', biodata.address),
                                  _buildInfoRow(
                                    'Registration Date',
                                    '${biodata.registrationDate.day}/${biodata.registrationDate.month}/${biodata.registrationDate.year}',
                                  ),
                                  _buildInfoRow('Registration Time',
                                      biodata.registrationTime),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () => _editBiodata(biodata),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            _deleteBiodata(biodata.id!),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
