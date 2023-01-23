import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/peralatan_model/peralatan_kerja.dart';
import 'package:risa_reborn/model/peralatan_model/riwayat_alat_kerja.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("d MMM HH:mm").format(toLocal());
  }
}

class RiwayatAlatKerja extends StatefulWidget {
  final PeralatankerjaModel detailAlatKerja;
  const RiwayatAlatKerja(this.detailAlatKerja, {Key? key}) : super(key: key);

  @override
  State<RiwayatAlatKerja> createState() => _RiwayatAlatKerjaState();
}

class _RiwayatAlatKerjaState extends State<RiwayatAlatKerja> {
  List<RiwayatAlatKerjaModel> listRiwayatAlatKerja = [];

  @override
  void initState() {
    super.initState();
    getAlatKerjaperKategori();
  }

  getAlatKerjaperKategori() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    var urlGetAlatKerjaPerKategori =
        "$baseUrl/api/peralatankerja/riwayatStockPeralatanKerja/${widget.detailAlatKerja.kdPeralatanKerja}";
    try {
      response = await Dio().get(urlGetAlatKerjaPerKategori,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listRiwayatAlatKerja.clear();
      List listRiwayatAlatKerjaAPI = response.data['data'];
      setState(() {
        for (var e in listRiwayatAlatKerjaAPI) {
          listRiwayatAlatKerja.add(RiwayatAlatKerjaModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: ListView.builder(
            itemCount: listRiwayatAlatKerja.length,
            itemBuilder: (context, index) {
              DateTime? tanggalRiwayat;
              tanggalRiwayat = DateTime.parse(
                  listRiwayatAlatKerja[index].tglCreated.toString());
              return Card(
                child: ListTile(
                  leading: IncDecIcon(
                      value: int.parse(listRiwayatAlatKerja[index]
                          .jmlPeralatanKerjaMskKeluar
                          .toString())),
                  title:
                      Text(listRiwayatAlatKerja[index].userCreated.toString()),
                  subtitle: Text(listRiwayatAlatKerja[index]
                      .ketPeralatanKerjaMskKeluar
                      .toString()),
                  trailing: Text(tanggalRiwayat.getTanggal()),
                  onTap: () {},
                ),
              );
            },
          ),
        ),
      );
}

class IncDecIcon extends StatelessWidget {
  const IncDecIcon({Key? key, required this.value}) : super(key: key);
  final int value;

  Text getTextvalue() {
    if (value >= 0) {
      return Text(
        "+$value",
        style: const TextStyle(color: Colors.green, fontSize: 12),
      );
    }
    return Text(
      value.toString(),
      style: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }

  Icon getIcon() {
    if (value >= 0) {
      return const Icon(
        Icons.arrow_circle_up_outlined,
        color: Colors.green,
      );
    }
    return const Icon(
      Icons.arrow_circle_down_outlined,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[getIcon(), getTextvalue()],
    );
  }
}
