import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';
import 'package:resto_fav_apps/viewmodel/favorite_view_model.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';

class CardContent extends StatelessWidget {
  final Restaurant restaurant;
  const CardContent({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? imageUrl = 'https://restaurant-api.dicoding.dev/images/small/';

    return Consumer<FavoriteViewModel>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavourite(restaurant.id.toString()),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 1,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                child: ListTile(
                  trailing: isFavorite
                      ? IconButton(
                          icon: const Icon(Icons.favorite),
                          color: Colors.red,
                          onPressed: () => provider
                              .removeFavourite(restaurant.id.toString()),
                        )
                      : IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          color: Colors.red,
                          onPressed: () => provider.addFavorite(restaurant),
                        ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  leading: restaurant.pictureId != null
                      ? Hero(
                          tag: '$imageUrl${restaurant.pictureId}',
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              '$imageUrl${restaurant.pictureId}',
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text('No Image Available'),
                        ),
                  title: Text(
                    restaurant.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.red,
                            size: 15,
                          ),
                          Text(
                            restaurant.city ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amberAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, DetailRestaurantView.routeName,
                        arguments: restaurant);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
