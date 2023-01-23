class KlasifikasiKebakaranModel {
  int? kdKlasifikasiKebakaran;
  String? nmKlasifikasiKebakaran;
  String? ketKlasifikasiKebakaran;

  KlasifikasiKebakaranModel(
      {this.kdKlasifikasiKebakaran,
      this.nmKlasifikasiKebakaran,
      this.ketKlasifikasiKebakaran});

  KlasifikasiKebakaranModel.fromJson(Map<String, dynamic> json) {
    kdKlasifikasiKebakaran = json['kd_klasifikasi_kebakaran'];
    nmKlasifikasiKebakaran = json['nm_klasifikasi_kebakaran'];
    ketKlasifikasiKebakaran = json['ket_klasifikasi_kebakaran'];
  }
}
