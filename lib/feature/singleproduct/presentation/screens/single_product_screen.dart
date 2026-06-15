import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goldooni/core/utils/app_ext.dart';
import 'package:goldooni/core/widgets/network_image.dart';
import 'package:goldooni/core/widgets/shimmer_widget.dart';
import 'package:goldooni/core/widgets/show_toast.dart';
import 'package:goldooni/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:goldooni/feature/singleproduct/domain/entities/single_product_entity.dart';
import 'package:goldooni/feature/singleproduct/presentation/bloc/single_product_bloc.dart';
import 'package:goldooni/feature/singleproduct/presentation/widgets/zoom_in_image.dart';
import 'package:goldooni/gen/assets.gen.dart';

import '../../../../core/widgets/app_button.dart';

class SingleProductScreen extends StatefulWidget {
  final int id;
  const SingleProductScreen({super.key, required this.id});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sectionController;

  @override
  void initState() {
    super.initState();
    _sectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    context.read<SingleProductBloc>().getSingleProduct(widget.id);
    final cartBloc = context.read<CartBloc>();
    if (cartBloc.state.status == CartStatus.initial) {
      cartBloc.loadCart(showLoading: false);
    }
  }

  @override
  void dispose() {
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SingleProductBloc, SingleProductState>(
          listenWhen: (previous, current) => current is SingleProductLoaded,
          listener: (context, state) => _sectionController.forward(from: 0),
        ),
        BlocListener<CartBloc, CartState>(
          listenWhen: (previous, current) =>
              previous.feedbackStatus != current.feedbackStatus &&
              current.feedbackStatus != CartFeedbackStatus.none,
          listener: (context, state) {
            if (state.feedbackMessage.isNotEmpty) {
              ShowToast().show(state.feedbackMessage, context);
            }
            context.read<CartBloc>().clearFeedback();
          },
        ),
      ],
      child: BlocBuilder<SingleProductBloc, SingleProductState>(
        builder: (context, state) {
          if (state is SingleProductLoading) {
            return _buildLoading();
          }
          if (state is SingleProductError) {
            return _buildError(state);
          }
          if (state is SingleProductLoaded) {
            return _buildLoaded(state);
          }
          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    );
  }

