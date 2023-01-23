import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/p3k.dart';
import 'package:risa_reborn/screen/perangkat/lokasi/master_lokasi.dart';

class FormKeluarP3K extends StatefulWidget {
  final P3KModel p3k;
  const FormKeluarP3K(this.p3k, {Key? key}) : super(key: key);

  @override
  State<FormKeluarP3K> createState() => _FormKeluarP3KState();
}

class _FormKeluarP3KState extends State<FormKeluarP3K> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;

  final _valueNamaStock = TextEditingController();
  final _valueJmlStockKeluar = TextEditingController();
  final _valueKetStockKeluar = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueNamaStock.text = widget.p3k.nmP3k.toString();
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  formValidation(BuildContext context) async {
    bool isFormValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (_valueNamaStock.text.isEmpty ||
        _valueKetStockKeluar.text.isEmpty ||
        _valueJmlStockKeluar.text.isEmpty) {
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
      await prosesStockKeluar(context, _valueNamaStock.text,
          _valueJmlStockKeluar.text, _valueKetStockKeluar.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesStockKeluar(BuildContext context, String namaStock,
      String jumlahStockKeluar, String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().post('$baseUrl/api/p3k/storeP3KKeluar',
              data: {
                "kd_p3k": widget.p3k.kdP3k,
                "jml_p3k_keluar": jumlahStockKeluar,
                "ket_p3k_keluar": keterangan
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon =
              "Berhasil mengurangi ${widget.p3k.nmP3k} sebanyak $jumlahStockKeluar";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
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

  validasiStockKeluar(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    bool cekJumlah = true;
    int cekHasilAkhir =
        widget.p3k.stockP3k! - int.parse(_valueJmlStockKeluar.text);
    if (cekHasilAkhir < 0) {
      cekJumlah = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Melebihi jumlah stock'),
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
                Navigator.of(context).pop(
                    MaterialPageRoute(builder: (context) => const Lokasi()));
              },
            ),
            title: const Text('Mengurangi Stock'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Masukkan Data Stock',
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
                          controller: _valueNamaStock,
                          decoration: const InputDecoration(
                              enabled: false,
                              labelText: 'Nama stock',
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
                          controller: _valueJmlStockKeluar,
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
                          controller: _valueKetStockKeluar,
                          decoration: const InputDecoration(
                              labelText: 'Keterangan stock keluar ',
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
                                  child: const Text('Kurangkan Stock'),
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
