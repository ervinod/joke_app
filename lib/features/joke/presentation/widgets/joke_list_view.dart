import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:joke_app/core/constants/string_constants.dart';
import 'package:joke_app/core/constants/style_constants.dart';
import 'package:joke_app/core/constants/value_constants.dart';
import 'package:joke_app/features/joke/presentation/blocs/joke_bloc.dart';
import 'package:joke_app/features/joke/presentation/widgets/error_widget.dart';
import 'package:joke_app/features/joke/presentation/widgets/joke_item.dart';
import 'package:joke_app/features/joke/presentation/widgets/joke_list_loader.dart';
import 'package:joke_app/injection_container.dart';

import '../../data/models/joke_model.dart';

class JokeListView extends StatefulWidget {
  const JokeListView({Key? key}) : super(key: key);

  @override
  State<JokeListView> createState() => _JokeListViewState();
}

class _JokeListViewState extends State<JokeListView> {
  List<Joke> jokes = [];
  late JokeBloc jokeBloc;
  bool isInitial = true;
  late ScrollController scrollController;

  @override
  void initState() {
    jokeBloc = sl<JokeBloc>();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JokeBloc, JokeState>(
      bloc: jokeBloc,
      listener: (context, state) {
        if (state is GetJokeState && state.status == ApiStatus.loaded) {
          if (isInitial) {
            isInitial = false;
          }
          jokes = state.jokes;
          scrollToBottom();
        }
      },
      child: BlocBuilder<JokeBloc, JokeState>(
        bloc: jokeBloc,
        builder: (context, state) {
          if (state is GetJokeState &&
              state.status == ApiStatus.loading &&
              isInitial) {
            return const JokeListLoader();
          }

          if (state is GetJokeState && state.status == ApiStatus.error) {
            return RetryWidget(
              onRetry: () {
                isInitial = true;
                jokeBloc.add(const GetJokeEvent());
              },
              errorText: state.error,
            );
          }
          return jokes.isNotEmpty
              ? ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: jokes.length,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  controller: scrollController,
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Divider(color: Colors.grey),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return JokeItem(
                      key: Key("jokeItem$index"),
                      item: jokes[index],
                      index: index + 1,
                    );
                  },
                )
              : Center(
                  child: Text(
                    StringConstants.NO_DATA_FOUND,
                    style: StyleConstants.s18_w400_000000,
                  ),
                );
        },
      ),
    );
  }

  void scrollToBottom() {
    /// scroll to last joke
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (scrollController.hasClients &&
            scrollController.offset <
                scrollController.position.maxScrollExtent) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }
}
