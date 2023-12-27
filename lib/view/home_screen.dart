import 'package:flutter/material.dart';
import 'package:flutter_ios_android_mvvm/data/response/status.dart';
import 'package:flutter_ios_android_mvvm/res/color.dart';
import 'package:flutter_ios_android_mvvm/view_model/home_view_model.dart';
import 'package:flutter_ios_android_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewModel.fetchProductList();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: () {
                userPreference.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                }).onError((error, stackTrace) {});
              },
              child: const Center(child: Text('Log out'))),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, _) {
              switch (value.productList.status) {
                case Status.LOADING:
                  return const CircularProgressIndicator();
                case Status.ERROR:
                  return Text(value.productList.message.toString() + 'Error');
                case Status.COMPLETE:
                  return ListView.builder(
                      itemCount: value.productList.data?.products?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              value.productList.data!.products![index].thumbnail
                                  .toString(),
                              errorBuilder: (context, error, stack) {
                                return Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            title: Text(value
                                .productList.data!.products![index].title
                                .toString()),
                            subtitle: Text(value
                                .productList.data!.products![index].description
                                .toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(value
                                    .productList.data!.products![index].rating
                                    .toString()),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                default:
                // TODO: Handle this case.
              }
              return Container();
            },
          )),
    );
  }
}
