import 'package:fan2dev/utils/widgets/generic_error_widget.dart';
import 'package:fan2dev/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef ItemBuilder = Widget Function(BuildContext context, int index);

class PaginatedListView extends StatelessWidget {
  const PaginatedListView({
    required this.itemCount,
    required this.onFetchData,
    required this.itemBuilder,
    super.key,
    this.scrollController,
    this.physics,
    this.cacheExtent,
    this.isLoading = false,
    this.isError = false,
    this.hasReachedMax = false,
    this.padding,
    this.emptyBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.separatorBuilder,
    this.reverse,
  });

  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final int itemCount;
  final bool isLoading;
  final bool isError;
  final bool hasReachedMax;
  final IndexedWidgetBuilder? separatorBuilder;
  final ItemBuilder itemBuilder;

  /// Defaults to const EdgeInsets.all(20)
  final EdgeInsetsGeometry? padding;

  /// The callback method that's called whenever the list is
  /// scrolled to the end.
  ///
  /// In normal operation, this method should trigger new data to be fetched and
  /// [isLoading] to be set to `true`.
  ///
  /// Exactly when this is called depends on the [cacheExtent].
  /// Is required and cannot be `null`.
  final VoidCallback onFetchData;

  /// See [RenderViewportBase.cacheExtent]
  final double? cacheExtent;

  /// An optional builder that's shown when the list of items is empty.
  /// If `null`, nothing is shown.
  final WidgetBuilder? emptyBuilder;

  /// Defaults to [LoadingWidget].
  final WidgetBuilder? loadingBuilder;

  /// Defaults to [GenericErrorWidget].
  final WidgetBuilder? errorBuilder;
  final bool? reverse;

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return errorBuilder?.call(context) ?? GenericErrorWidget.builder(context);
    }
    return CustomScrollView(
      controller: scrollController,
      physics: physics,
      cacheExtent: cacheExtent,
      reverse: reverse ?? false,
      slivers: [
        SliverPadding(
          padding: padding ?? const EdgeInsets.all(20),
          sliver: _PaginatedSliver(
            itemCount: itemCount,
            onFetchData: onFetchData,
            itemBuilder: itemBuilder,
            isLoading: isLoading,
            hasReachedMax: hasReachedMax,
            loadingBuilder: loadingBuilder,
            separatorBuilder: separatorBuilder,
            emptyBuilder: emptyBuilder,
          ),
        ),
      ],
    );
  }
}

class _PaginatedSliver extends StatefulWidget {
  const _PaginatedSliver({
    required this.itemCount,
    required this.onFetchData,
    required this.itemBuilder,
    this.isLoading = false,
    this.hasReachedMax = false,
    this.loadingBuilder,
    this.separatorBuilder,
    this.emptyBuilder,
  });

  final int itemCount;

  final bool isLoading;

  final bool hasReachedMax;

  final VoidCallback onFetchData;

  final WidgetBuilder? emptyBuilder;

  final WidgetBuilder? loadingBuilder;

  final IndexedWidgetBuilder? separatorBuilder;

  final ItemBuilder itemBuilder;

  @override
  State<_PaginatedSliver> createState() => _PaginatedSliverState();
}

class _PaginatedSliverState extends State<_PaginatedSliver> {
  int? _lastFetchedIndex;

  @override
  void didUpdateWidget(_PaginatedSliver oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.hasReachedMax && oldWidget.hasReachedMax) {
      attemptFetch();
    }
  }

  void attemptFetch() {
    if (!widget.hasReachedMax && !widget.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onFetchData();
      });
    }
  }

  void onBuiltLast(int lastItemIndex) {
    if (_lastFetchedIndex != lastItemIndex) {
      _lastFetchedIndex = lastItemIndex;
      attemptFetch();
    }
  }

  WidgetBuilder get loadingBuilder =>
      widget.loadingBuilder ?? LoadingWidget.builder;

  @override
  Widget build(BuildContext context) {
    final hasItems = widget.itemCount != 0;

    final showEmpty = !widget.isLoading &&
        widget.itemCount == 0 &&
        widget.emptyBuilder != null;
    final showBottomWidget = showEmpty || widget.isLoading;
    final showSeparator = widget.separatorBuilder != null;
    final separatorCount = !showSeparator ? 0 : widget.itemCount - 1;

    final effectiveItemCount =
        (!hasItems ? 0 : widget.itemCount + separatorCount) +
            (showBottomWidget ? 1 : 0);
    final lastItemIndex = effectiveItemCount - 1;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: effectiveItemCount,
        (context, index) {
          if (index == lastItemIndex) {
            onBuiltLast(lastItemIndex);
          }
          if (index == lastItemIndex && showBottomWidget) {
            if (widget.isLoading) {
              return loadingBuilder(context);
            }
            return widget.emptyBuilder!(context);
          } else {
            final itemIndex = !showSeparator ? index : (index / 2).floor();
            if (showSeparator && index.isOdd) {
              return widget.separatorBuilder!(context, itemIndex);
            } else {
              return widget.itemBuilder(context, itemIndex);
            }
          }
        },
      ),
    );
  }
}
