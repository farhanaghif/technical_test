class RiwayatBarangAPDModel {
  String? kdCabang;
  String? kdTerminal;
  int? kdApd;
  String? nmApd;
  String? jmlApdMskKeluar;
  String? ketApdMskKeluar;
  String? tglCreated;
  String? userCreated;

  RiwayatBarangAPDModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdApd,
      this.nmApd,
      this.jmlApdMskKeluar,
      this.ketApdMskKeluar,
      this.tglCreated,
      this.userCreated});

  RiwayatBarangAPDModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdApd = json['kd_apd'];
    nmApd = json['nm_apd'];
    jmlApdMskKeluar = json['jml_apd_msk_keluar'];
    ketApdMskKeluar = json['ket_apd_msk_keluar'];
    tglCreated = json['tgl_created'];
    userCreated = json['user_created'];
  }
}
