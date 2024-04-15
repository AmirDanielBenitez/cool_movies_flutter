import 'package:coolmovies/config/routes/routes.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/bloc/reviews_bloc/reviews_bloc.dart';
import 'package:coolmovies/features/coolmovies/presentation/pages/home/movies_home_page.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(GraphQLProvider(
    client: sl(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc()..add(LoadMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => ReviewsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MoviesHomePage(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
      ),
    );
  }
}
