import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_14/api/get_user.dart';
import 'package:flutter_application_1/tugas_14/models/user_model.dart';
import 'package:flutter_application_1/tugas_14/screens/user_detail_page.dart';

class GetApiSatu extends StatefulWidget {
  const GetApiSatu({super.key});

  @override
  State<GetApiSatu> createState() => _GetApiSatuState();
}

class _GetApiSatuState extends State<GetApiSatu> {
  late Future<List<Welcome>> _futureUsers;

  // ✅ Tambah state untuk search
  final List<Welcome> _allUsers = [];
  List<Welcome> _filteredUsers = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadUsers(); // panggil saat pertama
  }

  // ✅ fungsi untuk load data dari API
  void _loadUsers() {
    setState(() {
      _futureUsers = getUser();
    });
  }

  // ✅ fungsi refresh (pull to refresh)
  Future<void> _refresh() async {
    _loadUsers();
    await _futureUsers; // tunggu future selesai
  }

  // ✅ fungsi filter search
  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredUsers = _allUsers.where((user) {
        final name = (user.name ?? "").toLowerCase();
        return name.contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List User")),
      body: Column(
        children: [
          // 🔎 Search Box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search by name",
                labelText: "Search",
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 29, 23, 23), width: 4.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 129, 129, 129), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterUsers,
            ),
          ),

          // ⬇️ Expanded agar ListView isi ruang tersisa
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: FutureBuilder<List<Welcome>>(
                future: getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final users = snapshot.data as List<Welcome>;

                    // ✅ kalau ada filter, pakai hasil filter
                    final displayUsers = _searchQuery.isEmpty
                        ? users
                        : users
                            .where((u) => (u.name ?? "")
                                .toLowerCase()
                                .contains(_searchQuery))
                            .toList();

                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: displayUsers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dataUser = displayUsers[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: const BorderSide(
                                color: Color.fromARGB(255, 104, 105, 105),
                                width: 2.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ListTile(
                              leading: dataUser.image == ""
                                  ? const SizedBox(
                                      width: 40,
                                      height: 70,
                                      child: Placeholder(),
                                    )
                                  : Image.network(dataUser.image ?? ""),
                              title: Text(dataUser.name ?? ""),
                              subtitle: Text(
                                dataUser.alternateNames.join(", "),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserDetailPage(user: dataUser),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("Gagal Memuat data"));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
