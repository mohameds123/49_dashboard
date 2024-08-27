import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/paged_child_builder_delegate.dart';
import '../core/paging_controller.dart';
import 'paged_sliver_list.dart';

class PagedListView<PageKeyType, ItemType> extends BoxScrollView {
  const PagedListView({
    required this.pagingController,
    required this.builderDelegate,
    ScrollController? scrollController,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.showNoItemsMessage = true,
    this.messageColor = Colors.black,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  })  : _separatorBuilder = null,
        _shrinkWrapFirstPageIndicators = shrinkWrap,
        super(
          controller: scrollController,
        );

  const PagedListView.separated({
    required this.pagingController,
    required this.builderDelegate,
    required IndexedWidgetBuilder separatorBuilder,
    ScrollController? scrollController,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.showNoItemsMessage = true,
    this.messageColor = Colors.black,
    super.cacheExtent,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  })  : _shrinkWrapFirstPageIndicators = shrinkWrap,
        _separatorBuilder = separatorBuilder,
        super(
          controller: scrollController,
        );

  final PagingController<PageKeyType, ItemType> pagingController;

  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  final IndexedWidgetBuilder? _separatorBuilder;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool showNoItemsMessage;
  final Color messageColor;

  /// Corresponds to [SliverChildBuilderDelegate.addSemanticIndexes].
  final bool addSemanticIndexes;

  /// Corresponds to [ListView.itemExtent].
  final double? itemExtent;

  /// Corresponds to [PagedSliverList.shrinkWrapFirstPageIndicators].
  final bool _shrinkWrapFirstPageIndicators;

  @override
  Widget buildChildLayout(BuildContext context) {
    final separatorBuilder = _separatorBuilder;
    return separatorBuilder != null
        ? PagedSliverList<PageKeyType, ItemType>.separated(
            builderDelegate: builderDelegate,
            pagingController: pagingController,
            separatorBuilder: separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
            isMessageShow: showNoItemsMessage,
            textColor: messageColor,
          )
        : PagedSliverList<PageKeyType, ItemType>(
            builderDelegate: builderDelegate,
            pagingController: pagingController,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
            shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
            textColor: messageColor,
            isMessageShow: showNoItemsMessage,
          );
  }
}
