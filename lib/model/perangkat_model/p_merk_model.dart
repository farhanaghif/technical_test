class MerkPerangkatModel {
  int? kdMerkPerangkat;
  String? nmMerkPerangkat;
  int? kdJnsPerangkat;
  String? nmJnsPerangkat;
  String? recStat;

  MerkPerangkatModel(
      {this.kdMerkPerangkat,
      this.nmMerkPerangkat,
      this.kdJnsPerangkat,
      this.nmJnsPerangkat,
      this.recStat});

  MerkPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdMerkPerangkat = json['kd_merk_perangkat'] ?? 'Null';
    nmMerkPerangkat = json['nm_merk_perangkat'] ?? 'Null';
    kdJnsPerangkat = json['kd_jns_perangkat'];
    nmJnsPerangkat = json['nm_jns_perangkat'];
    recStat = json['rec_stat'];
  }
}
