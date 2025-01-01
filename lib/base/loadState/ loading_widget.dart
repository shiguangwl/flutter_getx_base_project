import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool? hidden;

  const LoadingWidget({super.key, this.hidden});

  @override
  Widget build(BuildContext context) {
    if (hidden == true) {
      return Container();
    } else {
      return const Center(
        child: CupertinoActivityIndicator(
          radius: 14,
          color: Colors.black38,
        ),
      );
    }
  }
}
