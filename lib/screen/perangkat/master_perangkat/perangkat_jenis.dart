// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:risa_reborn/const.dart';
import 'package:risa_reborn/model/perangkat_model/p_jenis_model.dart';
import 'package:risa_reborn/model/perangkat_model/p_model.dart';
import 'package:risa_reborn/screen/perangkat/master_perangkat/perangkat_list.dart';

class JenisPerangkat extends StatefulWidget {
  const JenisPerangkat({Key? key}) : super(key: key);

  @override
  State<JenisPerangkat> createState() => _JenisPerangkatState();
}

class _JenisPerangkatState extends State<JenisPerangkat> {
  List<PerangkatModel> listPerangkat = [];

  gridView(AsyncSnapshot<List<JenisPerangkatModel>> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: snapshot.data!.map((jenisPerangkat) {
          return GestureDetector(
            child: GridTile(
              child: PhotoCell(jenisPerangkat),
            ),
            onTap: () {
              Get.to(ListPerangkat(jenisPerangkat));
            },
          );
        }).toList(),
      ),
    );
  }

  circularProgress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
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
          title: const Text('Master Perangkat'),
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
                'Pilih Jenis Perangkat',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Flexible(
              child: FutureBuilder<List<JenisPerangkatModel>>(
                future: JenisPerangkatModel.fetchJenisPerangkat(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return gridView(snapshot);
                  }
                  return circularProgress();
                },
              ),
            ),
          ],
        ),
      ));
}

class PhotoCell extends StatelessWidget {
  @required
  final JenisPerangkatModel photo;
  const PhotoCell(this.photo);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: "image${photo.kdJenisPerangkat}",
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/no_image.png",
                    image:
                        '$baseUrl/assets/jenis_perangkat/icon_${photo.iconMobile.toString()}.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  photo.nmJenisPerangkat.toString(),
                  maxLines: 1,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
