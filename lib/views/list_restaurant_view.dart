import 'package:flutter/material.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/components/warning_message.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/viewmodel/restaurant_view_model.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';
import 'package:provider/provider.dart';

class ListRestaurantView extends StatelessWidget {
  static const routeName = '/ListRestaurantView';
  const ListRestaurantView({Key? key}) : super(key: key);

  Widget _buildItem(
      BuildContext context, RestaurantModel listRestaurant, ColorScheme color) {
    String urlPicture =
        "https://restaurant-api.dicoding.dev/images/medium/${listRestaurant.pictureId}";
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        DetailRestaurantView.routeName,
        arguments: listRestaurant,
      ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
        create: (context) => RestaurantViewModel(),
        builder: (context, _) {
          return Consumer<RestaurantViewModel>(builder: (context, provider, _) {
            switch (provider.resultData) {
              case ResultData.hasData:
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      'RestoFav',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color.primary),
                    ),
                  ),
                  body: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: provider.ctrlQuery,
                            maxLines: 1,
                            onChanged: (value) {
                              provider.searchRestaurant(value);
                            },
                            decoration: InputDecoration(
                                suffixIcon:
                                    provider.ctrlQuery.value.text.isEmpty
                                        ? const Icon(Icons.search)
                                        : IconButton(
                                            onPressed: () {
                                              provider.ctrlQuery.clear();
                                              provider.getRestaurant();
                                            },
                                            icon: const Icon(Icons.close)),
                                isDense: true,
                                filled: true,
                                hintText: 'Search your favorite restaurant',
                                hintStyle: const TextStyle(color: Colors.grey),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(26)),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
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
                        Expanded(
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: provider.listRestaurant.length,
                            itemBuilder: (context, index) {
                              return _buildItem(context,
                                  provider.listRestaurant[index], color);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case ResultData.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ResultData.noData:
                return WarningMessage(
                  message: "No Data",
                  image: Assets.icNoData,
                  isButtonVisible: true,
                  onPressed: () => provider.getRestaurant(),
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
          });
        });
  }
}
