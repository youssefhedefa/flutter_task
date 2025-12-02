import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgBuilder extends StatelessWidget {
  const CustomSvgBuilder({
    super.key,
    required this.path,
    this.color,
    this.width,
    this.height,
    this.fit,
  });

  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    const aspect = 24.0;
    return SizedBox(
      width: width ?? aspect,
      height: height ?? aspect,
      child: SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.cover,
        width: width ?? aspect,
        height: height ?? aspect,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
