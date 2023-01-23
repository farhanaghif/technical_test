import 'package:dio/dio.dart';
import 'package:risa_reborn/const.dart';

class JenisPerangkatModel {
  int? kdJenisPerangkat;
  String? nmJenisPerangkat;
  String? urlJenisPerangkat;
  String? iconWeb;
  String? iconMobile;
  String? recStat;

  JenisPerangkatModel(
      {this.kdJenisPerangkat,
      this.nmJenisPerangkat,
      this.urlJenisPerangkat,
      this.iconWeb,
      this.iconMobile,
      this.recStat});

  JenisPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdJenisPerangkat = json['kd_jns_perangkat'];
    nmJenisPerangkat = json['nm_jns_perangkat'];
    urlJenisPerangkat = json['url_jns_perangkat'];
    iconWeb = json['icon_web'];
    iconMobile = json['icon_mobile'];
    recStat = json['rec_stat'];
  }

  static String url = '$baseUrl/api/jenisperangkat/getJenisPerangkat';

  static Future<List<JenisPerangkatModel>> fetchJenisPerangkat() async {
    var tokenBaru = await dataStorage.read(key: 'token_baru');
    Response response;
    response = await Dio().get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $tokenBaru",
        }));
    var jsonObjectAwal = response.data;
    var jsonObject = jsonObjectAwal['data'];
    List<dynamic> jsonJenisPerangkat = jsonObject;

    List<JenisPerangkatModel> listJenisPerangkat = [];
    for (var e in jsonJenisPerangkat) {
      listJenisPerangkat.add(JenisPerangkatModel.fromJson(e));
    }
    if (response.statusCode == 200) {
      return listJenisPerangkat;
    } else {
      throw Exception('can\'t get Jenis Perangkat');
    }
  }
}
