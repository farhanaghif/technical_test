import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/a_fasilitas_pelabuhan.dart';
import 'package:risa_reborn/model/peralatan_model/peralatan_kerja.dart';
import 'package:risa_reborn/model/perangkat_model/p_kondisi_model.dart';
import 'package:risa_reborn/screen/peralatan_kerja/inventory/alat_kerja_list.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("yyyy-MM-d").format(toLocal());
  }
}

class AlatKerjaFormEdit extends StatefulWidget {
  final PeralatankerjaModel alatKerja;
  const AlatKerjaFormEdit(this.alatKerja, {Key? key}) : super(key: key);

  @override
  State<AlatKerjaFormEdit> createState() => _AlatKerjaFormEditState();
}

class _AlatKerjaFormEditState extends State<AlatKerjaFormEdit> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;
  List<FasilitasPelabuhanP3KModel> dropdownFasilitasPelabuhanP3K = [];
  List<KondisiPerangkatModel> dropdownKondisiPerangkat = [];

  final _nmPeralatanKerja = TextEditingController();
  final _valueDetailLokasi = TextEditingController();
  final _valueketPeralatanKerja = TextEditingController();
  DateTime? _tglPembelian;
  int? _selectedFasilitasPelabuhan;
  int? _selectedKondisiPerangkat;
  String? _selectedChecklist;

  @override
  void initState() {
    super.initState();
    _nmPeralatanKerja.text = widget.alatKerja.nmPeralatanKerja.toString();
    _valueDetailLokasi.text = widget.alatKerja.detailLokasi.toString();
    _valueketPeralatanKerja.text =
        widget.alatKerja.ketPeralatanKerja.toString();
    _tglPembelian = DateTime.parse(widget.alatKerja.tglPembelian.toString());
    _selectedFasilitasPelabuhan = widget.alatKerja.kdFasilitasPelabuhan;
    _selectedKondisiPerangkat = widget.alatKerja.kdKondisiPerangkat;
    _selectedChecklist = widget.alatKerja.isCheck;
    if (widget.alatKerja.isCheck == 'Y') {
      _selectedChecklist = 'Ya';
    }
    if (widget.alatKerja.isCheck == 'N') {
      _selectedChecklist = 'Tidak';
    }
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
        dropdownKondisiPerangkat.removeAt(0);
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
            title: const Text('Edit Alat Kerja'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Masukkan Data Alat Kerja',
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
                            controller: _nmPeralatanKerja,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Nama Alat Kerja',
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
                            hint: Text(widget.alatKerja.nmFasilitasPelabuhan
                                .toString()),
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
                                labelText: 'Masukkan Detail Lokasi Alat Kerja',
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
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih Kondisi Alat Kerja',
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
                            hint: Text(
                                widget.alatKerja.nmKondisiPerangkat.toString()),
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
                            hint: Text(_selectedChecklist.toString()),
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
                            controller: _valueketPeralatanKerja,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Keterangan Alat Kerja',
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
                              if (_selectedChecklist == 'Ya') {
                                _selectedChecklist = 'Y';
                              }
                              if (_selectedChecklist == 'Tidak') {
                                _selectedChecklist = 'N';
                              }
                              formValidation(context);
                            },
                            child: const Text("Update Alat Kerja"),
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

    if (_nmPeralatanKerja.text.isEmpty ||
        _valueDetailLokasi.text.isEmpty ||
        _valueketPeralatanKerja.text.isEmpty ||
        _tglPembelian == null ||
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
      await prosesEditBarangAPD(
          context,
          _nmPeralatanKerja.text,
          _valueDetailLokasi.text,
          _valueketPeralatanKerja.text,
          _tglPembelian,
          _selectedFasilitasPelabuhan,
          _selectedKondisiPerangkat,
          _selectedChecklist);
      setState(() => isLoading = false);
    }
  }

  Future<void> prosesEditBarangAPD(
      context,
      nmPeralatanKerja,
      detailLokasi,
      ketPeralatanKerja,
      tanggalPembelian,
      fasilitasPelabuhan,
      kondisiPerangkat,
      checklist) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response = await Dio().put(
          '$baseUrl/api/peralatankerja/update/${widget.alatKerja.kdPeralatanKerja}',
          data: {
            'nm_peralatan_kerja': nmPeralatanKerja,
            'kd_fasilitas_pelabuhan': fasilitasPelabuhan,
            'detail_lokasi': detailLokasi,
            'kd_kondisi_perangkat': kondisiPerangkat,
            'tgl_pembelian': tanggalPembelian.toString(),
            'is_check': checklist,
            'ket_peralatan_kerja': ketPeralatanKerja,
          },
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          // var respon = response.data['pesan_success'];
          var respon = "Berhasil Mengupdate";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
        //homePage
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
}
