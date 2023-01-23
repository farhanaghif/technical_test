import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/perangkat_model/p_jenis_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_kerjasama_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_kondisi_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_lokasi_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_merk_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_perusahaan_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_status_model.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("yyyy-MM-d").format(toLocal());
  }
}

class FormEditPerangkat extends StatefulWidget {
  final PerangkatModel perangkat;
  const FormEditPerangkat(this.perangkat, {Key? key}) : super(key: key);

  @override
  State<FormEditPerangkat> createState() => _FormEditPerangkatState();
}

class _FormEditPerangkatState extends State<FormEditPerangkat> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? tokenBaru;
  List<JenisPerangkatModel> dropdownJenisPerangkat = [];
  List<MerkPerangkatModel> dropdownMerkPerangkat = [];
  List<StatusPerangkatModel> dropdownStatusPerangkat = [];
  List<KondisiPerangkatModel> dropdownKondisiPerangkat = [];
  List<LokasiPerangkatModel> dropdownLokasiPerangkat = [];
  List<PerusahaanModel> dropdownPerusahaanPerangkat = [];
  List<KerjasamaModel> dropdownKerjasamaPerangkat = [];
  bool isLoading = false;

  final TextEditingController _valueNamaPerangkat = TextEditingController();
  final TextEditingController _valueNoInventarisPerangkat =
      TextEditingController();
  int? _selectedJenisPerangkat;
  int? _selectedMerkPerangkat;
  int? _selectedStatusPerangkat;
  int? _selectedKondisiPerangkat;
  int? _selectedLokasiPerangkat;
  final TextEditingController _valueDetailLokasiPerangkat =
      TextEditingController();
  DateTime? _dateSelected;
  String? _selectedChecklistPerangkat;
  String? _selectedStatusKerjasama;
  String? _selectedPerusahaanPerangkat;
  int? _selectedKerjasamaPerangkat;
  final TextEditingController _valueKeteranganPerangkat =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _valueNamaPerangkat.text = widget.perangkat.nmPerangkat.toString();
    _valueNoInventarisPerangkat.text =
        widget.perangkat.noInvPerangkat.toString();
    _valueDetailLokasiPerangkat.text = widget.perangkat.detailLokasi.toString();
    _valueKeteranganPerangkat.text = widget.perangkat.ketPerangkat.toString();
    _selectedJenisPerangkat = widget.perangkat.kdJnsPerangkat;
    _selectedMerkPerangkat = widget.perangkat.kdMerkPerangkat;
    _selectedStatusPerangkat = widget.perangkat.kdStsPerangkat;
    _selectedKondisiPerangkat = widget.perangkat.kdKondisiPerangkat;
    _selectedLokasiPerangkat = widget.perangkat.kdLokasi;
    _selectedChecklistPerangkat = widget.perangkat.isCheck.toString();
    if (_selectedChecklistPerangkat == 'Y') {
      _selectedChecklistPerangkat = 'Yes';
    }
    if (_selectedChecklistPerangkat == 'N') {
      _selectedChecklistPerangkat = 'No';
    }
    _selectedStatusKerjasama = widget.perangkat.isKerjasama.toString();
    if (_selectedStatusKerjasama == 'Y') {
      _selectedStatusKerjasama = 'Yes';
    }
    if (_selectedStatusKerjasama == 'N') {
      _selectedStatusKerjasama = 'No';
    }
    _selectedPerusahaanPerangkat = widget.perangkat.kdPerusahaan.toString();
    _selectedKerjasamaPerangkat = widget.perangkat.kdKerjasama;
    _dateSelected = DateTime.parse(widget.perangkat.tglPerangkat.toString());
    getMerkPerangkat();
    getStatusPerangkat();
    getKondisiPerangkat();
    getLokasiPerangkat();
    getPerusahaan();
    getKerjasama();
  }

  getMerkPerangkat() async {
    Response response;

    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response = await Dio().get(
          "$baseUrl/api/merkperangkat/getMerkPerangkatdariJenis/" +
              widget.perangkat.kdJnsPerangkat.toString(),
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      dropdownMerkPerangkat.clear();
      List merkPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in merkPerangkatAPI) {
          dropdownMerkPerangkat.add(MerkPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getStatusPerangkat() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response =
          await Dio().get("$baseUrl/api/statusperangkat/getStatusPerangkat",
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));
      dropdownStatusPerangkat.clear();
      List statusPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in statusPerangkatAPI) {
          dropdownStatusPerangkat.add(StatusPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getKondisiPerangkat() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response =
          await Dio().get("$baseUrl/api/kondisiperangkat/getKondisiPerangkat",
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));
      dropdownKondisiPerangkat.clear();
      List kondisiPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in kondisiPerangkatAPI) {
          dropdownKondisiPerangkat.add(KondisiPerangkatModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
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

  getPerusahaan() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response = await Dio().get("$baseUrl/api/perusahaan/getPerusahaan",
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      dropdownPerusahaanPerangkat.clear();
      List perusahaanPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in perusahaanPerangkatAPI) {
          dropdownPerusahaanPerangkat.add(PerusahaanModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getKerjasama() async {
    Response response;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      response = await Dio().get("$baseUrl/api/kerjasama/getKerjasamaAktif",
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      dropdownKerjasamaPerangkat.clear();
      List kerjasamaPerangkatAPI = response.data['data'];
      setState(() {
        for (var e in kerjasamaPerangkatAPI) {
          dropdownKerjasamaPerangkat.add(KerjasamaModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  String getDateString() {
    if (_dateSelected == null) {
      return "Pilih tanggal";
      // return widget.perangkat.tglPerangkat.toString();
    }
    return _dateSelected!.getTanggal();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime initialDate =
        (_dateSelected == null) ? DateTime.now() : _dateSelected!;
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 1));

    if (newDate == null) {
      return;
    }
    setState(() {
      _dateSelected = newDate;
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
            title: const Text('Edit Perangkat'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ubah data perangkat',
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
                          controller: _valueNamaPerangkat,
                          decoration: const InputDecoration(
                              helperText: 'Ubah nama perangkat',
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
                          controller: _valueNoInventarisPerangkat,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              helperText: 'Ubah nomor inventaris perangkat',
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
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih jenis perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                  widget.perangkat.nmJnsPerangkat.toString()),
                              value: widget.perangkat.kdJnsPerangkat,
                            ),
                          ],
                          hint:
                              Text(widget.perangkat.nmJnsPerangkat.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedJenisPerangkat = value as int?;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih merk perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: dropdownMerkPerangkat.isEmpty
                              ? [
                                  const DropdownMenuItem(
                                    enabled: false,
                                    child: Text(
                                      'Pilih Jenis Perangkat Terlebih Dahulu',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    value: 'null',
                                  )
                                ]
                              : dropdownMerkPerangkat.map((item) {
                                  return DropdownMenuItem(
                                    child:
                                        Text(item.nmMerkPerangkat.toString()),
                                    value: item.kdMerkPerangkat,
                                  );
                                }).toList(),
                          hint:
                              Text(widget.perangkat.nmMerkPerangkat.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedMerkPerangkat = value as int?;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih status perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: dropdownStatusPerangkat.map((item) {
                            return DropdownMenuItem(
                              child: Text(item.nmStsPerangkat.toString()),
                              value: item.kdStsPerangkat,
                            );
                          }).toList(),
                          hint:
                              Text(widget.perangkat.nmStsPerangkat.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatusPerangkat = value as int?;
                              // measure = value;
                              // measureList.add(measure);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih kondisi perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: dropdownKondisiPerangkat.map((item) {
                            return DropdownMenuItem(
                              child: Text(item.nmKondisiPerangkat.toString()),
                              value: item.kdKondisiPerangkat,
                            );
                          }).toList(),
                          hint: Text(
                              widget.perangkat.nmKondisiPerangkat.toString()),
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
                              helperText: 'Pilih lokasi perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: dropdownLokasiPerangkat.map((item) {
                            return DropdownMenuItem(
                              child: Text(item.nmLokasi.toString()),
                              value: item.kdLokasi,
                            );
                          }).toList(),
                          hint: Text(widget.perangkat.nmLokasi.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedLokasiPerangkat = value as int?;
                              // measure = value;
                              // measureList.add(measure);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _valueDetailLokasiPerangkat,
                          decoration: const InputDecoration(
                              helperText: 'Ubah detail lokasi perangkat',
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
                        GestureDetector(
                          onTap: () => _pickDate(context),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    getDateString(),
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
                              helperText: 'Pilih checklist perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
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
                          hint: Text(_selectedChecklistPerangkat.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedChecklistPerangkat = value.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih status kerjasama perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
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
                          hint: Text(_selectedStatusKerjasama.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatusKerjasama = value.toString();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // DropdownButtonFormField(
                        //   decoration: const InputDecoration(
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(20.0)),
                        //         borderSide:
                        //             BorderSide(color: Colors.grey, width: 0.0),
                        //       ),
                        //       border: OutlineInputBorder()),
                        //   items: dropdownPerusahaanPerangkat.map((item) {
                        //     return DropdownMenuItem(
                        //       child: Text(item.nmPerusahaan.toString()),
                        //       value: item.kdPerusahaan,
                        //     );
                        //   }).toList(),
                        //   hint: Text(widget.perangkat.nmPerusahaan.toString()),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _selectedPerusahaanPerangkat = value.toString();
                        //       // measure = value;
                        //       // measureList.add(measure);
                        //     });
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              helperText: 'Pilih kerjasama perangkat',
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0),
                              ),
                              border: OutlineInputBorder()),
                          items: dropdownKerjasamaPerangkat.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                item.nmKerjasama.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                              value: item.kdKerjasama,
                            );
                          }).toList(),
                          hint: Text(widget.perangkat.nmKerjasama.toString()),
                          onChanged: (value) {
                            setState(() {
                              _selectedKerjasamaPerangkat = value as int?;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _valueKeteranganPerangkat,
                          decoration: const InputDecoration(
                              helperText: 'Ubah keterangan perangkat',
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
                                  child: const Text('Edit Perangkat'),
                                  onPressed: () {
                                    if (_selectedChecklistPerangkat == 'Yes') {
                                      _selectedChecklistPerangkat = 'Y';
                                    }
                                    if (_selectedChecklistPerangkat == 'No') {
                                      _selectedChecklistPerangkat = 'N';
                                    }
                                    if (_selectedStatusKerjasama == 'Yes') {
                                      _selectedStatusKerjasama = 'Y';
                                    }
                                    if (_selectedStatusKerjasama == 'No') {
                                      _selectedStatusKerjasama = 'N';
                                    }
                                    formValidation(context);
                                  },
                                ),
                        ),
                      ],
                    ),
                  )
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

  formValidation(BuildContext context) async {
    bool isFormValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (_valueNamaPerangkat.text.isEmpty ||
        _valueNoInventarisPerangkat.text.isEmpty ||
        _selectedJenisPerangkat == null ||
        _selectedMerkPerangkat == null ||
        _selectedStatusPerangkat == null ||
        _selectedKondisiPerangkat == null ||
        _selectedLokasiPerangkat == null ||
        _valueDetailLokasiPerangkat.text.isEmpty ||
        _dateSelected == null ||
        _selectedChecklistPerangkat == null ||
        _selectedStatusKerjasama == null ||
        _selectedKerjasamaPerangkat == null ||
        _valueKeteranganPerangkat.text.isEmpty) {
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
          _valueNamaPerangkat.text,
          _valueNoInventarisPerangkat.text,
          _selectedJenisPerangkat,
          _selectedMerkPerangkat,
          _selectedStatusPerangkat,
          _selectedKondisiPerangkat,
          _selectedLokasiPerangkat,
          _valueDetailLokasiPerangkat.text,
          _dateSelected,
          _selectedChecklistPerangkat,
          _selectedStatusKerjasama,
          _selectedPerusahaanPerangkat,
          _selectedKerjasamaPerangkat,
          _valueKeteranganPerangkat.text);
    }
    setState(() => isLoading = false);
  }

  Future<void> prosesTambahPerangkat(
      BuildContext context,
      String namaPerangkat,
      String noInventaris,
      jenisPerangkat,
      merkPerangkat,
      statusPerangkat,
      kondisiPerangkat,
      lokasiPerangkat,
      String detailLokasi,
      date,
      checklist,
      statusKerjasama,
      perusahaan,
      kerjasama,
      String keterangan) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      var getKodePerangkat = widget.perangkat.kdPerangkat;
      final Response response =
          await Dio().put('$baseUrl/api/perangkat/update/$getKodePerangkat',
              data: {
                'nm_perangkat': namaPerangkat,
                'no_inv_perangkat': noInventaris,
                'kd_jns_perangkat': jenisPerangkat,
                'kd_merk_perangkat': merkPerangkat,
                'kd_sts_perangkat': statusPerangkat,
                'kd_kondisi_perangkat': kondisiPerangkat,
                'kd_lokasi': lokasiPerangkat,
                'tgl_perangkat': date.toString(),
                'is_check': checklist,
                'is_kerjasama': statusKerjasama,
                'kd_perusahaan': perusahaan,
                'kd_kerjasama': kerjasama,
                'ket_perangkat': keterangan,
                'detail_lokasi': detailLokasi
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon = response.data['pesan_success'];
          // String respon = 'Perangkat berhasil diubah';
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
