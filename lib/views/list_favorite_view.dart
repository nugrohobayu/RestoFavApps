import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/components/card_content.dart';
import 'package:resto_fav_apps/components/warning_message.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/data/helpers/result_data.dart';
import 'package:resto_fav_apps/viewmodel/favorite_view_model.dart';

class ListFavoriteView extends StatelessWidget {
  const ListFavoriteView({Key? key}) : super(key: key);

  Widget _cardContent() {
    return Consumer<FavoriteViewModel>(builder: (context, provider, child) {
      if (provider.state == ResultData.hasData) {
        return ListView.builder(
          itemCount: provider.favourite.length,
          itemBuilder: (context, index) {
            final listFavorite = provider.favourite[index];
            return CardContent(restaurant: listFavorite);
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
