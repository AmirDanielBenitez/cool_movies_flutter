import 'package:coolmovies/features/coolmovies/data/models/user/user_model.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserApiProvider {
  Future<User> fetchCurrentUser() async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(
              QueryOptions(
                document: gql(r'''
              query {
          currentUser {
            id
            name
          }
        }
    '''),
              ),
            );

    if (result.hasException) {
      throw result.exception.toString();
    }

    if (result.data != null) {
      return User.fromJson(result.data!["currentUser"]);
    }
    throw 'User not available';
  }

  Future<User> signUpUser(SignupData signupData) async {
    final QueryResult result =
        await sl<ValueNotifier<GraphQLClient>>().value.query(
              QueryOptions(
                document: gql('''
                    mutation {
          createUser(input: {user: {name: "${signupData.name}"}}) {
            user {
              id
              name
            }
          }
        }
    '''),
              ),
            );

    if (result.hasException) {
      throw result.exception.toString();
    }

    if (result.data != null) {
      return User.fromJson(result.data!["createUser"]["user"]);
    }
    throw 'User not available';
  }
}
