class ChecklistHeaderNonPerangkatModel {
  String? kdCabang;
  String? kdTerminal;
  String? kdDivisi;
  String? nmTerminal;
  String? nmDivisi;
  int? kdChecklistH;
  String? username;
  String? nmUserlogin;
  int? kdShift;
  String? nmShift;
  String? tglCreated;
  String? tglUpdated;
  String? userCreated;
  String? userUpdated;

  ChecklistHeaderNonPerangkatModel(
      {this.kdCabang,
      this.kdTerminal,
      this.kdDivisi,
      this.nmTerminal,
      this.nmDivisi,
      this.kdChecklistH,
      this.username,
      this.nmUserlogin,
      this.kdShift,
      this.nmShift,
      this.tglCreated,
      this.tglUpdated,
      this.userCreated,
      this.userUpdated});

  ChecklistHeaderNonPerangkatModel.fromJson(Map<String, dynamic> json) {
    kdCabang = json['kd_cabang'];
    kdTerminal = json['kd_terminal'];
    kdDivisi = json['kd_divisi'];
    nmTerminal = json['nm_terminal'];
    nmDivisi = json['nm_divisi'];
    kdChecklistH = json['kd_checklist_h'];
    username = json['username'];
    nmUserlogin = json['nm_userlogin'];
    kdShift = json['kd_shift'];
    nmShift = json['nm_shift'];
    tglCreated = json['tgl_created'];
    tglUpdated = json['tgl_updated'];
    userCreated = json['user_created'];
    userUpdated = json['user_updated'];
  }
}
