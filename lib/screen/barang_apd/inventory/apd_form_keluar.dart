import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apd_model/apd_model.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_list.dart';

class FormBarangAPDKeluar extends StatefulWidget {
  final APDModel detailAPD;
  const FormBarangAPDKeluar(this.detailAPD, {Key? key}) : super(key: key);

  @override
  State<FormBarangAPDKeluar> createState() => _FormBarangAPDKeluarState();
}

class _FormBarangAPDKeluarState extends State<FormBarangAPDKeluar> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;

  final _valueNamaBarangAPD = TextEditingController();
  final _valueJmlBarangAPDKeluar = TextEditingController();
  final _valueKetBarangAPDKeluar = TextEditingController();

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
        _valueKetBarangAPDKeluar.text.isEmpty ||
        _valueJmlBarangAPDKeluar.text.isEmpty) {
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
      await prosesStockKeluar(context, _valueNamaBarangAPD.text,
          _valueJmlBarangAPDKeluar.text, _valueKetBarangAPDKeluar.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesStockKeluar(BuildContext context, String namaStock,
      String jumlahBarangAPDKeluar, String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().post('$baseUrl/api/apd/storeAPDKeluar',
              data: {
                "kd_apd": widget.detailAPD.kdApd,
                "jml_apd_keluar": jumlahBarangAPDKeluar,
                "ket_apd_keluar": keterangan
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon =
              "Berhasil mengurangi $namaStock sebanyak $jumlahBarangAPDKeluar";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
        Get.off(const APDList());
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

  validasiStockKeluar(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    bool cekJumlah = true;
    int cekHasilAkhir =
        widget.detailAPD.stockApd! - int.parse(_valueJmlBarangAPDKeluar.text);
    if (cekHasilAkhir < 0) {
      cekJumlah = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Melebihi jumlah stock Barang APD'),
            backgroundColor: Colors.red,
          ),
        );
      });
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap isi ulang jumlah pengurangan yang valid'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
    setState(() => isLoading = true);
    if (cekJumlah) {
      formValidation(context);
    }
    setState(() => isLoading = false);
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
          title: const Text('Mengurangi Barang APD'),
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
                        controller: _valueJmlBarangAPDKeluar,
                        decoration: const InputDecoration(
                            labelText: 'Jumlah pengurangan',
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
                        controller: _valueKetBarangAPDKeluar,
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
                                child: const Text('Kurangkan Barang APD'),
                                onPressed: () {
                                  validasiStockKeluar(context);
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
