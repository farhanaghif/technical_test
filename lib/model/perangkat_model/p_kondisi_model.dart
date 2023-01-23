class KondisiPerangkatModel {
  int? kdKondisiPerangkat;
  String? nmKondisiPerangkat;
  String? recStat;

  KondisiPerangkatModel(
      {this.kdKondisiPerangkat, this.nmKondisiPerangkat, this.recStat});

  KondisiPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdKondisiPerangkat = json['kd_kondisi_perangkat'];
    nmKondisiPerangkat = json['nm_kondisi_perangkat'];
    recStat = json['rec_stat'];
  }
}
