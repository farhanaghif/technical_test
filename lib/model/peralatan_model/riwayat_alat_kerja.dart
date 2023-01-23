class RiwayatAlatKerjaModel {
  String? kdCabang;
  String? kdTerminal;
  int? kdPeralatanKerja;
  String? nmPeralatanKerja;
  String? jmlPeralatanKerjaMskKeluar;
  String? ketPeralatanKerjaMskKeluar;
  String? tglCreated;
  String? userCreated;

  RiwayatAlatKerjaModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdPeralatanKerja,
      this.nmPeralatanKerja,
      this.jmlPeralatanKerjaMskKeluar,
      this.ketPeralatanKerjaMskKeluar,
      this.tglCreated,
      this.userCreated});

  RiwayatAlatKerjaModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdPeralatanKerja = json['kd_peralatan_kerja'];
    nmPeralatanKerja = json['nm_peralatan_kerja'];
    jmlPeralatanKerjaMskKeluar = json['jml_peralatan_kerja_msk_keluar'];
    ketPeralatanKerjaMskKeluar = json['ket_peralatan_kerja_msk_keluar'];
    tglCreated = json['tgl_created'];
    userCreated = json['user_created'];
  }
}
