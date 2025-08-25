import 'package:get/get.dart';

class NewsController extends GetxController {
  // index buat BottomNavigationBar
  var selectedIndex = 0.obs;

  // contoh state lain yg kamu udah pake di HomePage
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var articles = [].obs;

  // fungsi refresh
  void refreshNews() {
    // logika fetch API / ambil data ulang
    isLoading.value = true;
    // misal simulasi selesai loading
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      articles.assignAll([
        {"title": "Berita 1"},
        {"title": "Berita 2"},
      ]);
    });
  }
}
