class LokasiPerangkatModel {
  int? kdLokasi;
  String? kdCabang;
  String? kdTerminal;
  String? kdDivisi;
  String? nmLokasi;
  String? nmTerminal;
  String? nmDivisi;
  double? latitude;
  double? longitude;
  String? recStat;

  LokasiPerangkatModel(
      {this.kdLokasi,
      this.kdCabang,
      this.kdTerminal,
      this.kdDivisi,
      this.nmLokasi,
      this.nmTerminal,
      this.nmDivisi,
      this.latitude,
      this.longitude,
      this.recStat});

  LokasiPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdLokasi = json['kd_lokasi'];
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdDivisi = json['kd_divisi'];
    nmLokasi = json['nm_lokasi'];
    nmTerminal = json['nm_terminal'];
    nmDivisi = json['nm_divisi'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    recStat = json['rec_stat'];
  }
}
