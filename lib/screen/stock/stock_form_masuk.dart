import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/stock_model/stock_model.dart';

class FormStockMasuk extends StatefulWidget {
  final StockModel stock;
  const FormStockMasuk(this.stock, {Key? key}) : super(key: key);

  @override
  State<FormStockMasuk> createState() => _FormStockMasukState();
}

class _FormStockMasukState extends State<FormStockMasuk> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;

  final _valueNamaStock = TextEditingController();
  final _valueJmlStockMasuk = TextEditingController();
  final _valueKetStockMasuk = TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueNamaStock.text = widget.stock.nmStock.toString();
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
        _valueKetStockMasuk.text.isEmpty ||
        _valueJmlStockMasuk.text.isEmpty) {
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
      await prosesStockMasuk(context, _valueNamaStock.text,
          _valueJmlStockMasuk.text, _valueKetStockMasuk.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesStockMasuk(BuildContext context, String namaStock,
      String jumlahStockMasuk, String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().post('$baseUrl/api/stock/storeStockMasuk',
              data: {
                "kd_stock": widget.stock.kdStock,
                "jml_stock_msk": jumlahStockMasuk,
                "ket_stock_msk": keterangan
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon =
              "Berhasil menambah jumlah stock sebanyak $jumlahStockMasuk ${widget.stock.satuan}";
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
            title: const Text('Menambahkan Stock'),
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
                          controller: _valueJmlStockMasuk,
                          decoration: const InputDecoration(
                              labelText: 'Jumlah penambahan',
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
                          controller: _valueKetStockMasuk,
                          decoration: const InputDecoration(
                              labelText: 'Keterangan stock masuk',
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
                                  child: const Text('Tambah Stock'),
                                  onPressed: () {
                                    formValidation(context);
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
