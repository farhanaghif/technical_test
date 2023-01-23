class AparModel {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  int? kdApar;
  String? nmApar;
  int? kdFasilitasPelabuhan;
  String? nmFasilitasPelabuhan;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  int? kdJnsApar;
  String? nmJnsApar;
  int? kdBhnApar;
  String? nmBhnApar;
  int? kdKlasifikasiKebakaran;
  String? nmKlasifikasiKebakaran;
  String? ketKlasifikasiKebakaran;
  String? tglAwalMasaberlaku;
  String? tglAkhirMasaberlaku;
  String? tekananTabung;
  int? kdKondisiTabung;
  String? nmKondisiTabung;
  String? alasanGanti;
  String? isCheck;
  String? ketApar;
  String? tglUpdated;
  String? userUpdated;

  AparModel(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdApar,
      this.nmApar,
      this.kdFasilitasPelabuhan,
      this.nmFasilitasPelabuhan,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.kdJnsApar,
      this.nmJnsApar,
      this.kdBhnApar,
      this.nmBhnApar,
      this.kdKlasifikasiKebakaran,
      this.nmKlasifikasiKebakaran,
      this.ketKlasifikasiKebakaran,
      this.tglAwalMasaberlaku,
      this.tglAkhirMasaberlaku,
      this.tekananTabung,
      this.kdKondisiTabung,
      this.nmKondisiTabung,
      this.alasanGanti,
      this.isCheck,
      this.ketApar,
      this.tglUpdated,
      this.userUpdated});

  AparModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdApar = json['kd_apar'];
    nmApar = json['nm_apar'];
    kdFasilitasPelabuhan = json['kd_fasilitas_pelabuhan'];
    nmFasilitasPelabuhan = json['nm_fasilitas_pelabuhan'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    kdJnsApar = json['kd_jns_apar'];
    nmJnsApar = json['nm_jns_apar'];
    kdBhnApar = json['kd_bhn_apar'];
    nmBhnApar = json['nm_bhn_apar'];
    kdKlasifikasiKebakaran = json['kd_klasifikasi_kebakaran'];
    nmKlasifikasiKebakaran = json['nm_klasifikasi_kebakaran'];
    ketKlasifikasiKebakaran = json['ket_klasifikasi_kebakaran'];
    tglAwalMasaberlaku = json['tgl_awal_masaberlaku'];
    tglAkhirMasaberlaku = json['tgl_akhir_masaberlaku'];
    tekananTabung = json['tekanan_tabung'];
    kdKondisiTabung = json['kd_kondisi_tabung'];
    nmKondisiTabung = json['nm_kondisi_tabung'];
    alasanGanti = json['alasan_ganti'];
    isCheck = json['is_check'];
    ketApar = json['ket_apar'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
  }
}
