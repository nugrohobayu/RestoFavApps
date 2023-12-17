import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/viewmodel/detail_restaurant_view_model.dart';

class DetailRestaurantView extends StatelessWidget {
  static const routeName = '/DetailRestaurantView';
  final String id;
  const DetailRestaurantView({Key? key, required this.id}) : super(key: key);

  Future<void> _showDialog(
      BuildContext context, DetailRestaurantViewModel provider) {
    final mediaQuery = MediaQuery.of(context);

    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: mediaQuery.size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _card(ColorScheme color, String title) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          color: color.onBackground,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ));
  }

  Widget _content(BuildContext context, DetailRestaurantViewModel provider) {
    final mediaQuery = MediaQuery.of(context);
    final color = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${provider.detailRestaurant?.name}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.red),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${provider.detailRestaurant?.city}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
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
                    '${provider.detailRestaurant?.rating}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
          _card(color, 'Description'),
          SizedBox(
            height: mediaQuery.size.height * 0.15,
            child: Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                '${provider.detailRestaurant?.description}'),
          ),
          _card(color, 'Review Restaurant'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: provider.listReview
                  .map(
                    (e) => SizedBox(
                      height: mediaQuery.size.height * 0.2,
                      width: mediaQuery.size.height * 0.3,
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: mediaQuery.size.height * 0.035,
                                width: mediaQuery.size.width * 0.45,
                                child: Text(
                                  e.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: mediaQuery.size.height * 0.04,
                                width: mediaQuery.size.width * 0.45,
                                child: Text(
                                  e.date,
                                  // textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  e.review,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          _card(color, 'Foods'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: provider.listFoods
                  .map(
                    (e) => SizedBox(
                      height: mediaQuery.size.height * 0.16,
                      width: mediaQuery.size.height * 0.2,
                      child: Card(
                        color: color.onPrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Text(
                                  e.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          _card(color, 'Drinks'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              // height: mediaQuery.size.height * 0.4,
              child: Row(
                children: provider.listDrinks
                    .map(
                      (e) => SizedBox(
                        height: mediaQuery.size.height * 0.16,
                        width: mediaQuery.size.height * 0.2,
                        child: Card(
                          color: color.onPrimary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.local_drink,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Text(
                                    e.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final color = Theme.of(context).colorScheme;

    return ChangeNotifierProvider(
        create: (context) => DetailRestaurantViewModel(id),
        builder: (context, _) {
          return Consumer<DetailRestaurantViewModel>(
              builder: (context, provider, _) {
            String urlPicture =
                'https://restaurant-api.dicoding.dev/images/medium/${provider.detailRestaurant?.pictureId}';
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    expandedHeight: mediaQuery.size.height * 0.3,
                    flexibleSpace: Hero(
                      tag: urlPicture,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: NetworkImage(urlPicture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    _content(context, provider),
                  ]))
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.grey.withOpacity(.15),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                width: mediaQuery.size.width,
                height: mediaQuery.size.height * 0.13,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.primary,
                  ),
                  onPressed: () {
                    _showDialog(context, provider);
                  },
                  child: const Text(
                    'Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }
}
