class KerjasamaModel {
  int? kdKerjasama;
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  String? kdDivisi;
  String? nmDivisi;
  String? kdPerusahaan;
  String? nmPerusahaan;
  String? noKerjasama;
  String? nmKerjasama;
  String? tglAwalKerjasama;
  String? tglAkhirKerjasama;
  String? recStat;

  KerjasamaModel(
      {this.kdKerjasama,
      this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdDivisi,
      this.nmDivisi,
      this.kdPerusahaan,
      this.nmPerusahaan,
      this.noKerjasama,
      this.nmKerjasama,
      this.tglAwalKerjasama,
      this.tglAkhirKerjasama,
      this.recStat});

  KerjasamaModel.fromJson(Map<String, dynamic> json) {
    kdKerjasama = json['kd_kerjasama'];
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdDivisi = json['kd_divisi'];
    nmDivisi = json['nm_divisi'];
    kdPerusahaan = json['kd_perusahaan'];
    nmPerusahaan = json['nm_perusahaan'];
    noKerjasama = json['no_kerjasama'];
    nmKerjasama = json['nm_kerjasama'];
    tglAwalKerjasama = json['tgl_awal_kerjasama'];
    tglAkhirKerjasama = json['tgl_akhir_kerjasama'];
    recStat = json['rec_stat'];
  }
}
