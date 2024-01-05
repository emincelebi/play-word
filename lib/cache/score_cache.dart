// import 'dart:convert';


// class UserCacheManager {
//   final SharedManager sharedManager;

//   UserCacheManager(this.sharedManager);

//   Future<void> saveScore(String score) async {
    
//     sharedManager.saveString()
//   }

//   List<User>? getItems() {
//     //Compute
//     final itemsString = sharedManager.getStrings(SharedKeys.users);
//     if (itemsString?.isNotEmpty ?? false) {
//       return itemsString!.map((e) {
//         final json = jsonDecode(e);
//         if (json is Map<String, dynamic>) {
//           return User.fromJson(json);
//         }
//         return User('name', 'description', 'url');
//       }).toList();
//     }
//     return null;
//   }
// }

// mixin SharedManager {
// }
