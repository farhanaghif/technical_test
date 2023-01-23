import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/peralatan_model/peralatan_kerja.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_form_edit.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_list.dart';

class AlatKerjaDetail extends StatefulWidget {
  final PeralatankerjaModel detailAlatKerja;
  const AlatKerjaDetail(this.detailAlatKerja, {Key? key}) : super(key: key);

  @override
  State<AlatKerjaDetail> createState() => _AlatKerjaDetailState();
}

class _AlatKerjaDetailState extends State<AlatKerjaDetail> {
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

  Future<void> actionDelete(BuildContext context) async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    final bool? confirmDelete = await _deleteConfirm(context);
    if (confirmDelete != null && confirmDelete) {
      var kdPeralatanKerja = widget.detailAlatKerja.kdPeralatanKerja;
      try {
        var response = await Dio()
            .delete('$baseUrl/api/peralatankerja/delete/$kdPeralatanKerja',
                options: Options(headers: {
                  "Authorization": "Bearer $tokenBaru",
                }));
        if (response.statusCode == 200) {
          _onWidgetDidBuild(() {
            String respon = 'Berhasil menghapus Alat Kerja';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(respon),
                backgroundColor: Colors.green,
              ),
            );
          });
          //homePage
          setState(() {
            Get.off(const AlatKerjaList());
          });
        }
      } on DioError catch (e) {
        // print(e);
        if (e.response?.statusCode == 400) {
          String errorMessage = e.response?.data['pesan_warning'];
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Fasilitas Pelabuhan',
      'Detail Lokasi',
      'Kondisi',
      'Jumlah',
      'Tanggal Pembelian',
      'Keterangan Alat Kerja',
      'Terakhir Update',
      'User Update',
    ];
    widget.detailAlatKerja.stockPeralatanKerja ??= 0;
    List<String> values = [
      widget.detailAlatKerja.nmFasilitasPelabuhan.toString(),
      widget.detailAlatKerja.detailLokasi.toString(),
      widget.detailAlatKerja.nmKondisiPerangkat.toString(),
      widget.detailAlatKerja.stockPeralatanKerja.toString(),
      widget.detailAlatKerja.tglPembelian.toString(),
      widget.detailAlatKerja.ketPeralatanKerja.toString(),
      widget.detailAlatKerja.tglUpdated.toString(),
      widget.detailAlatKerja.userUpdated.toString(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.detailAlatKerja.nmPeralatanKerja.toString(),
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
                                Get.off(
                                    AlatKerjaFormEdit(widget.detailAlatKerja));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green[300],
                              ),
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit")),
                          ElevatedButton.icon(
                              onPressed: () async {
                                await actionDelete(context);
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
