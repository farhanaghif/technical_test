import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/perangkat_model/p_model.dart';
import 'package:risa_reborn/screen/perangkat/master_perangkat/perangkat_form_edit.dart';

class PerangkatDetail extends StatefulWidget {
  final PerangkatModel detailPerangkat;
  const PerangkatDetail(this.detailPerangkat, {Key? key}) : super(key: key);

  @override
  State<PerangkatDetail> createState() => PerangkatDetailState();
}

class PerangkatDetailState extends State<PerangkatDetail> {
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
      var kodePerangkat = widget.detailPerangkat.kdPerangkat;
      try {
        var response =
            await Dio().delete('$baseUrl/api/perangkat/delete/$kodePerangkat',
                options: Options(headers: {
                  "Authorization": "Bearer $tokenBaru",
                }));
        if (response.statusCode == 200) {
          _onWidgetDidBuild(() {
            String respon =
                'Berhasil menghapus perangkat "${widget.detailPerangkat.nmPerangkat}"';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(respon),
                backgroundColor: Colors.green,
              ),
            );
          });
          //homePage
          // Get.off(const JenisPerangkat());
          Get.back();
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
      'No Inventaris',
      'Jenis',
      'Merk',
      'Status',
      'Kondisi',
      'Lokasi',
      'Latitude',
      'Logitude',
      "Detail Lokasi",
      "Nama Perusahaan",
      "Nama Kerjasama",
      "Tanggal Pengadaan",
      "Terakhir Update",
      "User Updated",
      'Keterangan'
    ];

    List<String> values = [
      widget.detailPerangkat.noInvPerangkat.toString(),
      widget.detailPerangkat.nmJnsPerangkat.toString(),
      widget.detailPerangkat.nmMerkPerangkat.toString(),
      widget.detailPerangkat.nmStsPerangkat.toString(),
      widget.detailPerangkat.nmKondisiPerangkat.toString(),
      widget.detailPerangkat.nmLokasi.toString(),
      widget.detailPerangkat.latitude.toString(),
      widget.detailPerangkat.longitude.toString(),
      widget.detailPerangkat.detailLokasi.toString(),
      widget.detailPerangkat.nmPerusahaan.toString(),
      widget.detailPerangkat.nmKerjasama.toString(),
      widget.detailPerangkat.tglPerangkat.toString(),
      widget.detailPerangkat.tglUpdated.toString(),
      widget.detailPerangkat.userUpdated.toString(),
      widget.detailPerangkat.ketPerangkat.toString(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Detail Perangkat'),
      ),
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Upper table
                Text(
                  widget.detailPerangkat.nmPerangkat.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                  Get.off(FormEditPerangkat(
                                      widget.detailPerangkat));
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
        // Loading Screen
        // if (computerProvider.detailState == ViewState.busy)
        //   const Scaffold(
        //     body: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   )
      ]),
    );
  }
}

// class ButtonContainer extends StatefulWidget {
//   const ButtonContainer({Key? key}) : super(key: key);

  // const ButtonContainer({required this.provider});
  // final ComputerProvider provider;

  // @override
  // _ButtonContainerState createState() => _ButtonContainerState();
// }

// class _ButtonContainerState extends State<ButtonContainer> {
  // late File? _image;
  // final ImagePicker picker = ImagePicker();

  // Future<void> _getImageAndUpload(
  //     {required BuildContext context,
  //     required ImageSource source,
  //     required String id}) async {
  //   final PickedFile? pickedFile = await picker.getImage(source: source);
  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //   } else {
  //     return;
  //   }

  // compress and upload
  //   await context
  //       .read<ComputerProvider>()
  //       .uploadImage(id, _image!)
  //       .then((bool value) {
  //     if (value) {
  //       showToastSuccess(
  //           context: context, message: "Berhasil mengupload gambar");
  //     }
  //   }).onError((Object? error, _) {
  //     showToastError(context: context, message: error.toString());
  //   });
  // }

  // Future<bool?> _deleteConfirm(BuildContext context) {
  //   return showDialog<bool?>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text("Konfirmasi hapus"),
  //           content: const Text("Apakah yakin ingin menghapus komputer ini!"),
  //           actions: <Widget>[
  //             ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).colorScheme.secondary),
  //                 onPressed: () => Navigator.of(context).pop(false),
  //                 child: const Text("Tidak")),
  //             TextButton(
  //                 onPressed: () => Navigator.of(context).pop(true),
  //                 child: const Text("Ya"))
  //           ],
  //         );
  //       });
  // }

  // @override
  // Widget build(BuildContext context) {
    // final ComputerDetailResponseData detail = widget.provider.computerDetail;
    // return ;
  // }
// }
