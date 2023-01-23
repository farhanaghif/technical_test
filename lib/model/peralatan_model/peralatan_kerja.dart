class PeralatankerjaModel {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  int? kdPeralatanKerja;
  String? nmPeralatanKerja;
  int? kdFasilitasPelabuhan;
  String? nmFasilitasPelabuhan;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  int? kdKondisiPerangkat;
  String? nmKondisiPerangkat;
  String? tglPembelian;
  String? isCheck;
  String? ketPeralatanKerja;
  int? stockPeralatanKerja;
  String? tglUpdated;
  String? userUpdated;

  PeralatankerjaModel(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdPeralatanKerja,
      this.nmPeralatanKerja,
      this.kdFasilitasPelabuhan,
      this.nmFasilitasPelabuhan,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.kdKondisiPerangkat,
      this.nmKondisiPerangkat,
      this.tglPembelian,
      this.isCheck,
      this.ketPeralatanKerja,
      this.stockPeralatanKerja,
      this.tglUpdated,
      this.userUpdated});

  PeralatankerjaModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdPeralatanKerja = json['kd_peralatan_kerja'];
    nmPeralatanKerja = json['nm_peralatan_kerja'];
    kdFasilitasPelabuhan = json['kd_fasilitas_pelabuhan'];
    nmFasilitasPelabuhan = json['nm_fasilitas_pelabuhan'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    kdKondisiPerangkat = json['kd_kondisi_perangkat'];
    nmKondisiPerangkat = json['nm_kondisi_perangkat'];
    tglPembelian = json['tgl_pembelian'];
    isCheck = json['is_check'];
    ketPeralatanKerja = json['ket_peralatan_kerja'];
    stockPeralatanKerja = json['stock_peralatan_kerja'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
  }
}
