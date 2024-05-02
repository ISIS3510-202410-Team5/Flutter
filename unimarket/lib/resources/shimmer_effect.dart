import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unimarket/theme.dart';

class ShimmerWidget extends StatelessWidget {
  
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    this.width = 20,
    required this.height
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Provider.of<ThemeNotifier>(context).getTheme().cardColor, 
      highlightColor: Colors.grey[600]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: shapeBorder,
        ),
        child: const Text("Holasi"),
      ), 
    );
  }
}