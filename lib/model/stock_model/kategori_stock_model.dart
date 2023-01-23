import 'package:dio/dio.dart';
import 'package:risa_reborn/const.dart';

class KategoriStockModel {
  int? kdKategoriStock;
  String? nmKategoriStock;
  String? kdDivisi;
  String? nmDivisi;

  KategoriStockModel(
      {this.kdKategoriStock,
      this.nmKategoriStock,
      this.kdDivisi,
      this.nmDivisi});

  KategoriStockModel.fromJson(Map<String, dynamic> json) {
    kdKategoriStock = json['kd_kategori_stock'];
    nmKategoriStock = json['nm_kategori_stock'];
    kdDivisi = json['kd_divisi'];
    nmDivisi = json['nm_divisi'];
  }

  static String urlGetKategoriStock =
      '$baseUrl/api/kategoristock/getKategoriStockAktif';

  static Future<List<KategoriStockModel>> getKategoriStock() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    response = await Dio().get(urlGetKategoriStock,
        options: Options(headers: {
          "Authorization": "Bearer $tokenBaru",
        }));
    var jsonObjectAwal = response.data;
    var jsonObject = jsonObjectAwal['data'];
    List<dynamic> jsonKategoriStock = jsonObject;
    List<KategoriStockModel> listKategoriStock = [];
    for (var e in jsonKategoriStock) {
      listKategoriStock.add(KategoriStockModel.fromJson(e));
    }
    if (response.statusCode == 200) {
      return listKategoriStock;
    } else {
      throw Exception('can\'t get Jenis Perangkat');
    }
  }
}
