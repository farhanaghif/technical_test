class StatusPerangkatModel {
  int? kdStsPerangkat;
  String? nmStsPerangkat;
  String? recStat;

  StatusPerangkatModel(
      {this.kdStsPerangkat, this.nmStsPerangkat, this.recStat});

  StatusPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdStsPerangkat = json['kd_sts_perangkat'];
    nmStsPerangkat = json['nm_sts_perangkat'];
    recStat = json['rec_stat'];
  }
}
