// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:risa_reborn/router/app_routes.dart';
import 'package:risa_reborn/screen/apar/Inventori/apar_tabbar.dart';
import 'package:risa_reborn/screen/apar/master_apar.dart';
import 'package:risa_reborn/screen/audit/master_audit.dart';
import 'package:risa_reborn/screen/barang_apd/master_apd.dart';
import 'package:risa_reborn/screen/barangp3k/master_p3k.dart';
import 'package:risa_reborn/screen/berita_acara/master_berita_acara.dart';
import 'package:risa_reborn/screen/checklist/master_checklist.dart';
import 'package:risa_reborn/screen/homepage/dashboard/dashboard_binding.dart';
import 'package:risa_reborn/screen/homepage/dashboard/dashboard_screen.dart';
import 'package:risa_reborn/screen/insiden/master_insiden.dart';
import 'package:risa_reborn/screen/laporan/master_laporan.dart';
import 'package:risa_reborn/screen/login/login_form.dart';
import 'package:risa_reborn/screen/login/pilih_role.dart';
import 'package:risa_reborn/screen/maintenance/periode_maintenance.dart';
import 'package:risa_reborn/screen/peralatan_kerja/master_peralatan_kerja.dart';
import 'package:risa_reborn/screen/perangkat/master_perangkat/perangkat_jenis.dart';
import 'package:risa_reborn/screen/stock/stock_kategori.dart';
import 'package:risa_reborn/screen/stock/stock_list.dart';

import '../screen/kegiatan_hsse/master_kegiatan.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()),

    /***************
     * Login route pages *
     ***************/
    GetPage(
      name: AppRoute.login,
      page: () => FormLogin(),
    ),
    GetPage(
      name: AppRoute.pilihRole,
      page: () => PilihRole(),
    ),
    GetPage(
      name: AppRoute.perangkat,
      page: () => const JenisPerangkat(),
    ),
    GetPage(
      name: AppRoute.checklistPerangkat,
      page: () => const MasterChechklist(),
    ),
    GetPage(
      name: AppRoute.apar,
      page: () => const MasterApar(),
    ),
    GetPage(
      name: AppRoute.audit,
      page: () => const Audit(),
    ),
    GetPage(
      name: AppRoute.barangP3k,
      page: () => const MasterP3K(),
    ),
    GetPage(
      name: AppRoute.barangApd,
      page: () => const MasterAPD(),
    ),
    GetPage(
      name: AppRoute.peralatanKerja,
      page: () => const MasterPeralatanKerja(),
    ),
    GetPage(
      name: AppRoute.beritaAcara,
      page: () => const BeritaAcara(),
    ),
    GetPage(
      name: AppRoute.insiden,
      page: () => const Insiden(),
    ),
    GetPage(
      name: AppRoute.kegiatanHSSE,
      page: () => const KegiatanHSSE(),
    ),
    GetPage(
      name: AppRoute.laporan,
      page: () => const Laporan(),
    ),
    GetPage(
      name: AppRoute.maintenance,
      page: () => const PeriodeMaintenance(),
    ),
    GetPage(
      name: AppRoute.stock,
      page: () => const KategoriStock(),
    ),
  ];
}
