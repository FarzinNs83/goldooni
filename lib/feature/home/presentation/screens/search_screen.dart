import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goldooni/feature/home/domain/entities/search_entity.dart';

import '../../../../core/utils/app_ext.dart';
import '../../../../core/widgets/network_image.dart';
import '../../../../export_pkg.dart';
import '../../../singleproduct/presentation/screens/single_product_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  final _debouncer = SearchDebouncer();

  final List<String> _recentSearches = [];

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debouncer.run(() {
      context.read<HomeBloc>().searchByName(value);
    });
  }

  void _addRecent(String value) {
    if (value.isEmpty) return;
    _recentSearches.remove(value);
    _recentSearches.insert(0, value);
    if (_recentSearches.length > 6) {
      _recentSearches.removeLast();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'جستجو...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
          onSubmitted: _addRecent,
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final items = context.read<HomeBloc>().searchByNameList;
          if (_controller.text.isEmpty && _recentSearches.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                Text(
                  'جستجوهای اخیر',
                  style: context.textTheme.titleSmall,
                ),
                12.height,
                Wrap(
                  spacing: 8.w,
                  children: _recentSearches.map((e) {
                    return ActionChip(
                      label: Text(e),
                      onPressed: () {
                        _controller.text = e;
                        _onSearchChanged(e);
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          }

          if (state is HomeSearchLoading) {
            return Center(
              child: CircularProgressIndicator(color: colors.primary),
            );
          }

          if (items.isEmpty) {
            return Center(
              child: Text('موردی یافت نشد'),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: items.length,
            separatorBuilder: (_, __) =>
                Divider(color: colors.onSurface.withValues(alpha: .1)),
            itemBuilder: (context, index) {
              final product = items[index];
              return SearchProductItem(
                product: product,
              );
            },
          );
        },
      ),
    );
  }
}
class SearchProductItem extends StatelessWidget {
  final SearchEntity product;

  const SearchProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => context.navigate(
        SingleProductScreen(id: product.id),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: NetWorkImage(
                  image: product.image,
                  height: 120.h,
                  width: 120.w,
                ),
              ),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium,
                    ),
                    8.height,
                    Text(
                      "${(product.price as num).comma} تومان"
                          .toPersianNumber(),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchDebouncer {
  SearchDebouncer({this.milliseconds = 400});
  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void dispose() {
    _timer?.cancel();
  }
}
