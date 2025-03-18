import 'package:flutter/material.dart';

import 'custom_curved_edges.dart';


class ACurvedEdgesWidget extends StatelessWidget {
  const ACurvedEdgesWidget({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ACurvedEdges(),
      child: child,
    );
  }
}
