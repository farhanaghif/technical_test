import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/model/stock_model/stock_model.dart';
import 'package:risa_reborn/screen/stock/stock_detail.dart';
import 'package:risa_reborn/screen/stock/stock_form_keluar.dart';
import 'package:risa_reborn/screen/stock/stock_form_masuk.dart';
import 'package:risa_reborn/screen/stock/stock_pemakaian.dart';

class DetailStock extends StatelessWidget {
  final StockModel detailStock;
  const DetailStock(this.detailStock, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Informasi Stock'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Detail",
                ),
                Tab(
                  text: "Pemakaian",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [StockDetail(detailStock), PemakaianStock(detailStock)],
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: const Color.fromARGB(255, 53, 133, 224),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            activeIcon: (Icons.close),
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: const CircleBorder(),
            children: [
              SpeedDialChild(
                  child: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 149, 219, 161),
                  label: 'Tambahkan Stok',
                  onTap: () => Get.off(FormStockMasuk(detailStock))),
              SpeedDialChild(
                  child: const Icon(
                    Icons.remove_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: const Color.fromARGB(255, 231, 166, 217),
                  label: 'Kurangi Stok',
                  onTap: () => Get.off(FormStockKeluar(detailStock))),
            ],
          ),
        ),
      ),
    );
  }
}
