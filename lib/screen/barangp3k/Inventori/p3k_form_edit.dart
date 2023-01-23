import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/a_fasilitas_pelabuhan.dart';
import 'package:risa_reborn/model/p3k_model/p3k.dart';
import 'package:risa_reborn/model/p3k_model/type_p3k.dart';
import 'package:risa_reborn/screen/barangp3k/Inventori/p3k_list.dart';

extension DateMYString on DateTime {
  String getMonthYearDisplay() {
    return DateFormat("yyyy-MM-d").format(toLocal());
  }
}

class P3KFormEdit extends StatefulWidget {
  final P3KModel p3k;
  const P3KFormEdit(this.p3k, {Key? key}) : super(key: key);

  @override
  State<P3KFormEdit> createState() => _P3KFormEditState();
}

class _P3KFormEditState extends State<P3KFormEdit> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;
  List<FasilitasPelabuhanP3KModel> dropdownFasilitasPelabuhanP3K = [];
  List<P3KTipeModel> dropdownTipeP3K = [];

  final _valueNamaP3K = TextEditingController();
  final _valueDetailLokasi = TextEditingController();
  int? _selectedFasilitasPelabuhan;
  int? _selectedTipeP3K;
  final _valueKeteranganP3K = TextEditingController();
  String? _selectedChecklist;

  @override
  void initState() {
    super.initState();
    getFasilitasPelabuhanP3K();
    getTipeP3K();
    _valueNamaP3K.text = widget.p3k.nmP3k.toString();
    _valueDetailLokasi.text = widget.p3k.detailLokasi.toString();
    _selectedFasilitasPelabuhan = widget.p3k.kdFasilitasPelabuhan;
    _selectedTipeP3K = widget.p3k.kdTypeP3k;
    _valueKeteranganP3K.text = widget.p3k.nmP3k.toString();
    _selectedChecklist = widget.p3k.isCheck;
    if (widget.p3k.isCheck == 'Y') {
      _selectedChecklist = 'Ya';
    }
    if (widget.p3k.isCheck == 'N') {
      _selectedChecklist = 'Tidak';
    }
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

  getTipeP3K() async {
    Response respTipeP3K;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respTipeP3K = await Dio().get("$baseUrl/api/typep3k/getTypeP3K",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownTipeP3K.clear();
      List p3KTipeModelAPI = respTipeP3K.data['data'];
      setState(() {
        for (var e in p3KTipeModelAPI) {
          dropdownTipeP3K.add(P3KTipeModel.fromJson(e));
        }
        dropdownTipeP3K.removeAt(0);
      });
    } catch (e) {
      // print(e);
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
            title: const Text('Edit Barang P3K'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Masukkan Data Barang P3K',
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
                            controller: _valueNamaP3K,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Nama Barang P3K',
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
                            hint: Text(
                                widget.p3k.nmFasilitasPelabuhan.toString()),
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
                                labelText: 'Masukkan Detail Lokasi Barang P3K',
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
                                helperText: 'Pilih Tipe Barang P3K',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownTipeP3K.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmTypeP3k.toString()),
                                value: item.kdTypeP3k,
                              );
                            }).toList(),
                            hint: Text(widget.p3k.nmTypeP3k.toString()),
                            onChanged: (value) {
                              setState(() {
                                _selectedTipeP3K = value as int?;
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
                            controller: _valueKeteranganP3K,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Keterangan Barang P3K',
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
                            child: const Text("Edit Barang P3K"),
                          ),
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

    if (_valueNamaP3K.text.isEmpty ||
        _valueDetailLokasi.text.isEmpty ||
        _valueKeteranganP3K.text.isEmpty ||
        _selectedFasilitasPelabuhan == null ||
        _selectedTipeP3K == null ||
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
      await prosesEditBarangP3K(
          context,
          _valueNamaP3K.text,
          _valueDetailLokasi.text,
          _valueKeteranganP3K.text,
          _selectedFasilitasPelabuhan,
          _selectedTipeP3K,
          _selectedChecklist);
      setState(() => isLoading = false);
    }
  }

  Future<void> prosesEditBarangP3K(context, namaP3K, detailLokasi,
      keteranganBarangP3K, fasilitasPelabuhan, tipeP3k, checklist) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().put('$baseUrl/api/p3k/update/${widget.p3k.kdP3k}',
              data: {
                'nm_p3k': namaP3K,
                'kd_fasilitas_pelabuhan': fasilitasPelabuhan,
                'detail_lokasi': detailLokasi,
                'kd_type_p3k': tipeP3k,
                'ket_p3k': keteranganBarangP3K,
                'is_check': checklist,
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
        Get.off(const P3Klist());
        // Get.back();
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
