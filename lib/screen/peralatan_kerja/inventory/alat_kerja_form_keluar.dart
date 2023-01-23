import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/peralatan_model/peralatan_kerja.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_list.dart';

class FormAlatKerjaKeluar extends StatefulWidget {
  final PeralatankerjaModel detailAlatKerja;
  const FormAlatKerjaKeluar(this.detailAlatKerja, {Key? key}) : super(key: key);

  @override
  State<FormAlatKerjaKeluar> createState() => _FormAlatKerjaKeluarState();
}

class _FormAlatKerjaKeluarState extends State<FormAlatKerjaKeluar> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;

  final _valueNamaAlatKerja = TextEditingController();
  final _valueJmlAlatKerjaKeluar = TextEditingController();
  final _valueKetAlatKerjaKeluar = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueNamaAlatKerja.text =
        widget.detailAlatKerja.nmPeralatanKerja.toString();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  formValidation(BuildContext context) async {
    bool isFormValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (_valueNamaAlatKerja.text.isEmpty ||
        _valueKetAlatKerjaKeluar.text.isEmpty ||
        _valueJmlAlatKerjaKeluar.text.isEmpty) {
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
      await prosesAlatKerjaKeluar(context, _valueNamaAlatKerja.text,
          _valueJmlAlatKerjaKeluar.text, _valueKetAlatKerjaKeluar.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesAlatKerjaKeluar(BuildContext context, String namaStock,
      String jumlahAlatKerjaKeluar, String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response = await Dio()
          .post('$baseUrl/api/peralatankerja/storePeralatanKerjaKeluar',
              data: {
                "kd_peralatan_kerja": widget.detailAlatKerja.kdPeralatanKerja,
                "jml_peralatan_kerja_keluar": jumlahAlatKerjaKeluar,
                "ket_peralatan_kerja_keluar": keterangan
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon =
              "Berhasil Mengurangkan ${widget.detailAlatKerja.nmPeralatanKerja} sebanyak $jumlahAlatKerjaKeluar";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
        Get.off(const AlatKerjaList());
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
    int cekHasilAkhir = widget.detailAlatKerja.stockPeralatanKerja! -
        int.parse(_valueJmlAlatKerjaKeluar.text);
    if (cekHasilAkhir < 0) {
      cekJumlah = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Melebihi jumlah stock Alat Kerja'),
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Mengurangkan Alat Kerja'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Masukkan Data Alat Kerja',
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
                          controller: _valueNamaAlatKerja,
                          decoration: const InputDecoration(
                              enabled: false,
                              labelText: 'Nama Alat Kerja',
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
                          controller: _valueJmlAlatKerjaKeluar,
                          decoration: const InputDecoration(
                              labelText: 'Jumlah Pengurangan',
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
                          controller: _valueKetAlatKerjaKeluar,
                          decoration: const InputDecoration(
                              labelText: 'Keterangan Alat Kerja Keluar',
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
                                  child: const Text('Kurangkan Alat Kerja'),
                                  onPressed: () {
                                    validasiStockKeluar(context);
                                  },
                                ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
