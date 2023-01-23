import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/p3k_model/p3k.dart';
import 'package:risa_reborn/model/p3k_model/riwayat_p3k_model.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("d MMM HH:mm").format(toLocal());
  }
}

class PemakaianP3K extends StatefulWidget {
  final P3KModel detailP3K;
  const PemakaianP3K(this.detailP3K, {Key? key}) : super(key: key);

  @override
  State<PemakaianP3K> createState() => _PemakaianP3KState();
}

class _PemakaianP3KState extends State<PemakaianP3K> {
  List<RiwayatP3KModel> listRiwayatP3K = [];

  @override
  void initState() {
    super.initState();
    getRiwayatP3K();
  }

  getRiwayatP3K() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    var urlGetRiwayatP3K =
        "$baseUrl/api/p3k/riwayatStockP3K/${widget.detailP3K.kdP3k}";
    try {
      response = await Dio().get(urlGetRiwayatP3K,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listRiwayatP3K.clear();
      List listRiwayatP3KAPI = response.data['data'];
      setState(() {
        for (var e in listRiwayatP3KAPI) {
          listRiwayatP3K.add(RiwayatP3KModel.fromJson(e));
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
            itemCount: listRiwayatP3K.length,
            itemBuilder: (context, index) {
              DateTime? tanggalRiwayat;
              tanggalRiwayat =
                  DateTime.parse(listRiwayatP3K[index].tglCreated.toString());
              return Card(
                child: ListTile(
                  leading: IncDecIcon(
                      value: int.parse(
                          listRiwayatP3K[index].jmlP3kMskKeluar.toString())),
                  title: Text(listRiwayatP3K[index].userCreated.toString()),
                  subtitle:
                      Text(listRiwayatP3K[index].ketP3kMskKeluar.toString()),
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
