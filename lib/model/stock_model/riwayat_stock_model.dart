class RiwayatStockModel {
  String? kdCabang;
  String? kdTerminal;
  String? kdDivisi;
  int? kdStock;
  String? nmStock;
  String? jmlStockMskKeluar;
  String? ketStockMskKeluar;
  String? tglCreated;
  String? userCreated;

  RiwayatStockModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdDivisi,
      this.kdStock,
      this.nmStock,
      this.jmlStockMskKeluar,
      this.ketStockMskKeluar,
      this.tglCreated,
      this.userCreated});

  RiwayatStockModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdDivisi = json['kd_divisi'];
    kdStock = json['kd_stock'];
    nmStock = json['nm_stock'];
    jmlStockMskKeluar = json['jml_stock_msk_keluar'];
    ketStockMskKeluar = json['ket_stock_msk_keluar'];
    tglCreated = json['tgl_created'];
    userCreated = json['user_created'];
  }
}
