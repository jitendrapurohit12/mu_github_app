import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mu_github_app/models/repo.dart';

class ApiServices {
  Dio _dio = Dio();

  final baseUrl = 'https://api.github.com';

  String getUserUrl(String username) => '$baseUrl/users/$username';

  String getUserRepos(String username) => '${getUserUrl(username)}/repos';

  String getRepoCommits(String username, String projectName) =>
      '$baseUrl/repos/$username/$projectName/commits';

  Future<List<Repo>> getReposForUser(String username) async {
    List<Repo> repoList = List();
    Response repoResponse;
    Response userResponse =
        await _dio.get(getUserUrl(username));
    if (userResponse?.data != null) {
      repoResponse = await _dio.get(getUserRepos(username));

      if (repoResponse != null) {
        List<dynamic> mapList = repoResponse.data;

        mapList.forEach((map) {
          repoList.add(Repo.fromJson(map));
        });
      } else
        throw Failure(message: 'No Repo Found');
    } else
      throw Failure(message: 'No user found');

    return repoList;
  }
}

class Failure {
  String message;

  Failure({@required message});
}
