import 'package:flutter/material.dart';

import 'first_page_exception_indicator.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    required this.textColor,
    super.key,
  });

  final VoidCallback? onTryAgain;

  final Color textColor;

  @override
  Widget build(BuildContext context) => FirstPageExceptionIndicator(
        title: 'No Internet Connection',
        onTryAgain: onTryAgain,
        textColor: textColor,
      );
}
