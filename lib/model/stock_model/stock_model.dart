class StockModel {
  String? kdCabang;
  String? kdTerminal;
  String? nmTerminal;
  String? kdDivisi;
  String? nmDivisi;
  int? kdStock;
  String? nmStock;
  String? fotoStock;
  int? jumlah;
  String? satuan;
  int? kdLokasi;
  String? nmLokasi;
  double? latitude;
  double? longitude;
  String? detailLokasi;
  int? kdKategoriStock;
  String? nmKategoriStock;
  String? tglUpdated;
  String? userUpdated;

  StockModel(
      {this.kdCabang,
      this.kdTerminal,
      this.nmTerminal,
      this.kdDivisi,
      this.nmDivisi,
      this.kdStock,
      this.nmStock,
      this.fotoStock,
      this.jumlah,
      this.satuan,
      this.kdLokasi,
      this.nmLokasi,
      this.latitude,
      this.longitude,
      this.detailLokasi,
      this.kdKategoriStock,
      this.nmKategoriStock,
      this.tglUpdated,
      this.userUpdated});

  StockModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmTerminal = json['nm_terminal'];
    kdDivisi = json['kd_divisi'];
    nmDivisi = json['nm_divisi'];
    kdStock = json['kd_stock'];
    nmStock = json['nm_stock'];
    fotoStock = json['foto_stock'];
    jumlah = json['jumlah'];
    satuan = json['satuan'];
    kdLokasi = json['kd_lokasi'];
    nmLokasi = json['nm_lokasi'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailLokasi = json['detail_lokasi'];
    kdKategoriStock = json['kd_kategori_stock'];
    nmKategoriStock = json['nm_kategori_stock'];
    tglUpdated = json['tgl_updated'];
    userUpdated = json['user_updated'];
  }
}
