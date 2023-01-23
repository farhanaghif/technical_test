import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/stock_model/riwayat_stock_model.dart';
import 'package:risa_reborn/model/stock_model/stock_model.dart';

extension DateMYString on DateTime {
  String getTanggal() {
    return DateFormat("d MMM HH:mm").format(toLocal());
  }
}

class PemakaianStock extends StatefulWidget {
  final StockModel detailStock;
  const PemakaianStock(this.detailStock, {Key? key}) : super(key: key);

  @override
  State<PemakaianStock> createState() => _PemakaianStockState();
}

class _PemakaianStockState extends State<PemakaianStock> {
  List<RiwayatStockModel> listRiwayatStock = [];

  @override
  void initState() {
    super.initState();
    getStockperKategori();
  }

  getStockperKategori() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    var urlGetStockPerKategori =
        "$baseUrl/api/stock/riwayatStock/${widget.detailStock.kdStock}";
    try {
      response = await Dio().get(urlGetStockPerKategori,
          options: Options(headers: {
            "Authorization": "Bearer $tokenBaru",
          }));
      listRiwayatStock.clear();
      List listRiwayatStockAPI = response.data['data'];
      setState(() {
        for (var e in listRiwayatStockAPI) {
          listRiwayatStock.add(RiwayatStockModel.fromJson(e));
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
            itemCount: listRiwayatStock.length,
            itemBuilder: (context, index) {
              DateTime? tanggalRiwayat;
              tanggalRiwayat =
                  DateTime.parse(listRiwayatStock[index].tglCreated.toString());
              return Card(
                child: ListTile(
                  leading: IncDecIcon(
                      value: int.parse(listRiwayatStock[index]
                          .jmlStockMskKeluar
                          .toString())),
                  title: Text(listRiwayatStock[index].userCreated.toString()),
                  subtitle: Text(
                      listRiwayatStock[index].ketStockMskKeluar.toString()),
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
