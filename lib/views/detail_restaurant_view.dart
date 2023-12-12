import 'package:flutter/material.dart';
import 'package:resto_fav_apps/models/ListRestaurant.dart';

class DetailRestaurantView extends StatelessWidget {
  static const routeName = '/DetailRestaurantView';
  final ListRestaurant listRestaurant;
  const DetailRestaurantView({Key? key, required this.listRestaurant})
      : super(key: key);

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

  Widget _content(BuildContext context, ListRestaurant listRestaurant) {
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
            listRestaurant.name,
            style: const TextStyle(
              fontSize: 16,
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
                    listRestaurant.city,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey),
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
          _card(color, 'Description'),
          SizedBox(
            height: mediaQuery.size.height * 0.15,
            child: Text(listRestaurant.description),
          ),
          _card(color, 'Foods'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: listRestaurant.menus.foods
                  .map(
                    (e) => SizedBox(
                      height: 120,
                      width: 160,
                      child: Card(
                        color: color.onPrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.fastfood,
                                size: 40,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  e.name,
                                  textAlign: TextAlign.center,
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
            child: Row(
              children: listRestaurant.menus.drinks
                  .map(
                    (e) => SizedBox(
                      height: 120,
                      width: 160,
                      child: Card(
                        color: color.onPrimary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.local_drink,
                                size: 40,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  e.name,
                                  textAlign: TextAlign.center,
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          floating: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          expandedHeight: mediaQuery.size.height * 0.3,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(listRestaurant
                    .pictureId), // Gantilah dengan path gambar Anda.
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          _content(context, listRestaurant),
        ]))
      ],
    ));
  }
}
