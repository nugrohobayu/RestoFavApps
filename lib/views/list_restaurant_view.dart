import 'package:flutter/material.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/components/card_content.dart';
import 'package:resto_fav_apps/components/warning_message.dart';
import 'package:resto_fav_apps/viewmodel/restaurant_view_model.dart';
import 'package:provider/provider.dart';

import '../data/helpers/result_data.dart';

class ListRestaurantView extends StatelessWidget {
  static const routeName = '/ListRestaurantView';
  const ListRestaurantView({Key? key}) : super(key: key);

  Widget _buildItem(
      BuildContext context, RestaurantViewModel provider, ColorScheme color) {
    switch (provider.resultData) {
      case ResultData.hasData:
        return ListView.builder(
          itemCount: provider.listRestaurant?.length,
          itemBuilder: (context, index) {
            return CardContent(restaurant: provider.listRestaurant![index]);
          },
        );
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
        child: Consumer<RestaurantViewModel>(builder: (context, provider, _) {
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
                        borderRadius: BorderRadius.all(Radius.circular(26)),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(26)),
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
  }
}
