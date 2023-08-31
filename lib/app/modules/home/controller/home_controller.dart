import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:realtimeapp/app/modules/home/binding/home_binding.dart';
import 'package:realtimeapp/app/modules/home/views/home_view.dart';

import '../../../../firebase_options.dart';

class HomeController extends GetxController {
  final RxString text = ''.obs;

  @override
  Future<void> onInit() async {
    await DefaultFirebaseOptions.firebaseInit();
    DatabaseReference ref = FirebaseDatabase.instance.ref('data');

    final snapshot = await ref.child('data').get();
    if (snapshot.exists) {
      print(snapshot.value);
      text.value = snapshot.value.toString();
    } else {}
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      text.value = data.toString();
    });
  }
}
