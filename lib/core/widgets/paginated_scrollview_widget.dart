import 'package:flutter/material.dart';

class PaginatedScrollViewWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;
  final double loadMoreThreshold;

  const PaginatedScrollViewWidget({
    super.key,
    required this.child,
    required this.onLoadMore,
    this.isLoadingMore = false,
    this.loadMoreThreshold = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    bool hasTriggeredLoadMore = false;

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - loadMoreThreshold &&
            !isLoadingMore &&
            !hasTriggeredLoadMore) {
          hasTriggeredLoadMore = true;
          onLoadMore();

          Future.delayed(const Duration(milliseconds: 500), () {
            hasTriggeredLoadMore = false;
          });
        }
        return false;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: child),
          if (isLoadingMore)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
