class ChecklistNonPerangkatModel {
  String? kdCabang;
  String? kdTerminal;
  String? kdDivisi;
  String? nmTerminal;
  String? nmDivisi;
  int? kdChecklist;
  String? jdlChecklist;
  int? kdJnsPerangkat;
  String? nmJnsPerangkat;
  String? kdShift;
  String? nmShift;
  int? kdLokasi;
  String? nmLokasi;
  String? ketChecklist;
  String? tglCreated;
  String? tglUpdated;
  String? userCreated;
  String? userUpdated;

  ChecklistNonPerangkatModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdDivisi,
      this.nmTerminal,
      this.nmDivisi,
      this.kdChecklist,
      this.jdlChecklist,
      this.kdJnsPerangkat,
      this.nmJnsPerangkat,
      this.kdShift,
      this.nmShift,
      this.kdLokasi,
      this.nmLokasi,
      this.ketChecklist,
      this.tglCreated,
      this.tglUpdated,
      this.userCreated,
      this.userUpdated});

  ChecklistNonPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdDivisi = json['kd_divisi'];
    nmTerminal = json['nm_terminal'];
    nmDivisi = json['nm_divisi'];
    kdChecklist = json['kd_checklist'];
    jdlChecklist = json['jdl_checklist'];
    kdJnsPerangkat = json['kd_jns_perangkat'];
    nmJnsPerangkat = json['nm_jns_perangkat'];
    kdShift = json['kd_shift'];
    nmShift = json['nm_shift'];
    kdLokasi = json['kd_lokasi'];
    nmLokasi = json['nm_lokasi'];
    ketChecklist = json['ket_checklist'];
    tglCreated = json['tgl_created'];
    tglUpdated = json['tgl_updated'];
    userCreated = json['user_created'];
    userUpdated = json['user_updated'];
  }
}
