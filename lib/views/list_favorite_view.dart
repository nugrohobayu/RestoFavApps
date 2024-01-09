import 'package:flutter/material.dart';

class ListFavoriteView extends StatelessWidget {
  const ListFavoriteView({Key? key}) : super(key: key);

  Widget _cardContent({required String title, required String imgUrl}) {
    return Card(
      elevation: 1,
      child: ListTile(
        title: Text(title),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        trailing: GestureDetector(
            child: const Icon(Icons.restore_from_trash_outlined)),
        leading: SizedBox(
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small/';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _cardContent(title: "", imgUrl: '${imageBaseUrl}14'),
      ),
    );
  }
}
