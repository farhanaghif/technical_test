import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:risa_reborn/model/stock_model/kategori_stock_model.dart';
import 'package:risa_reborn/screen/stock/stock_list.dart';

class KategoriStock extends StatefulWidget {
  const KategoriStock({Key? key}) : super(key: key);

  @override
  State<KategoriStock> createState() => _KategoriStockState();
}

class _KategoriStockState extends State<KategoriStock> {
  @override
  void initState() {
    super.initState();
  }

  circularProgress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  gridViewKategoriStock(AsyncSnapshot<List<KategoriStockModel>> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: snapshot.data!.map((kategoriStock) {
          return GestureDetector(
            child: GridTile(
              child: GridKategoriStock(kategoriStock),
            ),
            onTap: () {
              Get.to(ListStock(kategoriStock));
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Stock'),
            centerTitle: false,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Pilih Kategori Stock',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                child: FutureBuilder<List<KategoriStockModel>>(
                    future: KategoriStockModel.getKategoriStock(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        // return circularProgress();
                        return Text('Error ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return gridViewKategoriStock(snapshot);
                      }
                      return circularProgress();
                    }),
              ),
            ],
          ),
        ));
  }
}

class GridKategoriStock extends StatelessWidget {
  final KategoriStockModel kategori;
  const GridKategoriStock(this.kategori, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blue,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              kategori.nmKategoriStock.toString(),
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.bottomRight,
            child: Text(
              kategori.kdDivisi.toString(),
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
      ]),
    );
  }
}