  Scaffold _buildLoading() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ShimmerWidget(height: 300.h, width: double.infinity),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: ShimmerWidget(
                    height: index == 0 ? 24.h : 16.h,
                    width: double.infinity,
                    borderRadius: 12.r,
                  ),
                );
              }, childCount: 8),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
        child: ShimmerWidget(height: 56.h, width: double.infinity, borderRadius: 12.r),
      ),
    );
  }

  Scaffold _buildError(SingleProductError state) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 52.r, color: colors.error),
              12.height,
              Text(
                'Unable to load this product',
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              8.height,
              Text(
                state.failure.message,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurface.withValues(alpha: .7),
                ),
                textAlign: TextAlign.center,
              ),
              20.height,
              AppButton(
                title: 'Retry',
                onPressed: () {
                  context.read<SingleProductBloc>().getSingleProduct(widget.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _buildLoaded(SingleProductLoaded state) {
    final item = state.product;
    final colors = context.colors;
    final textTheme = context.textTheme;
    final infoAnimation = CurvedAnimation(
      parent: _sectionController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    );
    final reviewAnimation = CurvedAnimation(
      parent: _sectionController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    );

    return Scaffold(
      bottomNavigationBar: _BottomBar(item: item),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 320.h,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'singlehero',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    NetWorkImage(
                      image: item.mainImage,
                      height: 320.h,
                      width: double.infinity,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: .05),
                            Colors.black.withValues(alpha: .35),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16.w,
                      bottom: 18.h,
                      child: GestureDetector(
                        onTap: () => context.navigate(
                          ZoomInImage(image: item.mainImage),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(9.r),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: .45),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.zoom_in_map_rounded,
                            size: 22.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<SingleProductBloc>().toggleFavorite(item);
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: state.favoriteIds.contains(item.id)
                      ? Icon(
                          Icons.favorite,
                          key: const ValueKey('fav-on'),
                          color: Colors.red,
                        )
                      : SvgPicture.asset(
                          Assets.svg.mynauiHeart,
                          key: const ValueKey('fav-off'),
                          colorFilter: ColorFilter.mode(
                            colors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: _AnimatedSection(
              animation: infoAnimation,
              child: Container(
                color: colors.surface,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: textTheme.headlineMedium?.copyWith(
                        color: colors.secondary,
                      ),
                    ),
                    14.height,
                    Text(
                      item.description,
                      style: textTheme.bodyLarge?.copyWith(
                        height: 1.75,
                        color: colors.onSurface,
                      ),
                    ),
                    14.height,
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _metaChip('دسته بندی : ${item.category}'),
                        _metaChip('موجودی : ${item.status}'),
                        _metaChip('نظرات : ${item.countComments}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: 14.height),
          SliverToBoxAdapter(
            child: _AnimatedSection(
              animation: reviewAnimation,
              child: Container(
                color: colors.surface,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('نظرات کاربران', style: textTheme.titleMedium),
                        TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          icon: Icon(
                            Icons.keyboard_arrow_left_outlined,
                            color: colors.primary,
                          ),
                          onPressed: () {},
                          label: Text(
                            'مشاهده ${item.countComments} نظر',
                            style: textTheme.bodyMedium?.copyWith(
                              color: colors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          item.averageStars.toStringAsFixed(1).toPersianNumber(),
                          style: textTheme.headlineSmall?.copyWith(
                            color: colors.secondary,
                          ),
                        ),
                        Icon(Icons.star, color: Colors.amber, size: 30.r),
                        8.width,
                        Text(
                          'بر اساس ${item.countComments} نظر',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 0.3.sh,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item.comments.isEmpty ? 3 : item.comments.length,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        itemBuilder: (context, index) {
                          return _ReviewCard(
                            comment: item.comments.isEmpty
                                ? null
                                : item.comments[index] as dynamic,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
    );
  }

  Widget _metaChip(String text) {
    final colors = context.colors;
    final textTheme = context.textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: textTheme.labelMedium?.copyWith(
          color: colors.primary,
        ),
      ),
    );
  }
}

class _AnimatedSection extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedSection({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(animation);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final SingleProductEntity item;

  const _BottomBar({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      height: 0.12.sh,
      decoration: BoxDecoration(color: colors.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              final cartItems = cartState.carts.isNotEmpty
                  ? cartState.carts.first.items
                  : const [];
              int? cartItemId;
              for (final element in cartItems) {
                if (element.product.id == item.id) {
                  cartItemId = element.id;
                  break;
                }
              }

              final isInCart = cartItemId != null;
              final isLoading = cartState.isMutating &&
                  (cartState.activeItemId == null ||
                      cartState.activeItemId == cartItemId);

              return AppButton(
                title: isInCart ? 'حذف از سبد' : 'اضافه به سبد',
                icon: isLoading
                    ? SizedBox(
                        width: 16.r,
                        height: 16.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.onPrimary,
                        ),
                      )
                    : const SizedBox(),
                onPressed: () {
                  if (isLoading) return;
                  if (isInCart) {
                    context.read<CartBloc>().deleteItem(cartItemId!);
                    return;
                  }
                  context.read<CartBloc>().addItem(item.id, 1);
                },
              );
            },
          ),
          Column(
            spacing: 4,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ('${item.finalPrice.comma} تومان').toPersianNumber(),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Visibility(
                visible: item.discount != 0,
                child: Text(
                  ('${item.price.comma} تومان').toPersianNumber(),
                  style: textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: colors.onSurface.withValues(alpha: .6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final dynamic comment;

  const _ReviewCard({this.comment});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    String author = 'کاربر گلدونی';
    String body =
        'عالی بودش، کیفیتش خوب بود و دقیقا همونی بود که تو عکس نشون داده شده بود، من خیلی راضی ام از خرید این محصول و حتما پیشنهادش میکنم به بقیه.';
    String date = 'اخیرا';

    if (comment is Map<String, dynamic>) {
      author = (comment['user_name'] ?? comment['user'] ?? author).toString();
      body = (comment['text'] ?? comment['content'] ?? body).toString();
      date = (comment['created_at'] ?? date).toString();
    }

    return Container(
      width: 0.75.sw,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: .06),
            offset: const Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author,
              style: textTheme.titleMedium?.copyWith(color: colors.secondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            6.height,
            Row(
              children: List.generate(
                5,
                (i) => Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: Icon(Icons.star, color: Colors.amber, size: 18.r),
                ),
              ),
            ),
            8.height,
            Expanded(
              child: Text(
                body,
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: colors.onSurface,
                ),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ),
            8.height,
            Text(
              date,
              style: textTheme.bodySmall?.copyWith(
                color: colors.onSurface.withValues(alpha: .7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
