class FasilitasPelabuhanP3KModel {
  int? kdFasilitasPelabuhan;
  String? kdCabang;
  String? kdTerminal;
  String? nmFasilitasPelabuhan;
  String? nmTerminal;
  double? latitude;
  double? longitude;

  FasilitasPelabuhanP3KModel(
      {this.kdFasilitasPelabuhan,
      this.kdCabang,
      this.kdTerminal,
      this.nmFasilitasPelabuhan,
      this.nmTerminal,
      this.latitude,
      this.longitude});

  FasilitasPelabuhanP3KModel.fromJson(Map<String, dynamic> json) {
    kdFasilitasPelabuhan = json['kd_fasilitas_pelabuhan'];
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    nmFasilitasPelabuhan = json['nm_fasilitas_pelabuhan'];
    nmTerminal = json['nm_terminal'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
