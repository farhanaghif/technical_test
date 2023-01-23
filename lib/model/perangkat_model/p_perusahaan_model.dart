class PerusahaanModel {
  String? kdPerusahaan;
  String? nmPerusahaan;
  String? npwpPerusahaan;
  String? alamatPerusahaan;
  String? noHp;
  String? email;
  String? isRekanan;
  String? recStat;

  PerusahaanModel(
      {this.kdPerusahaan,
      this.nmPerusahaan,
      this.npwpPerusahaan,
      this.alamatPerusahaan,
      this.noHp,
      this.email,
      this.isRekanan,
      this.recStat});

  PerusahaanModel.fromJson(Map<String, dynamic> json) {
    kdPerusahaan = json['kd_perusahaan'];
    nmPerusahaan = json['nm_perusahaan'];
    npwpPerusahaan = json['npwp_perusahaan'];
    alamatPerusahaan = json['alamat_perusahaan'];
    noHp = json['no_hp'];
    email = json['email'];
    isRekanan = json['is_rekanan'];
    recStat = json['rec_stat'];
  }
}
