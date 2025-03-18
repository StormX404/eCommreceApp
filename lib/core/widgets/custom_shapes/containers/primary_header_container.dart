import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edge_widget.dart';
import 'circular_container.dart';

class APrimaryHeaderContainer extends StatelessWidget {
  const APrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ACurvedEdgesWidget(
      child: Container(
        color: AColors.primary,
        child: Stack(
          children: [
            // Background Custom Shapes
            Positioned(top: -150, right: -250, child: ACircularContainer(backgroundColor: AColors.textWhite.withOpacity(0.1))),
            Positioned(top: 100, right: -300, child: ACircularContainer(backgroundColor: AColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
