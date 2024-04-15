import 'dart:io';

import 'package:coolmovies/core/constants/constants.dart';
import 'package:coolmovies/features/coolmovies/data/data_sources/remote/movies_api_provider.dart';
import 'package:coolmovies/features/coolmovies/data/data_sources/remote/reviews_api_provider.dart';
import 'package:coolmovies/features/coolmovies/data/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Graphql
  sl.registerSingleton<HttpLink>(HttpLink(
    Platform.isAndroid ? urlAndroid : urlIos,
  ));

  sl.registerSingleton<ValueNotifier<GraphQLClient>>(
    ValueNotifier(
      GraphQLClient(
        link: sl<HttpLink>(),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    ),
  );

  // Providers
  sl.registerSingleton<MoviesApiProvider>(MoviesApiProvider());
  sl.registerSingleton<ReviewsApiProvider>(ReviewsApiProvider());

  // Repository
  sl.registerSingleton<Repository>(Repository(sl(), sl()));
}
