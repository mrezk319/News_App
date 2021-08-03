import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/search/search.dart';
import 'cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
            title: Text(NewsCubit.get(context)
                .titleNames[NewsCubit.get(context).currentIndex]),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => searchScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4),
                onPressed: () {
                  NewsCubit.get(context).changeMode();
                },
              ),
            ]),
        body:
            NewsCubit.get(context).pages[NewsCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: NewsCubit.get(context).currentIndex,
          items: NewsCubit.get(context).bottomNav,
          onTap: (index) {
            NewsCubit.get(context).changeIndex(index);
          },
        ),
      ),
      listener: (context, state) {},
    );
  }
}
