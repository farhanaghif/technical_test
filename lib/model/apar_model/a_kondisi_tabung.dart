class KondisiTabungModel {
  int? kdKondisiTabung;
  String? nmKondisiTabung;

  KondisiTabungModel({this.kdKondisiTabung, this.nmKondisiTabung});

  KondisiTabungModel.fromJson(Map<String, dynamic> json) {
    kdKondisiTabung = json['kd_kondisi_tabung'];
    nmKondisiTabung = json['nm_kondisi_tabung'];
  }
}
