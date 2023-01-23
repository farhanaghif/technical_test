import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/a_fasilitas_pelabuhan.dart';
import 'package:risa_reborn/model/perangkat_model/p_kondisi_model.dart';
import 'package:risa_reborn/screen/barang_apd/inventory/apd_list.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("yyyy-MM-d").format(toLocal());
  }
}

class APDFormTambah extends StatefulWidget {
  const APDFormTambah({Key? key}) : super(key: key);

  @override
  State<APDFormTambah> createState() => _APDFormTambahState();
}

class _APDFormTambahState extends State<APDFormTambah> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;
  List<FasilitasPelabuhanP3KModel> dropdownFasilitasPelabuhanP3K = [];
  List<KondisiPerangkatModel> dropdownKondisiPerangkat = [];

  final _valueNamaAPD = TextEditingController();
  final _valueDetailLokasi = TextEditingController();
  final _valueKeteranganAPD = TextEditingController();
  DateTime? _tglPembelian;
  DateTime? _tglAkhirMasaBerlaku;
  int? _selectedFasilitasPelabuhan;
  int? _selectedKondisiPerangkat;
  String? _selectedChecklist;

  @override
  void initState() {
    super.initState();
    getFasilitasPelabuhanP3K();
    getKondisiPerangkat();
  }

  getFasilitasPelabuhanP3K() async {
    Response respFasPel;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respFasPel = await Dio().get(
          "$baseUrl/api/fasilitaspelabuhan/getFasilitasPelabuhanAktif",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownFasilitasPelabuhanP3K.clear();
      List fasilitasPelabuhanP3KAPI = respFasPel.data['data'];
      setState(() {
        for (var e in fasilitasPelabuhanP3KAPI) {
          dropdownFasilitasPelabuhanP3K
              .add(FasilitasPelabuhanP3KModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getKondisiPerangkat() async {
    Response respKondisiPerangkat;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respKondisiPerangkat = await Dio().get(
          "$baseUrl/api/kondisiperangkat/getKondisiPerangkat",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownKondisiPerangkat.clear();
      List kondisiPerangkatAPI = respKondisiPerangkat.data['data'];
      setState(() {
        for (var e in kondisiPerangkatAPI) {
          dropdownKondisiPerangkat.add(KondisiPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  String pilihTanggalAwal() {
    if (_tglPembelian == null) {
      return "Pilih tanggal awal masa berlaku";
    }
    return _tglPembelian!.getTanggal();
  }

  Future<void> _pilihTanggalAwal(BuildContext context) async {
    final DateTime initialDate =
        (_tglPembelian == null) ? DateTime.now() : _tglPembelian!;
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));

    if (newDate == null) {
      return;
    }
    setState(() {
      _tglPembelian = newDate;
    });
  }

  String pilihTanggalAkhir() {
    if (_tglAkhirMasaBerlaku == null) {
      return "Pilih tanggal akhir masa berlaku";
    }
    return _tglAkhirMasaBerlaku!.getTanggal();
  }

  Future<void> _pilihTanggalAkhir(BuildContext context) async {
    final DateTime initialDate =
        (_tglAkhirMasaBerlaku == null) ? DateTime.now() : _tglAkhirMasaBerlaku!;
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));

    if (newDate == null) {
      return;
    }
    setState(() {
      _tglAkhirMasaBerlaku = newDate;
    });
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
            title: const Text('Tambah Barang APD'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Masukkan Data Barang APD',
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
                            controller: _valueNamaAPD,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Nama Barang APD',
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
                                helperText: 'Pilih fasilitas pelabuhan',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownFasilitasPelabuhanP3K.map((item) {
                              return DropdownMenuItem(
                                child:
                                    Text(item.nmFasilitasPelabuhan.toString()),
                                value: item.kdFasilitasPelabuhan,
                              );
                            }).toList(),
                            hint: const Text(
                                "Tekan untuk memilih fasilitas pelabuhan"),
                            onChanged: (value) {
                              setState(() {
                                _selectedFasilitasPelabuhan = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _valueDetailLokasi,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Detail Lokasi Barang APD',
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
                          GestureDetector(
                            onTap: () => _pilihTanggalAwal(context),
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      pilihTanggalAwal(),
                                    ),
                                    const Icon(Icons.calendar_month_outlined),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () => _pilihTanggalAkhir(context),
                            child: Container(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      pilihTanggalAkhir(),
                                    ),
                                    const Icon(Icons.calendar_month_outlined),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih Kondisi APD',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownKondisiPerangkat.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmKondisiPerangkat.toString()),
                                value: item.kdKondisiPerangkat,
                              );
                            }).toList(),
                            hint: const Text(
                                "Tekan untuk memilih status kondisi APD"),
                            onChanged: (value) {
                              setState(() {
                                _selectedKondisiPerangkat = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih status checklist',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(
                                child: Text("Ya"),
                                value: 'Y',
                              ),
                              DropdownMenuItem(
                                child: Text("Tidak"),
                                value: 'N',
                              )
                            ],
                            hint: const Text(
                                "Tekan untuk memilih status checklist"),
                            onChanged: (value) {
                              setState(() {
                                _selectedChecklist = value.toString();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _valueKeteranganAPD,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Keterangan Barang APD',
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: () {
                              formValidation(context);
                            },
                            child: const Text("Tambah Barang APD"),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ))
                ],
              ),
            ),
          )),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  formValidation(contex) async {
    bool isFormValid = true;
    FocusScope.of(contex).requestFocus(FocusNode());

    if (_valueNamaAPD.text.isEmpty ||
        _valueDetailLokasi.text.isEmpty ||
        _valueKeteranganAPD.text.isEmpty ||
        _tglPembelian == null ||
        _tglAkhirMasaBerlaku == null ||
        _selectedFasilitasPelabuhan == null ||
        _selectedKondisiPerangkat == null ||
        _selectedChecklist == null) {
      isFormValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Input tidak boleh ada yang kosong'),
            backgroundColor: Colors.red,
          ),
        );
      });
      setState(() => isLoading = true);
    }

    if (isFormValid) {
      await prosesTambahBarangAPD(
          context,
          _valueNamaAPD.text,
          _valueDetailLokasi.text,
          _valueKeteranganAPD.text,
          _tglPembelian,
          _tglAkhirMasaBerlaku,
          _selectedFasilitasPelabuhan,
          _selectedKondisiPerangkat,
          _selectedChecklist);
      setState(() => isLoading = false);
    }
  }

  Future<void> prosesTambahBarangAPD(
      context,
      namaAPD,
      detailLokasi,
      keteranganBarangAPD,
      tanggalPembelian,
      tanggalAkhir,
      fasilitasPelabuhan,
      kondisiPerangkat,
      checklist) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response = await Dio().post('$baseUrl/api/apd/store',
          data: {
            'nm_apd': namaAPD,
            'kd_fasilitas_pelabuhan': fasilitasPelabuhan,
            'detail_lokasi': detailLokasi,
            'kd_kondisi_perangkat': kondisiPerangkat,
            'tgl_pembelian': tanggalPembelian.toString(),
            'tgl_akhir_masaberlaku': tanggalAkhir.toString(),
            'is_check': checklist,
            'ket_apd': keteranganBarangAPD,
          },
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon = response.data['pesan_success'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
        //homePage
        // Get.off(const APDList());
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
