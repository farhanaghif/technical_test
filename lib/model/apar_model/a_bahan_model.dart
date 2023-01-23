class BahanAparModel {
  int? kdBhnApar;
  String? nmBhnApar;
  int? kdJnsApar;
  String? nmJnsApar;

  BahanAparModel(
      {this.kdBhnApar, this.nmBhnApar, this.kdJnsApar, this.nmJnsApar});

  BahanAparModel.fromJson(Map<String, dynamic> json) {
    kdBhnApar = json['kd_bhn_apar'];
    nmBhnApar = json['nm_bhn_apar'];
    kdJnsApar = json['kd_jns_apar'];
    nmJnsApar = json['nm_jns_apar'];
  }
}
