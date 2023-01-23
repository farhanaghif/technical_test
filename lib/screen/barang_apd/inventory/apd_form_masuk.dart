import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apd_model/apd_model.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_list.dart';

class FormBarangAPDMasuk extends StatefulWidget {
  final APDModel detailAPD;
  const FormBarangAPDMasuk(this.detailAPD, {Key? key}) : super(key: key);

  @override
  State<FormBarangAPDMasuk> createState() => _FormBarangAPDMasukState();
}

class _FormBarangAPDMasukState extends State<FormBarangAPDMasuk> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;

  final _valueNamaBarangAPD = TextEditingController();
  final _valueJmlBarangAPDMasuk = TextEditingController();
  final _valueKetBarangAPDMasuk = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueNamaBarangAPD.text = widget.detailAPD.nmApd.toString();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  formValidation(BuildContext context) async {
    bool isFormValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (_valueNamaBarangAPD.text.isEmpty ||
        _valueKetBarangAPDMasuk.text.isEmpty ||
        _valueJmlBarangAPDMasuk.text.isEmpty) {
      isFormValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Input tidak boleh ada yang kosong'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
    setState(() => isLoading = true);

    if (isFormValid) {
      await prosesBarangAPDMasuk(context, _valueNamaBarangAPD.text,
          _valueJmlBarangAPDMasuk.text, _valueKetBarangAPDMasuk.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesBarangAPDMasuk(BuildContext context, String namaStock,
      String jumlahBarangAPDMasuk, String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().post('$baseUrl/api/apd/storeAPDMasuk',
              data: {
                "kd_apd": widget.detailAPD.kdApd,
                "jml_apd_msk": jumlahBarangAPDMasuk,
                "ket_apd_msk": keterangan
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon =
              "Berhasil Menambahkan $namaStock sebanyak $jumlahBarangAPDMasuk";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text('Menambahkan Barang APD'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Masukkan Data Barang APD',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: _valueNamaBarangAPD,
                        decoration: const InputDecoration(
                            enabled: false,
                            labelText: 'Nama Barang APD',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _valueJmlBarangAPDMasuk,
                        decoration: const InputDecoration(
                            labelText: 'Jumlah Penambahan',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _valueKetBarangAPDMasuk,
                        decoration: const InputDecoration(
                            labelText: 'Keterangan Barang APD masuk',
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  primary:
                                      const Color.fromARGB(255, 30, 156, 230),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: const Text('Tambahkan Barang APD'),
                                onPressed: () {
                                  formValidation(context);
                                },
                              ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
