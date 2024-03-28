// ignore_for_file: unnecessary_import, type_literal_in_constant_pattern

import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/failure.dart';
import 'package:dilaundry/datasource/shop_datasource.dart';
import 'package:dilaundry/models/shop_model.dart';
import 'package:dilaundry/providers/search_by_city_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchByCityPage extends ConsumerStatefulWidget {
  const SearchByCityPage({super.key, required this.query});
  final String query;

  @override
  ConsumerState<SearchByCityPage> createState() => _SearchByCityPageState();
}

class _SearchByCityPageState extends ConsumerState<SearchByCityPage> {
  final edtSearch = TextEditingController();

  execute() {
    setSearchByCityStatus(ref, 'Loading');
    ShopDataSource.searchByCity(edtSearch.text).then((value) {
      value.fold(
        (failure) {
          switch (failure.runtimeType) {
            case ServerFailure:
              setSearchByCityStatus(ref, 'Server Error');
              break;
            case NotFoundFailure:
              setSearchByCityStatus(ref, 'Error Not Found');
              break;
            case ForbiddenFailure:
              setSearchByCityStatus(ref, 'You don\'t have access');
              break;
            case BadRequestFailure:
              setSearchByCityStatus(ref, 'bad Request');
              break;
            case UnauthorisedFailure:
              setSearchByCityStatus(ref, 'Unauthorized');
              break;
            default:
              setSearchByCityStatus(ref, 'Request Error');
              break;
          }
        },
        (result) {
          setSearchByCityStatus(ref, 'Success');
          List data = result['data'];
          List<ShopModel> list = data.map((e) => ShopModel.fromJson(e)).toList();
          ref.read(searchByCityListProvider.notifier).setData(list);
        },
      );
    });
  }

  @override
  void initState() {
    if(widget.query != ''){
      edtSearch.text = widget.query;

      execute();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.green,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text(
                'City :',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  height: 1
                ),
              ),
              Expanded(
                child: TextField(
                  controller: edtSearch,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(height: 1),
                  onSubmitted: (value) => execute(),
                ))
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => execute(), 
            icon: const Icon(Icons.search)),
        ],
      ),
      body: Consumer(
        builder: (_, wiRef, __) {
          String status = wiRef.watch(searchByCityStatusProvider);
          List<ShopModel> list = wiRef.watch(searchByCityListProvider);
          if(status == ''){
            return DView.nothing();
          }

          if(status == 'Loading') {
            return DView.loadingCircle();
          }

          if(status == 'Success') {
            
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                ShopModel shop = list[index];
                return ListTile(
                  onTap: () {},
                  leading:  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    radius: 18,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(shop.name),
                  subtitle: Text(shop.city),
                  trailing: const Icon(Icons.navigate_next),
                );
              },
            );
          }
          
          return DView.error(data: status);

          

        },
      ),
    );
  }
}