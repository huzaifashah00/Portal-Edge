import 'package:uol_teacher_admin/data/models/userDetails.dart';
import 'package:uol_teacher_admin/utils/api.dart';

class UserDetailsRepository {
  Future<({Map<String, String> enabledModules, List<String> permissions})>
      getPermissionAndAllowedModules() async {
    try {
      final result = await Api.get(url: Api.getStaffPermissionAndFeatures);

      return (
        enabledModules:
            Map<String, String>.from(result['data']['features'] ?? {}),
        permissions: ((result['data']['permissions'] ?? []) as List)
            .map((e) => e.toString())
            .toList()
      );
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<({List<UserDetails> users, int currentPage, int totalPage})>
      searchUsers({int? page, required String search}) async {
    try {
      final result = await Api.get(
          url: Api.searchUsers,
          queryParameters: {"page": page ?? 1, "search": search});
      return (
        users: ((result['data']['data'] ?? []) as List)
            .map((user) => UserDetails.fromJson(Map.from(user ?? {})))
            .toList(),
        currentPage: (result['data']['current_page'] as int),
        totalPage: (result['data']['last_page'] as int),
      );
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
