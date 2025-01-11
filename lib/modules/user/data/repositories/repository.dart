import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';

abstract class Repository {
  Future<UserModel> getUser({required String user});
  Future<List<RepoModel>> getRepos({required String url});
}
