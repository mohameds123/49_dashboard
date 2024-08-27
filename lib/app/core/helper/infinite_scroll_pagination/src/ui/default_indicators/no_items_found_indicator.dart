import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'first_page_exception_indicator.dart';

class NoItemsFoundIndicator extends StatelessWidget {
  final Color textColor;
  final bool isMessageShow;

  const NoItemsFoundIndicator({
    super.key,
    required this.isMessageShow,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) => isMessageShow
      ? FirstPageExceptionIndicator(
          title: 'No items Found',
          message: 'The list is currently empty.',
          textColor: textColor,
        )
      : const SizedBox();
}
