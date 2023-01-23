import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/perangkat_model/p_lokasi_model.dart';
import 'package:risa_reborn/model/stock_model/kategori_stock_model.dart';

class FormTambahStock extends StatefulWidget {
  const FormTambahStock({Key? key}) : super(key: key);

  @override
  State<FormTambahStock> createState() => _FormTambahStockState();
}

class _FormTambahStockState extends State<FormTambahStock> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;
  List<LokasiPerangkatModel> dropdownLokasiPerangkat = [];
  List<KategoriStockModel> dropdownKategoriStock = [];

  final _valueNamaStock = TextEditingController();
  final _valueSatuanStock = TextEditingController();
  final _valueDetailLokasi = TextEditingController();
  int? _selectedKategoriStock;
  int? _selectedLokasiPerangkat;

  @override
  void initState() {
    super.initState();
    getLokasiPerangkat();
    getKategoriStock();
  }

  getLokasiPerangkat() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response = await Dio().get("$baseUrl/api/lokasi/getLokasi",
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      dropdownLokasiPerangkat.clear();
      List lokasiPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in lokasiPerangkatAPI) {
          dropdownLokasiPerangkat.add(LokasiPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getKategoriStock() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response =
          await Dio().get("$baseUrl/api/kategoristock/getKategoriStockAktif",
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));
      dropdownKategoriStock.clear();
      List kategoriStockAPI = response.data['data'];
      setState(() {
        for (var e in kategoriStockAPI) {
          dropdownKategoriStock.add(KategoriStockModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
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
        _valueDetailLokasi.text.isEmpty ||
        _selectedLokasiPerangkat == null ||
        _selectedKategoriStock == null ||
        _valueSatuanStock.text.isEmpty) {
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
      await prosesTambahPerangkat(
          context,
          _valueNamaStock.text,
          _valueSatuanStock.text,
          _selectedLokasiPerangkat,
          _selectedKategoriStock,
          _valueDetailLokasi.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesTambahPerangkat(
      BuildContext context,
      String namaStock,
      String satuanStock,
      lokasiPerangkat,
      kategoriStock,
      String detailLokasi) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response = await Dio().post('$baseUrl/api/stock/store',
          data: {
            'nm_stock': namaStock,
            'kd_kategori_stock': kategoriStock,
            'kd_lokasi': lokasiPerangkat,
            'satuan': satuanStock,
            'detail_lokasi': detailLokasi,
          },
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon = "Berhasil menambah stock '${_valueNamaStock.text}'";
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
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Tambah Stock'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Masukkan Data Stock',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                                labelText: 'Masukkan nama stock',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih kategori stock',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownKategoriStock.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmKategoriStock.toString()),
                                value: item.kdKategoriStock,
                              );
                            }).toList(),
                            hint: const Text(
                                "Tekan untuk memilih kategori stock"),
                            onChanged: (value) {
                              setState(() {
                                _selectedKategoriStock = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih lokasi stock',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownLokasiPerangkat.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmLokasi.toString()),
                                value: item.kdLokasi,
                              );
                            }).toList(),
                            hint:
                                const Text("Tekan untuk memilih lokasi stock"),
                            onChanged: (value) {
                              setState(() {
                                _selectedLokasiPerangkat = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _valueSatuanStock,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan satuan stock',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _valueDetailLokasi,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan detail lokasi',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      primary: const Color.fromARGB(
                                          255, 30, 156, 230),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
            ),
          )),
    );
  }
}
