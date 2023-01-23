import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/apd_model/apd_model.dart';
import 'package:risa_reborn/model/apd_model/apd_riwayat.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("d MMM HH:mm").format(toLocal());
  }
}

class RiwayatBarangAPD extends StatefulWidget {
  final APDModel detailAPD;
  const RiwayatBarangAPD(this.detailAPD, {Key? key}) : super(key: key);

  @override
  State<RiwayatBarangAPD> createState() => _RiwayatBarangAPDState();
}

class _RiwayatBarangAPDState extends State<RiwayatBarangAPD> {
  List<RiwayatBarangAPDModel> listRiwayatBarangAPD = [];

  @override
  void initState() {
    super.initState();
    getBarangAPDperKategori();
  }

  getBarangAPDperKategori() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    var urlgetBarangAPDperKategori =
        "$baseUrl/api/apd/riwayatStockAPD/${widget.detailAPD.kdApd}";
    try {
      response = await Dio().get(urlgetBarangAPDperKategori,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listRiwayatBarangAPD.clear();
      List listRiwayatBarangAPDAPI = response.data['data'];
      setState(() {
        for (var e in listRiwayatBarangAPDAPI) {
          listRiwayatBarangAPD.add(RiwayatBarangAPDModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          // print('back button preses!');
          return false;
        },
        child: Scaffold(
          body: ListView.builder(
            itemCount: listRiwayatBarangAPD.length,
            itemBuilder: (context, index) {
              DateTime? tanggalRiwayat;
              tanggalRiwayat = DateTime.parse(
                  listRiwayatBarangAPD[index].tglCreated.toString());
              return Card(
                child: ListTile(
                  leading: IncDecIcon(
                      value: int.parse(listRiwayatBarangAPD[index]
                          .jmlApdMskKeluar
                          .toString())),
                  title:
                      Text(listRiwayatBarangAPD[index].userCreated.toString()),
                  subtitle: Text(
                      listRiwayatBarangAPD[index].ketApdMskKeluar.toString()),
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
