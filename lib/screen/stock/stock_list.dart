import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/stock_model/kategori_stock_model.dart';
import 'package:risa_reborn/model/stock_model/stock_model.dart';
import 'package:risa_reborn/screen/stock/stock_form_tambah.dart';
import 'package:risa_reborn/screen/stock/stock_informasi.dart';

class ListStock extends StatefulWidget {
  final KategoriStockModel kategoriStock;
  const ListStock(this.kategoriStock, {Key? key}) : super(key: key);

  @override
  State<ListStock> createState() => _ListStockState();
}

class _ListStockState extends State<ListStock> {
  List<StockModel> listStockperKategori = [];
  int? selected = 0;

  @override
  void initState() {
    setState(() {});
    super.initState();
    getStockperKategori();
  }

  getStockperKategori() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    var urlGetStockPerKategori =
        "$baseUrl/api/stock/getStockperKategori/${widget.kategoriStock.kdKategoriStock}";
    try {
      response = await Dio().get(urlGetStockPerKategori,
          options: Options(headers: {
            "Accept": "*/*",
            "Authorization": "Bearer $tokenBaru",
          }));
      listStockperKategori.clear();
      List listStockperKategoriAPI = response.data['data'];
      setState(() {
        for (var e in listStockperKategoriAPI) {
          listStockperKategori.add(StockModel.fromJson(e));
        }
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 30),
        child: GestureDetector(
          onLongPress: () {},
          onTap: () {
            Get.off(const FormTambahStock());
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(24)),
            child: const Text.rich(TextSpan(children: <InlineSpan>[
              WidgetSpan(
                  child: Icon(
                Icons.add,
                size: 21,
                color: Colors.white,
              )),
              TextSpan(
                  text: "Tambah Stock",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ])),
          ),
        ),
      ),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
        title: Text(
            'Stok kategori ${widget.kategoriStock.nmKategoriStock.toString()}'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: listStockperKategori.length,
                itemBuilder: (contex, parameter) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.off(DetailStock(listStockperKategori[parameter]));
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              listStockperKategori[parameter]
                                  .nmStock
                                  .toString(),
                              style: const TextStyle(fontSize: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  listStockperKategori[parameter]
                                      .nmKategoriStock
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                              Text(
                                  listStockperKategori[parameter]
                                      .nmLokasi
                                      .toString(),
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
