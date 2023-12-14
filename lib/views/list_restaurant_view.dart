import 'package:flutter/material.dart';
import 'package:resto_fav_apps/models/list_restaurant_model.dart';
import 'package:resto_fav_apps/services/list_restaurant_service.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';

class ListRestaurantView extends StatelessWidget {
  static const routeName = '/ListRestaurantView';
  const ListRestaurantView({Key? key}) : super(key: key);

  Widget _buildItem(BuildContext context, ListRestaurantModel listRestaurant,
      ColorScheme color) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailRestaurantView.routeName,
        arguments: listRestaurant,
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Card(
          elevation: 3,
          // color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: listRestaurant.pictureId,
                transitionOnUserGestures: true,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 16.0, top: 8.0, bottom: 8.0, left: 8.0),
                  child: Container(
                    width: 120.0,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(listRestaurant.pictureId),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      listRestaurant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.red),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          listRestaurant.city,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${listRestaurant.rating}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resto Fav',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              'Recommendation restaurant for you',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/data/local_restaurant.json'),
          builder: (context, AsyncSnapshot<String> snapshot) {
            final List<ListRestaurantModel> listRestaurant =
                ListRestaurantService().getLisRestaurant(snapshot.data);
            return ListView.builder(
              itemCount: listRestaurant.length,
              itemBuilder: (context, index) {
                return _buildItem(context, listRestaurant[index], color);
              },
            );
          },
        ),
      ),
    );
  }
}
