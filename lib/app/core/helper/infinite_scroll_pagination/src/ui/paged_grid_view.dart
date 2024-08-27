import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../core/paged_child_builder_delegate.dart';
import '../core/paging_controller.dart';
import 'paged_sliver_grid.dart';

class PagedGridView<PageKeyType, ItemType> extends BoxScrollView {
  const PagedGridView({
    required this.pagingController,
    required this.builderDelegate,
    required this.gridDelegate,
    this.messageColor = Colors.black,
    this.showNoItemsMessage = true,
    ScrollController? scrollController,
    super.scrollDirection,
    super.reverse,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    super.cacheExtent,
    this.showNewPageProgressIndicatorAsGridChild = true,
    this.showNewPageErrorIndicatorAsGridChild = true,
    this.showNoMoreItemsIndicatorAsGridChild = true,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    super.key,
  })  : _shrinkWrapFirstPageIndicators = shrinkWrap,
        super(
          controller: scrollController,
        );

  final PagingController<PageKeyType, ItemType> pagingController;

  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  final SliverGridDelegate gridDelegate;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final bool addSemanticIndexes;

  final bool showNewPageProgressIndicatorAsGridChild;

  final bool showNewPageErrorIndicatorAsGridChild;

  final bool showNoMoreItemsIndicatorAsGridChild;

  final bool _shrinkWrapFirstPageIndicators;

  final Color messageColor;
  final bool showNoItemsMessage;

  @override
  Widget buildChildLayout(BuildContext context) =>
      PagedSliverGrid<PageKeyType, ItemType>(
        builderDelegate: builderDelegate,
        pagingController: pagingController,
        gridDelegate: gridDelegate,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        showNewPageProgressIndicatorAsGridChild:
            showNewPageProgressIndicatorAsGridChild,
        showNewPageErrorIndicatorAsGridChild:
            showNewPageErrorIndicatorAsGridChild,
        showNoMoreItemsIndicatorAsGridChild:
            showNoMoreItemsIndicatorAsGridChild,
        shrinkWrapFirstPageIndicators: _shrinkWrapFirstPageIndicators,
        isMessageShow: showNoItemsMessage,
        textColor: messageColor,
      );
}
