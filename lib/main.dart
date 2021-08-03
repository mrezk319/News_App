
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/Network/local/shared_helper.dart';
import 'package:news_app/shared/Network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'layout/home_layout.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedHelper.init();
  bool? formShared = SharedHelper.getBoolean(key: 'isDark');
  bool? x = formShared;
  runApp(MyApp(x));
}

class MyApp extends StatelessWidget {
  final bool? formShared;
  MyApp(this.formShared);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()..getBusiess()..changeMode(fromshared: formShared,),),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                primarySwatch: Colors.deepOrange,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrangeAccent,
                  backgroundColor: Colors.white,
                ),
                appBarTheme: AppBarTheme(
                    actionsIconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    elevation: 0,
                    backgroundColor: Colors.white,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                    ),
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black)
                ),
                scaffoldBackgroundColor: Colors.white,
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrangeAccent,
                  backgroundColor: HexColor('#3d3d3d'),
                  unselectedItemColor: Colors.white70,
                ),

                appBarTheme: AppBarTheme(
                    actionsIconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    elevation: 0,
                    backgroundColor: HexColor('#3d3d3d'),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('#3d3d3d'),
                      statusBarIconBrightness: Brightness.light,
                    ),
                    titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)
                ),
                scaffoldBackgroundColor: HexColor('#3d3d3d'),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
              home: NewsLayout(),
            );
          },
          listener: (context, state) {},
      ),
    );
  }

}