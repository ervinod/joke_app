import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_app/core/utils/util.dart';
import 'package:joke_app/features/joke/presentation/widgets/shimmer_container.dart';

class JokeListLoader extends StatelessWidget {
  const JokeListLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ShimmerContainer(
          width: Utils.getScreenWidth(context),
          height: 120,
          borderRadius: BorderRadius.circular(10.r),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 14.h);
      },
      itemCount: 10,
    );
  }
}
