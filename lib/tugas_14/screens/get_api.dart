import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_14/api/get_user.dart';
import 'package:flutter_application_1/tugas_14/models/user_model.dart';

class GetApiSatu extends StatefulWidget {
  const GetApiSatu({super.key});

  @override
  State<GetApiSatu> createState() => _GetApiSatuState();
}

class _GetApiSatuState extends State<GetApiSatu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<List<Welcome>>(
                future: getUser(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final users = snapshot.data as List<Welcome>;
                    print(users);
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dataUser = users[index];
                        return ListTile(
                          leading: dataUser.image == ""
                              ? SizedBox(
                                  width: 40,
                                  height: 70,
                                  child: Placeholder(),
                                )
                              : Image.network(dataUser.image ?? ""),
                          title: Text(dataUser.name ?? ""),
                          subtitle: Text(
                            dataUser.alternateNames.join(", ") ?? "",
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("Gagal Memuat data");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
