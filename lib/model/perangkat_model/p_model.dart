class PerangkatModel {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  String? kdDivisi;
  String? nmDivisi;
  int? kdPerangkat;
  String? nmPerangkat;
  String? noInvPerangkat;
  int? kdJnsPerangkat;
  String? nmJnsPerangkat;
  int? kdMerkPerangkat;
  String? nmMerkPerangkat;
  int? kdStsPerangkat;
  String? nmStsPerangkat;
  int? kdKondisiPerangkat;
  String? nmKondisiPerangkat;
  int? kdLokasi;
  String? nmLokasi;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  String? isCheck;
  String? isKerjasama;
  String? isRekanan;
  String? kdPerusahaan;
  String? nmPerusahaan;
  int? kdKerjasama;
  String? nmKerjasama;
  String? tglPerangkat;
  String? tglUpdated;
  String? userUpdated;
  String? ketPerangkat;

  PerangkatModel(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdDivisi,
      this.nmDivisi,
      this.kdPerangkat,
      this.nmPerangkat,
      this.noInvPerangkat,
      this.kdJnsPerangkat,
      this.nmJnsPerangkat,
      this.kdMerkPerangkat,
      this.nmMerkPerangkat,
      this.kdStsPerangkat,
      this.nmStsPerangkat,
      this.kdKondisiPerangkat,
      this.nmKondisiPerangkat,
      this.kdLokasi,
      this.nmLokasi,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.isCheck,
      this.isKerjasama,
      this.isRekanan,
      this.kdPerusahaan,
      this.nmPerusahaan,
      this.kdKerjasama,
      this.nmKerjasama,
      this.tglPerangkat,
      this.tglUpdated,
      this.userUpdated,
      this.ketPerangkat});

  PerangkatModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdDivisi = json['kd_divisi'];
    nmDivisi = json['nm_divisi'];
    kdPerangkat = json['kd_perangkat'];
    nmPerangkat = json['nm_perangkat'];
    noInvPerangkat = json['no_inv_perangkat'];
    kdJnsPerangkat = json['kd_jns_perangkat'];
    nmJnsPerangkat = json['nm_jns_perangkat'];
    kdMerkPerangkat = json['kd_merk_perangkat'];
    nmMerkPerangkat = json['nm_merk_perangkat'];
    kdStsPerangkat = json['kd_sts_perangkat'];
    nmStsPerangkat = json['nm_sts_perangkat'];
    kdKondisiPerangkat = json['kd_kondisi_perangkat'];
    nmKondisiPerangkat = json['nm_kondisi_perangkat'];
    kdLokasi = json['kd_lokasi'];
    nmLokasi = json['nm_lokasi'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    isCheck = json['is_check'];
    isKerjasama = json['is_kerjasama'];
    isRekanan = json['is_rekanan'];
    kdPerusahaan = json['kd_perusahaan'];
    nmPerusahaan = json['nm_perusahaan'];
    kdKerjasama = json['kd_kerjasama'];
    nmKerjasama = json['nm_kerjasama'];
    tglPerangkat = json['tgl_perangkat'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
    ketPerangkat = json['ket_perangkat'];
  }
}
