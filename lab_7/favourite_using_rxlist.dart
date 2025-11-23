// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'RxList Favorite Icon Fixed',
    home: FavoriteListScreen(),
  ));
}

// Step 1: Item model with name & RxBool
class ItemModel {
  String name;
  RxBool isFavorite;

  ItemModel({required this.name, bool initialFavorite = false})
      : isFavorite = initialFavorite.obs;
}

// Step 2: Controller with RxList<ItemModel>
class FavoriteController extends GetxController {
  var items = <ItemModel>[
    ItemModel(name: "Apple"),
    ItemModel(name: "Banana"),
    ItemModel(name: "Orange"),
    ItemModel(name: "Mango"),
    ItemModel(name: "Grapes"),
  ].obs;

  void toggleFavorite(int index) {
    items[index].isFavorite.value = !items[index].isFavorite.value;
  }
}

// Step 3: UI
class FavoriteListScreen extends StatelessWidget {
  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite List (Fixed)')),
      body: Obx(() => ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final item = controller.items[index];
          return ListTile(
            title: Text(item.name),
            trailing: Obx(() => IconButton(
              icon: Icon(
                item.isFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                item.isFavorite.value ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                controller.toggleFavorite(index);
              },
            )),
          );
        },
      )),
    );
  }
}
