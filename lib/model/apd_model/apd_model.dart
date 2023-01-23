class APDModel {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  int? kdApd;
  String? nmApd;
  int? kdFasilitasPelabuhan;
  String? nmFasilitasPelabuhan;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  int? kdKondisiPerangkat;
  String? nmKondisiPerangkat;
  String? tglPembelian;
  String? tglAkhirMasaberlaku;
  String? isCheck;
  String? ketApd;
  int? stockApd;
  String? tglUpdated;
  String? userUpdated;

  APDModel(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdApd,
      this.nmApd,
      this.kdFasilitasPelabuhan,
      this.nmFasilitasPelabuhan,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.kdKondisiPerangkat,
      this.nmKondisiPerangkat,
      this.tglPembelian,
      this.tglAkhirMasaberlaku,
      this.isCheck,
      this.ketApd,
      this.stockApd,
      this.tglUpdated,
      this.userUpdated});

  APDModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdApd = json['kd_apd'];
    nmApd = json['nm_apd'];
    kdFasilitasPelabuhan = json['kd_fasilitas_pelabuhan'];
    nmFasilitasPelabuhan = json['nm_fasilitas_pelabuhan'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    kdKondisiPerangkat = json['kd_kondisi_perangkat'];
    nmKondisiPerangkat = json['nm_kondisi_perangkat'];
    tglPembelian = json['tgl_pembelian'];
    tglAkhirMasaberlaku = json['tgl_akhir_masaberlaku'];
    isCheck = json['is_check'];
    ketApd = json['ket_apd'];
    stockApd = json['stock_apd'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
  }
}
