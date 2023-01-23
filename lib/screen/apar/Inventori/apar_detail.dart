import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apar_model/a_model.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_form_edit.dart';

class AparDetail extends StatefulWidget {
  final AparModel detailApar;
  const AparDetail(this.detailApar, {Key? key}) : super(key: key);

  @override
  State<AparDetail> createState() => _AparDetailState();
}

class _AparDetailState extends State<AparDetail> {
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
      try {
        var response = await Dio()
            .delete('$baseUrl/api/apar/delete/${widget.detailApar.kdApar}',
                options: Options(headers: {
                  "Authorization": "Bearer $tokenBaru",
                }));
        if (response.statusCode == 200) {
          _onWidgetDidBuild(() {
            String respon =
                'Berhasil menghapus APAR "${widget.detailApar.nmApar}"';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(respon),
                backgroundColor: Colors.green,
              ),
            );
          });
          //homePage
          setState(() {
            Get.back();
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
    widget.detailApar.alasanGanti ??= '-';
    List<String> titles = [
      'Nomor APAR',
      'Fasilitas Pelabuhan',
      'Detail Lokasi',
      'Nama Bahan Apar',
      'Klasifikasi Kebakaran',
      'Tanggal Awal Berlaku',
      'Tanggal Akhir Berlaku',
      'Tekanan Tabung',
      'Status Kondisi',
      'Alasan Ganti',
      'Keterangan APAR',
      'Terakhir Update',
      'User Update',
    ];
    String? tekananTabung;
    if (widget.detailApar.tekananTabung == 'Y') {
      tekananTabung = 'Hijau/Isi';
    }
    if (widget.detailApar.tekananTabung == 'N') {
      tekananTabung = 'Merah/Kosong';
    }
    List<String> values = [
      widget.detailApar.kdApar.toString(),
      widget.detailApar.nmFasilitasPelabuhan.toString(),
      widget.detailApar.detailLokasi.toString(),
      widget.detailApar.nmBhnApar.toString(),
      widget.detailApar.nmKlasifikasiKebakaran.toString(),
      widget.detailApar.tglAwalMasaberlaku.toString(),
      widget.detailApar.tglAkhirMasaberlaku.toString(),
      tekananTabung.toString(),
      widget.detailApar.nmKondisiTabung.toString(),
      widget.detailApar.alasanGanti.toString(),
      widget.detailApar.ketApar.toString(),
      widget.detailApar.tglUpdated.toString(),
      widget.detailApar.userUpdated.toString(),
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
                widget.detailApar.nmApar.toString(),
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
                                Get.off(AparFormEdit(widget.detailApar));
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
