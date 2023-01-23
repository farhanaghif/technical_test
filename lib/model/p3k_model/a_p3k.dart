class DetailModelP3K {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  int? kdP3k;
  String? nmP3k;
  int? kdFasilitasPelabuhan;
  String? nmFasilitasPelabuhan;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  int? kdTypeP3k;
  String? nmTypeP3k;
  String? isCheck;
  String? ketP3k;
  String? stockP3k;
  String? tglUpdated;
  String? userUpdated;

  DetailModelP3K(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdP3k,
      this.nmP3k,
      this.kdFasilitasPelabuhan,
      this.nmFasilitasPelabuhan,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.kdTypeP3k,
      this.nmTypeP3k,
      this.isCheck,
      this.ketP3k,
      this.stockP3k,
      this.tglUpdated,
      this.userUpdated});

  DetailModelP3K.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdP3k = json['kd_p3k'];
    nmP3k = json['nm_p3k'];
    kdFasilitasPelabuhan = json['kd_fasilitas_pelabuhan'];
    nmFasilitasPelabuhan = json['nm_fasilitas_pelabuhan'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    kdTypeP3k = json['kd_type_p3k'];
    nmTypeP3k = json['nm_type_p3k'];
    isCheck = json['is_check'];
    ketP3k = json['ket_p3k'];
    stockP3k = json['stock_p3k'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
  }
}
