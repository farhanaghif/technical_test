// import 'dart:convert';

// class lokasi {
//   int? kdLokasi;
//   String? kdCabang;
//   String? kdTerminal;
//   String? kdDivisi;
//   String? nmLokasi;
//   String? nmTerminal;
//   String? nmDivisi;
//   double? latitude;
//   double? longitude;
//   String? recStat;

//   lokasi(
//       {this.kdLokasi,
//       this.kdCabang,
//       this.kdTerminal,
//       this.kdDivisi,
//       this.nmLokasi,
//       this.nmTerminal,
//       this.nmDivisi,
//       this.latitude,
//       this.longitude,
//       this.recStat});

//   lokasi.fromJson(Map<String, dynamic> json) {
//     kdLokasi = json['kd_lokasi'];
//     kdCabang = json['kd_cabang'];
//     kdTerminal = json['kd_terminal'];
//     kdDivisi = json['kd_divisi'];
//     nmLokasi = json['nm_lokasi'];
//     nmTerminal = json['nm_terminal'];
//     nmDivisi = json['nm_divisi'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     recStat = json['rec_stat'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['kd_lokasi'] = this.kdLokasi;
//     data['kd_cabang'] = this.kdCabang;
//     data['kd_terminal'] = this.kdTerminal;
//     data['kd_divisi'] = this.kdDivisi;
//     data['nm_lokasi'] = this.nmLokasi;
//     data['nm_terminal'] = this.nmTerminal;
//     data['nm_divisi'] = this.nmDivisi;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['rec_stat'] = this.recStat;
//     return data;
//   }
// }
