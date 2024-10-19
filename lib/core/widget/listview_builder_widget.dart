import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListViewBuilder<T> extends StatelessWidget {
  final ScrollController? scrollController;
  final ScrollPhysics scrollPhysics;
  final Axis scrollDirection;
  final List<T> items;
  final List<T> skeletonItems;
  final bool loading;
  final Widget seperator;
  final EdgeInsets padding;
  final Function(int index, T item) itemBuilder;

  const ListViewBuilder({
    super.key,
    this.scrollController,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.scrollDirection = Axis.vertical,
    required this.items,
    this.skeletonItems = const [],
    this.loading = false,
    this.seperator = const SizedBox(),
    this.padding = const EdgeInsets.all(0),
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final items = loading ? skeletonItems : this.items;

    return Skeletonizer(
      enabled: loading,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: scrollDirection,
        physics: scrollPhysics,
        itemCount: items.length,
        shrinkWrap: true,
        padding: padding,
        separatorBuilder: (context, i) => seperator,
        itemBuilder: (context, i) => itemBuilder(i, items[i]),
      ),
    );
  }
}
