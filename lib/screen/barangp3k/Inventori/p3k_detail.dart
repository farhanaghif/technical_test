import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/p3k.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_form_edit.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_list.dart';

class P3KDetail extends StatefulWidget {
  final P3KModel detailP3K;
  const P3KDetail(this.detailP3K, {Key? key}) : super(key: key);

  @override
  State<P3KDetail> createState() => _P3KDetailState();
}

class _P3KDetailState extends State<P3KDetail> {
  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Future<bool?> _deleteConfirm(BuildContext context) {
    return showDialog<bool?>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konfirmasi hapus"),
            content: const Text("Apakah yakin ingin menghapus komputer ini!"),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Tidak")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Ya"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Nomor P3K',
      'Fasilitas Pelabuhan',
      'Detail Lokasi',
      'Nama Tipe Barang P3K',
      'Stok',
      'Keterangan Barang P3K',
      'Terakhir Update',
      'User Update',
    ];
    widget.detailP3K.stockP3k ??= 0;
    List<String> values = [
      widget.detailP3K.kdP3k.toString(),
      widget.detailP3K.nmFasilitasPelabuhan.toString(),
      widget.detailP3K.detailLokasi.toString(),
      widget.detailP3K.nmTypeP3k.toString(),
      widget.detailP3K.stockP3k.toString(),
      widget.detailP3K.ketP3k.toString(),
      widget.detailP3K.tglUpdated.toString(),
      widget.detailP3K.userUpdated.toString(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   leading: BackButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      //   title: const Text('Detail Barang P3K'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.detailP3K.nmP3k.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Column(
                    children: List.generate(
                        titles.length,
                        (index) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text(titles[index])),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(':'),
                                ),
                                Expanded(
                                  child: Text(
                                    values[index],
                                  ),
                                )
                              ],
                            ))),
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        // onTap: () => _getImageAndUpload(
                        //     context: context,
                        //     source: ImageSource.camera,
                        //     id: detail.id),
                        // onLongPress: () => _getImageAndUpload(
                        //     context: context,
                        //     source: ImageSource.gallery,
                        //     id: detail.id),
                        child: Container(
                            decoration: BoxDecoration(
                                // color: Pallete.secondaryBackground,
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            width: 100,
                            height: 100,
                            child: const Icon(Icons.camera)),
                      ),
                      // horizontalSpaceMedium,
                      const SizedBox(width: 25),
                      Expanded(
                          child: Wrap(
                        spacing: 10.0,
                        children: <Widget>[
                          ElevatedButton.icon(
                              onPressed: () {
                                Get.off(P3KFormEdit(widget.detailP3K));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[300],
                              ),
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit")),
                          ElevatedButton.icon(
                              onPressed: () async {
                                var tokenBaru =
                                    await dataStorage.read(key: 'token_baru');
                                final bool? confirmDelete =
                                    await _deleteConfirm(context);
                                if (confirmDelete != null && confirmDelete) {
                                  var kodePerangkat = widget.detailP3K.kdP3k;
                                  try {
                                    var response = await Dio().delete(
                                        '$baseUrl/api/p3k/delete/$kodePerangkat',
                                        options: Options(headers: {
                                          "Authorization": "Bearer $tokenBaru",
                                        }));
                                    if (response.statusCode == 200) {
                                      _onWidgetDidBuild(() {
                                        String respon =
                                            'Berhasil menghapus "${widget.detailP3K.nmP3k}"';
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(respon),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      });
                                      //homePage
                                      setState(() {
                                        Get.off(const P3Klist());
                                      });
                                    }
                                  } on DioError catch (e) {
                                    // print(e);
                                    if (e.response?.statusCode == 400) {
                                      String errorMessage =
                                          e.response?.data['pesan_warning'];
                                      _onWidgetDidBuild(() {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(errorMessage),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      });
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[300],
                              ),
                              icon: const Icon(Icons.delete),
                              label: const Text("Hapus")),
                        ],
                      ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
