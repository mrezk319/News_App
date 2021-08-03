import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var searchList = NewsCubit.get(context).search;
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                  },
                  onSaved: (value){
                    print(value);
                  },
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              Expanded(child: Builder_item(searchList)),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
