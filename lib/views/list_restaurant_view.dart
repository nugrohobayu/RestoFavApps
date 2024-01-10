import 'package:flutter/material.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/components/warning_message.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/viewmodel/favorite_view_model.dart';
import 'package:resto_fav_apps/viewmodel/restaurant_view_model.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../data/helpers/result_data.dart';

class ListRestaurantView extends StatelessWidget {
  static const routeName = '/ListRestaurantView';
  const ListRestaurantView({Key? key}) : super(key: key);

  Widget _card(BuildContext context, RestaurantModel listRestaurant) {
    String urlPicture =
        "https://restaurant-api.dicoding.dev/images/medium/${listRestaurant.pictureId}";
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushDynamicScreen(
          context,
          screen: MaterialPageRoute(
            builder: (context) =>
                DetailRestaurantView(restaurantModel: listRestaurant),
          ),
          withNavBar: false,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 8,
              spreadRadius: 4,
              color: Colors.grey.withOpacity(.2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: urlPicture,
                    transitionOnUserGestures: true,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(urlPicture),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<FavoriteViewModel>(
                        builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            listRestaurant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black87),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.star_rate_rounded,
                                  color: Colors.amberAccent),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  listRestaurant.rating.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                provider.addFavorite(listRestaurant);
                              },
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, RestaurantViewModel provider, ColorScheme color) {
    switch (provider.resultData) {
      case ResultData.hasData:
        return GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              mainAxisExtent: 250,
            ),
            itemCount: provider.listRestaurant.length,
            itemBuilder: (context, index) {
              final listRestaurant = provider.listRestaurant[index];
              return _card(context, listRestaurant);
            });
      case ResultData.loading:
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        );
      case ResultData.noData:
        return WarningMessage(
          message: "No Data",
          image: Assets.icNoData,
          isButtonVisible: true,
          onPressed: () {
            provider.getRestaurant();
            provider.ctrlQuery.clear();
          },
        );
      case ResultData.error:
        return Center(
          child: WarningMessage(
            message: 'Error Connection',
            image: Assets.icErrorConnection,
            isButtonVisible: true,
            onPressed: () => provider.getRestaurant(),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => RestaurantViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                FavoriteViewModel(databaseHelper: DatabaseHelper()),
          )
        ],
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Home',
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Consumer<RestaurantViewModel>(
                  builder: (context, provider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 65,
                      child: TextFormField(
                        controller: provider.ctrlQuery,
                        maxLines: 1,
                        onChanged: (value) {
                          provider.searchRestaurant(value);
                        },
                        decoration: InputDecoration(
                            suffixIcon: provider.ctrlQuery.value.text.isEmpty
                                ? const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 26,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      provider.ctrlQuery.clear();
                                      provider.getRestaurant();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.black54,
                                      size: 24,
                                    )),
                            isDense: true,
                            filled: true,
                            hintText: 'Search your favorite restaurant',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(26)),
                              borderSide: BorderSide(
                                color: Colors.black26,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(26)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            )),
                      ),
                    ),
                    Expanded(child: _buildItem(context, provider, color))
                  ],
                );
              }),
            ),
          );
        });
  }
}
