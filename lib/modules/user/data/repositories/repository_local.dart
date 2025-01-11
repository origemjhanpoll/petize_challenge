// import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
// import 'package:petize_challenge/modules/user/data/services/local/local_client_service.dart';
// import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';
// import 'package:petize_challenge/modules/user/domain/models/user_model.dart';

// class RepositoryLocal implements Repository {
//   RepositoryLocal({
//     required LocalClientService localClientService,
//   }) : _localClientService = localClientService;

//   final LocalClientService _localClientService;

//   @override
//   Future<UserModel> getUser({required String user}) async {
//     try {
//       final UserModel? userModel = await _localClientService.loadUser();
//       if (userModel != null) {
//         return userModel;
//       } else {
//         throw Exception("User not found");
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   Future<List<RepoModel>> getRepos({required String url}) async {
//     try {
//       final List<RepoModel>? repoModel = await _localClientService.loadRepos();
//       if (repoModel != null) {
//         return repoModel;
//       } else {
//         throw Exception("Repo not found");
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
