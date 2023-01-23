import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apar_model/a_bahan_model.dart';
import 'package:risa_reborn/model/apar_model/a_fasilitas_pelabuhan_model.dart';
import 'package:risa_reborn/model/apar_model/a_klasifikasi_kebakaran_model.dart';
import 'package:risa_reborn/model/apar_model/a_kondisi_tabung.dart';
import 'package:risa_reborn/model/apar_model/a_model.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("yyyy-MM-d").format(toLocal());
  }
}

class AparFormEdit extends StatefulWidget {
  final AparModel apar;
  const AparFormEdit(this.apar, {Key? key}) : super(key: key);

  @override
  State<AparFormEdit> createState() => _AparFormEditState();
}

class _AparFormEditState extends State<AparFormEdit> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? tokenBaru;
  bool isLoading = false;
  List<FasilitasPelabuhanModel> dropdownFasilitasPelabuhan = [];
  List<BahanAparModel> dropdownBahanApar = [];
  List<KlasifikasiKebakaranModel> dropdownKlasifikasiKebakaran = [];
  List<KondisiTabungModel> dropdownKondisiTabung = [];

  final _valueNamaApar = TextEditingController();
  final _valueDetailLokasi = TextEditingController();
  final _valueAlasanGanti = TextEditingController();
  final _valueKeteranganApar = TextEditingController();
  DateTime? _tglBerlakuAwal;
  DateTime? _tglBerlakuAkhir;
  int? _selectedFasilitasPelabuhan;
  int? _selectedBahanApar;
  int? _selectedKlasifikasiKebakaran;
  String? _selectedTekananTabung;
  int? _selectedKondisiTabung;
  String? _selectedChecklist;

  @override
  void initState() {
    super.initState();
    _valueNamaApar.text = widget.apar.nmApar.toString();
    _valueDetailLokasi.text = widget.apar.detailLokasi.toString();
    _valueAlasanGanti.text = widget.apar.alasanGanti.toString();
    _valueKeteranganApar.text = widget.apar.ketApar.toString();
    _tglBerlakuAwal = DateTime.parse(widget.apar.tglAwalMasaberlaku.toString());
    _tglBerlakuAkhir =
        DateTime.parse(widget.apar.tglAkhirMasaberlaku.toString());
    _selectedFasilitasPelabuhan = widget.apar.kdFasilitasPelabuhan;
    _selectedBahanApar = widget.apar.kdBhnApar;
    _selectedKlasifikasiKebakaran = widget.apar.kdKlasifikasiKebakaran;
    if (widget.apar.tekananTabung == 'Y') {
      _selectedTekananTabung = 'Hijau/Isi';
    }
    if (widget.apar.tekananTabung == 'N') {
      _selectedTekananTabung = 'Merah/Kosong';
    }
    _selectedKondisiTabung = widget.apar.kdKondisiTabung;
    if (widget.apar.isCheck == 'Y') {
      _selectedChecklist = 'Ya';
    }
    if (widget.apar.isCheck == 'N') {
      _selectedChecklist = 'Tidak';
    }
    getFasilitasPelabuhan();
    getBahanAPAR();
    getKlasifikasiKebakaran();
    getKondisiTabung();
  }

  getFasilitasPelabuhan() async {
    Response respFasPel;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respFasPel = await Dio().get(
          "$baseUrl/api/fasilitaspelabuhan/getFasilitasPelabuhanAktif",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownFasilitasPelabuhan.clear();
      List fasilitasPelabuhanAPI = respFasPel.data['data'];
      setState(() {
        for (var e in fasilitasPelabuhanAPI) {
          dropdownFasilitasPelabuhan.add(FasilitasPelabuhanModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getBahanAPAR() async {
    Response respBahanAPAR;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respBahanAPAR = await Dio().get(
          "$baseUrl/api/bahanapar/getBahanAparAktif",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownBahanApar.clear();
      List bahanAparAPI = respBahanAPAR.data['data'];
      setState(() {
        for (var e in bahanAparAPI) {
          dropdownBahanApar.add(BahanAparModel.fromJson(e));
        }
        dropdownBahanApar.removeAt(0);
      });
    } catch (e) {
      // print(e);
    }
  }

  getKlasifikasiKebakaran() async {
    Response respKlasKeb;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respKlasKeb = await Dio().get(
          "$baseUrl/api/klasifikasikebakaran/getKlasifikasiKebakaranAktif",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownKlasifikasiKebakaran.clear();
      List bahanAparAPI = respKlasKeb.data['data'];
      setState(() {
        for (var e in bahanAparAPI) {
          dropdownKlasifikasiKebakaran
              .add(KlasifikasiKebakaranModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  getKondisiTabung() async {
    Response respKonTab;
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      respKonTab = await Dio().get(
          "$baseUrl/api/kondisitabung/getKondisiTabungAktif",
          options: Options(headers: {"Authorization": "Bearer $tokenBaru"}));
      dropdownKondisiTabung.clear();
      List kondisiTabungAPI = respKonTab.data['data'];
      setState(() {
        for (var e in kondisiTabungAPI) {
          dropdownKondisiTabung.add(KondisiTabungModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  String pilihTanggalAwal() {
    if (_tglBerlakuAwal == null) {
      return "Pilih tanggal awal masa berlaku";
    }
    return _tglBerlakuAwal!.getTanggal();
  }

  Future<void> _pilihTanggalAwal(BuildContext context) async {
    final DateTime initialDate =
        (_tglBerlakuAwal == null) ? DateTime.now() : _tglBerlakuAwal!;
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));

    if (newDate == null) {
      return;
    }
    setState(() {
      _tglBerlakuAwal = newDate;
    });
  }

  String pilihTanggalAkhir() {
    if (_tglBerlakuAkhir == null) {
      return "Pilih tanggal akhir masa berlaku";
    }
    return _tglBerlakuAkhir!.getTanggal();
  }

  Future<void> _pilihTanggalAkhir(BuildContext context) async {
    final DateTime initialDate =
        (_tglBerlakuAkhir == null) ? DateTime.now() : _tglBerlakuAkhir!;
    final DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));

    if (newDate == null) {
      return;
    }
    setState(() {
      _tglBerlakuAkhir = newDate;
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
            title: Text('Edit data ${widget.apar.nmApar}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ubah Data APAR',
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
                            controller: _valueNamaApar,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Nama APAR',
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
                            items: dropdownFasilitasPelabuhan.map((item) {
                              return DropdownMenuItem(
                                child:
                                    Text(item.nmFasilitasPelabuhan.toString()),
                                value: item.kdFasilitasPelabuhan,
                              );
                            }).toList(),
                            hint: Text(
                                widget.apar.nmFasilitasPelabuhan.toString()),
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
                                labelText: 'Masukkan Detail Lokasi APAR',
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
                                helperText: 'Pilih bahan APAR',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownBahanApar.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmBhnApar.toString()),
                                value: item.kdBhnApar,
                              );
                            }).toList(),
                            hint: Text(widget.apar.nmBhnApar.toString()),
                            onChanged: (value) {
                              setState(() {
                                _selectedBahanApar = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih klasifikasi kebakaran',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownKlasifikasiKebakaran.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                    item.nmKlasifikasiKebakaran.toString()),
                                value: item.kdKlasifikasiKebakaran,
                              );
                            }).toList(),
                            hint: Text(
                                widget.apar.nmKlasifikasiKebakaran.toString()),
                            onChanged: (value) {
                              setState(() {
                                _selectedKlasifikasiKebakaran = value as int?;
                              });
                            },
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
                                helperText: 'Pilih status tekanan tabung',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(
                                child: Text("Hijau/Isi"),
                                value: 'Y',
                              ),
                              DropdownMenuItem(
                                child: Text("Merah/Kosong"),
                                value: 'N',
                              )
                            ],
                            hint: Text(
                              _selectedTekananTabung.toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedTekananTabung = value.toString();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                                helperText: 'Pilih kondisi tabung',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: OutlineInputBorder()),
                            items: dropdownKondisiTabung.map((item) {
                              return DropdownMenuItem(
                                child: Text(item.nmKondisiTabung.toString()),
                                value: item.kdKondisiTabung,
                              );
                            }).toList(),
                            hint: Text(widget.apar.nmKondisiTabung.toString()),
                            onChanged: (value) {
                              setState(() {
                                _selectedKondisiTabung = value as int?;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _valueAlasanGanti,
                            decoration: const InputDecoration(
                                labelText:
                                    'Masukkan Alasan Ganti APAR (opsional)',
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
                            controller: _valueKeteranganApar,
                            decoration: const InputDecoration(
                                labelText: 'Masukkan Keterangan APAR',
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
                              if (_selectedTekananTabung == 'Hijau/Isi') {
                                _selectedTekananTabung = 'Y';
                              }
                              if (_selectedTekananTabung == 'Merah/Kosong') {
                                _selectedTekananTabung = 'N';
                              }
                              if (_selectedChecklist == 'Ya') {
                                _selectedChecklist = 'Y';
                              }
                              if (_selectedChecklist == 'Tidak') {
                                _selectedChecklist = 'N';
                              }
                              formValidation(context);
                            },
                            child: const Text("Edit APAR"),
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

    if (_valueNamaApar.text.isEmpty ||
        _valueDetailLokasi.text.isEmpty ||
        _valueKeteranganApar.text.isEmpty ||
        _tglBerlakuAwal == null ||
        _tglBerlakuAkhir == null ||
        _selectedFasilitasPelabuhan == null ||
        _selectedBahanApar == null ||
        _selectedKlasifikasiKebakaran == null ||
        _selectedTekananTabung == null ||
        _selectedKondisiTabung == null ||
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
      await prosesEditAPAR(
          context,
          _valueNamaApar.text,
          _valueDetailLokasi.text,
          _valueAlasanGanti.text,
          _valueKeteranganApar.text,
          _tglBerlakuAwal,
          _tglBerlakuAkhir,
          _selectedFasilitasPelabuhan,
          _selectedBahanApar,
          _selectedKlasifikasiKebakaran,
          _selectedTekananTabung,
          _selectedKondisiTabung,
          _selectedChecklist);
      setState(() => isLoading = false);
    }
  }

  Future<void> prosesEditAPAR(
      context,
      namaAPAR,
      detailLokasi,
      alasanGanti,
      keteranganApar,
      tglBerlakuAwal,
      tglBerlakuAkhir,
      fasilitasPelabuhan,
      bahanAPAR,
      klasifikasiKebakaran,
      tekananTabung,
      kondisiTabung,
      checklist) async {
    try {
      var tokenBaru = await dataStorage.read(key: 'token_baru');
      final Response response =
          await Dio().put('$baseUrl/api/apar/update/${widget.apar.kdApar}',
              data: {
                'nm_apar': namaAPAR,
                'kd_fasilitas_pelabuhan': fasilitasPelabuhan,
                'detail_lokasi': detailLokasi,
                'kd_bhn_apar': bahanAPAR,
                'kd_klasifikasi_kebakaran': klasifikasiKebakaran,
                'tgl_awal_masaberlaku': tglBerlakuAwal.toString(),
                'tgl_akhir_masaberlaku': tglBerlakuAkhir.toString(),
                'tekanan_tabung': tekananTabung,
                'kd_kondisi_tabung': kondisiTabung,
                'alasan_ganti': alasanGanti,
                'is_check': checklist,
                'ket_apar': keteranganApar,
              },
              options: Options(headers: {
                "Authorization": "Bearer $tokenBaru",
              }));

      if (response.statusCode == 200) {
        _onWidgetDidBuild(() {
          String respon = 'Data $namaAPAR berhasil diubah';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(respon),
              backgroundColor: Colors.green,
            ),
          );
        });
        //homePage
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
