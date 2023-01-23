class RiwayatP3KModel {
  String? kdCabang;
  String? kdTerminal;
  int? kdP3k;
  String? nmP3k;
  String? jmlP3kMskKeluar;
  String? ketP3kMskKeluar;
  String? tglCreated;
  String? userCreated;

  RiwayatP3KModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdP3k,
      this.nmP3k,
      this.jmlP3kMskKeluar,
      this.ketP3kMskKeluar,
      this.tglCreated,
      this.userCreated});

  RiwayatP3KModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdP3k = json['kd_p3k'];
    nmP3k = json['nm_p3k'];
    jmlP3kMskKeluar = json['jml_p3k_msk_keluar'];
    ketP3kMskKeluar = json['ket_p3k_msk_keluar'];
    tglCreated = json['tgl_created'];
    userCreated = json['user_created'];
  }
}
