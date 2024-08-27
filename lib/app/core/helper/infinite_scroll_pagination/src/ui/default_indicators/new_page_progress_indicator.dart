import 'package:flutter/material.dart';

import 'footer_tile.dart';

class NewPageProgressIndicator extends StatelessWidget {
  const NewPageProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const FooterTile(
        child: CircularProgressIndicator.adaptive(),
      );
}
