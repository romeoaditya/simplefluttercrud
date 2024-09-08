import 'dart:convert';

import 'package:crudflutter/editdata.dart';
import 'package:crudflutter/tambahdata.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;
  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.100.94/flutterapi/crudflutter/read.php'));
      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapusdata(String id) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.100.94/flutterapi/crudflutter/delete.php'),
          body: {
            "nisn": id,
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    // print(_listdata);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: InkWell(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => EditDataPage(
                                ListData: {
                                  "id": _listdata[index]['id'],
                                  "nisn": _listdata[index]['nisn'],
                                  "nama": _listdata[index]['nama'],
                                  "alamat": _listdata[index]['alamat'],
                                },
                              )),
                        ),
                      );
                    }),
                    child: ListTile(
                      title: Text(_listdata[index]["nama"]),
                      subtitle: Text(_listdata[index]["alamat"]),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Apakah anda yakin ingin menghapus data ini?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            _hapusdata(_listdata[index]['nisn'])
                                                .then((value) {
                                              if (value) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data berhasil dihapus!'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data gagal dihapus!'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        HomePage())),
                                                (route) => false);
                                          },
                                          child: Text("Hapus")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Batal"))
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
          child: Text(
            "+",
            style: TextStyle(fontSize: 30),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TambahDataPage())));
          }),
    );
  }
}
