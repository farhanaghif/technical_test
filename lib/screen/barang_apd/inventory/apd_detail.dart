import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apd_model/apd_model.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_form_edit.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_list.dart';

class APDDetail extends StatefulWidget {
  final APDModel detailAPD;
  const APDDetail(this.detailAPD, {Key? key}) : super(key: key);

  @override
  State<APDDetail> createState() => _APDDetailState();
}

class _APDDetailState extends State<APDDetail> {
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
      var kodeAPD = widget.detailAPD.kdApd;
      try {
        var response = await Dio().delete('$baseUrl/api/apd/delete/$kodeAPD',
            options: Options(headers: {
              "Authorization": "Bearer $tokenBaru",
            }));
        if (response.statusCode == 200) {
          _onWidgetDidBuild(() {
            String respon =
                'Berhasil menghapus perangkat "${widget.detailAPD.nmApd}"';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(respon),
                backgroundColor: Colors.green,
              ),
            );
          });
          //homePage
          setState(() {
            Get.off(const APDList());
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
      'Kode Fasilitas Pelabuhan',
      'Detail Lokasi',
      'Kondisi',
      'Jumlah',
      'Tanggal Pembelian',
      'Tanggal Expired',
      'Keterangan APD',
      'Terakhir Update',
      'User Update',
    ];
    widget.detailAPD.stockApd ??= 0;
    List<String> values = [
      widget.detailAPD.nmFasilitasPelabuhan.toString(),
      widget.detailAPD.detailLokasi.toString(),
      widget.detailAPD.nmKondisiPerangkat.toString(),
      widget.detailAPD.stockApd.toString(),
      widget.detailAPD.tglPembelian.toString(),
      widget.detailAPD.tglAkhirMasaberlaku.toString(),
      widget.detailAPD.ketApd.toString(),
      widget.detailAPD.tglUpdated.toString(),
      widget.detailAPD.userUpdated.toString(),
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
                widget.detailAPD.nmApd.toString(),
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
                                Get.off(APDFormEdit(widget.detailAPD));
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
