import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/components/warning_message.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/viewmodel/favorite_view_model.dart';

import 'detail_restaurant_view.dart';

class ListFavoriteView extends StatelessWidget {
  const ListFavoriteView({Key? key}) : super(key: key);

  Widget _cardContent() {
    String? imageBaseUrl = 'https://restaurant-api.dicoding.dev/images/small/';

    return Consumer<FavoriteViewModel>(builder: (context, provider, child) {
      if (provider.resultData == ResultState.hasData) {
        return ListView.builder(
          itemCount: provider.favourite.length,
          itemBuilder: (context, index) {
            final listFavorite = provider.favourite[index];
            return GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushDynamicScreen(
                  context,
                  screen: MaterialPageRoute(
                    builder: (context) =>
                        DetailRestaurantView(restaurantModel: listFavorite),
                  ),
                  withNavBar: false,
                );
              },
              child: Card(
                elevation: 1,
                child: ListTile(
                  title: Text(listFavorite.name),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  trailing: GestureDetector(
                      onTap: () {
                        provider.removeFavourite(listFavorite.id);
                      },
                      child: const Icon(
                        Icons.restore_from_trash_outlined,
                        color: Colors.redAccent,
                      )),
                  leading: Hero(
                    tag: '$imageBaseUrl${listFavorite.pictureId}',
                    transitionOnUserGestures: true,
                    child: SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          '$imageBaseUrl${listFavorite.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return const Center(
          child: WarningMessage(message: 'No Data', image: Assets.icNoData),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            FavoriteViewModel(databaseHelper: DatabaseHelper()),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Favorite"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _cardContent(),
            ),
          );
        });
  }
}
