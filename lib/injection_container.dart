import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Graphql
  sl.registerSingleton<HttpLink>(HttpLink(
    Platform.isAndroid
        ? 'http://10.0.2.2:5001/graphql'
        : 'http://localhost:5001/graphql',
  ));

  sl.registerSingleton<ValueNotifier<GraphQLClient>>(
    ValueNotifier(
      GraphQLClient(
        link: sl<HttpLink>(),
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    ),
  );
}
