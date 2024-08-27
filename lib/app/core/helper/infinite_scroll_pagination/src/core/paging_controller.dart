import 'package:flutter/foundation.dart';
import '../model/paging_state.dart';
import '../model/paging_status.dart';

typedef PageRequestListener<PageKeyType> = void Function(
  PageKeyType pageKey,
);

typedef PagingStatusListener = void Function(
  PagingStatus status,
);

class PagingController<PageKeyType, ItemType>
    extends ValueNotifier<PagingState<PageKeyType, ItemType>> {
  PagingController({
    required this.firstPageKey,
    this.invisibleItemsThreshold,
  }) : super(
          PagingState<PageKeyType, ItemType>(nextPageKey: firstPageKey),
        );

  PagingController.fromValue(
    super.value, {
    required this.firstPageKey,
    this.invisibleItemsThreshold,
  });

  ObserverList<PagingStatusListener>? _statusListeners =
      ObserverList<PagingStatusListener>();

  ObserverList<PageRequestListener<PageKeyType>>? _pageRequestListeners =
      ObserverList<PageRequestListener<PageKeyType>>();

  /// The number of remaining invisible items that should trigger a new fetch.
  final int? invisibleItemsThreshold;

  /// The key for the first page to be fetched.
  final PageKeyType firstPageKey;

  /// List with all items loaded so far. Initially `null`.
  List<ItemType> get itemList => value.itemList ?? [];

  set itemList(List<ItemType> newItemList) {
    value = PagingState<PageKeyType, ItemType>(
      error: error,
      itemList: newItemList,
      nextPageKey: nextPageKey,
    );
  }

  void addItem(ItemType item) {
    if (!itemList.contains(item)) {
      itemList.add(item);
      refreshItems();
    }
  }

  void insertItem(int index, ItemType item) {
    if (!itemList.contains(item)) {
      itemList.insert(index, item);
      refreshItems();
    }
  }

  void refreshItems() => value = PagingState<PageKeyType, ItemType>(
        error: error,
        itemList: List.of(itemList),
        nextPageKey: nextPageKey,
      );

  void removeItem(ItemType item) {
    if (itemList.remove(item)) {
      value = PagingState<PageKeyType, ItemType>(
        error: error,
        itemList: List.of(itemList),
        nextPageKey: nextPageKey,
      );
    }
  }

  /// The current error, if any. Initially `null`.
  dynamic get error => value.error;

  set error(dynamic newError) {
    value = PagingState<PageKeyType, ItemType>(
      error: newError,
      itemList: itemList,
      nextPageKey: nextPageKey,
    );
  }

  /// The key for the next page to be fetched.
  ///
  /// Initialized with the same value as [firstPageKey], received in the
  /// constructor.
  PageKeyType? get nextPageKey => value.nextPageKey;

  set nextPageKey(PageKeyType? newNextPageKey) {
    value = PagingState<PageKeyType, ItemType>(
      error: error,
      itemList: itemList,
      nextPageKey: newNextPageKey,
    );
  }

  /// Corresponding to [ValueNotifier.value].
  @override
  set value(PagingState<PageKeyType, ItemType> newValue) {
    if (value.status != newValue.status) {
      notifyStatusListeners(newValue.status);
    }

    super.value = newValue;
  }

  void appendPage(List<ItemType> newItems, PageKeyType? nextPageKey) {
    final previousItems = value.itemList ?? [];
    final itemList = previousItems + newItems;
    value = PagingState<PageKeyType, ItemType>(
      itemList: itemList,
      nextPageKey: nextPageKey,
    );
  }

  void appendLastPage(List<ItemType> newItems) => appendPage(newItems, null);

  void retryLastFailedRequest() {
    error = null;
  }

  void refresh() {
    value = PagingState<PageKeyType, ItemType>(
      nextPageKey: firstPageKey,
    );
  }

  bool _debugAssertNotDisposed() {
    assert(
      () {
        if (_pageRequestListeners == null || _statusListeners == null) {
          throw Exception(
            'A PagingController was used after being disposed.\nOnce you have '
            'called dispose() on a PagingController, it can no longer be '
            'used.\nIf you’re using a Future, it probably completed after '
            'the disposal of the owning widget.\nMake sure dispose() has not '
            'been called yet before using the PagingController.',
          );
        }
        return true;
      }(),
    );
    return true;
  }

  void addStatusListener(PagingStatusListener listener) {
    assert(_debugAssertNotDisposed());
    _statusListeners!.add(listener);
  }

  void removeStatusListener(PagingStatusListener listener) {
    assert(_debugAssertNotDisposed());
    _statusListeners!.remove(listener);
  }

  void notifyStatusListeners(PagingStatus status) {
    assert(_debugAssertNotDisposed());

    if (_statusListeners!.isEmpty) {
      return;
    }

    final localListeners = List<PagingStatusListener>.from(_statusListeners!);
    for (final listener in localListeners) {
      if (_statusListeners!.contains(listener)) {
        listener(status);
      }
    }
  }

  void addPageRequestListener(PageRequestListener<PageKeyType> listener) {
    assert(_debugAssertNotDisposed());
    _pageRequestListeners!.add(listener);
  }

  void removePageRequestListener(PageRequestListener<PageKeyType> listener) {
    assert(_debugAssertNotDisposed());
    _pageRequestListeners!.remove(listener);
  }

  void notifyPageRequestListeners(PageKeyType pageKey) {
    assert(_debugAssertNotDisposed());

    if (_pageRequestListeners!.isEmpty) {
      return;
    }

    final localListeners =
        List<PageRequestListener<PageKeyType>>.from(_pageRequestListeners!);

    for (final listener in localListeners) {
      if (_pageRequestListeners!.contains(listener)) {
        listener(pageKey);
      }
    }
  }

  @override
  void dispose() {
    assert(_debugAssertNotDisposed());
    _statusListeners = null;
    _pageRequestListeners = null;
    super.dispose();
  }
}
