class P3KTipeModel {
  int? kdTypeP3k;
  String? nmTypeP3k;
  String? recStat;

  P3KTipeModel({this.kdTypeP3k, this.nmTypeP3k, this.recStat});

  P3KTipeModel.fromJson(Map<String, dynamic> json) {
    kdTypeP3k = json['kd_type_p3k'];
    nmTypeP3k = json['nm_type_p3k'];
    recStat = json['rec_stat'];
  }
}
