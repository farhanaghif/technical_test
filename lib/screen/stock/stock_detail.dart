import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/stock_model/stock_model.dart';
import 'package:risa_reborn/screen/stock/stock_form_edit.dart';

class StockDetail extends StatefulWidget {
  final StockModel detailStock;
  const StockDetail(this.detailStock, {Key? key}) : super(key: key);

  @override
  State<StockDetail> createState() => StockDetailState();
}

class StockDetailState extends State<StockDetail> {
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
            .delete('$baseUrl/api/stock/delete/${widget.detailStock.kdStock}',
                options: Options(headers: {
                  "Authorization": "Bearer $tokenBaru",
                }));
        if (response.statusCode == 200) {
          _onWidgetDidBuild(() {
            String respon =
                'Berhasil menghapus stock "${widget.detailStock.nmStock}"';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(respon),
                backgroundColor: Colors.green,
              ),
            );
          });
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
      'Nama',
      'Kategori',
      'Jumlah',
      'Satuan',
      'Lokasi',
      'Latitude',
      "Longitude",
      "Detail Lokasi",
      "Terakhir Update",
      "User Updated",
    ];
    var cekJumlahStockjikaNol = widget.detailStock.jumlah;
    cekJumlahStockjikaNol ??= 0;

    List<String> values = [
      widget.detailStock.nmStock.toString(),
      widget.detailStock.nmKategoriStock.toString(),
      cekJumlahStockjikaNol.toString(),
      widget.detailStock.satuan.toString(),
      widget.detailStock.nmLokasi.toString(),
      widget.detailStock.latitude.toString(),
      widget.detailStock.longitude.toString(),
      widget.detailStock.detailLokasi.toString(),
      widget.detailStock.tglUpdated.toString(),
      widget.detailStock.userUpdated.toString(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Upper table
                Text(
                  widget.detailStock.nmStock.toString(),
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
                                  Get.off(FormEditStock(widget.detailStock));
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
