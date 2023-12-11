import 'package:flutter/material.dart';
import 'package:resto_fav_apps/models/ListRestaurant.dart';
import 'package:resto_fav_apps/services/list_restaurant_service.dart';

class ListRestaurantView extends StatelessWidget {
  static const routeName = '/ListRestaurantView';
  const ListRestaurantView({Key? key}) : super(key: key);

  Widget _buildArticleItem(
      BuildContext context, ListRestaurant listRestaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        listRestaurant.pictureId,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(listRestaurant.name),
      // subtitle: Text(listRestaurant.description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Restaurant'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data/local_restaurant.json'),
        builder: (context, AsyncSnapshot<String> snapshot) {
          print('datt ${snapshot.data}');
          final List<ListRestaurant> listRestaurant =
              ListRestaurantService().getLisRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: listRestaurant.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, listRestaurant[index]);
            },
          );
        },
      ),
    );
  }
}
