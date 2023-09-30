import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_app/core/constants/image_constants.dart';
import 'package:joke_app/core/constants/string_constants.dart';
import 'package:joke_app/core/constants/style_constants.dart';
import 'package:joke_app/core/constants/value_constants.dart';
import 'package:joke_app/features/joke/presentation/blocs/joke_bloc.dart';
import 'package:lottie/lottie.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.JOKE.toUpperCase(),
            style: StyleConstants.s35_w500_000000,
          ),
          BlocBuilder<JokeBloc, GetJokeState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.status == ApiStatus.loading)
                    SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: Lottie.asset(
                        ImageConstants.LOADER,
                        fit: BoxFit.cover,
                        width: 30.w,
                        height: 30.w,
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    state.status == ApiStatus.loading
                        ? StringConstants.JOKES
                        : '${state.jokes.length} ${state.jokes.length > 1 ? StringConstants.JOKES : StringConstants.JOKE}',
                    style: StyleConstants.s20_w400_D50000,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
