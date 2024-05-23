
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'favourite_provider.dart';

// class Taskprovider with ChangeNotifier {
//   bool isLoading = true;
//   List items = [];
//   int currentPage = 1;
//   bool isFetchingMore = false;
//   bool hasMoreData = true;

//   late final FavoriteProvider _favoriteProvider;

//   Taskprovider(FavoriteProvider favoriteProvider) {
//     _favoriteProvider = favoriteProvider;
//     loadTodos(); // Load todos when the provider is initialized
//     fetchTodo();
//   }

//   void addNewItem(Map<String, dynamic> newItem) {
//     items.add(newItem);
//     notifyListeners();
//   }

//   Future<void> loadTodos() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final savedData = prefs.getString('todos');
//     if (savedData != null) {
//       items = jsonDecode(savedData);
//       notifyListeners();
//     }
//   }

//   Future<void> saveTodos() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('todos', jsonEncode(items));
//   }

//   Future<void> fetchTodo({
//     int page = 1,
//   }) async {
//     if (page == 1) {
//       isLoading = true;
//     } else {
//       isFetchingMore = true;
//     }
//     notifyListeners();

//     final url = 'https://api.nstack.in/v1/todos?page=$page&limit=10';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body) as Map;
//       final result = json['items'] as List;

//       if (page == 1) {
//         items = result.map((item) {
//           return {
//             ...item,
//             'start_date': item['start_date'] != null
//                 ? DateFormat('yyyy-MM-dd')
//                     .format(DateTime.parse(item['start_date']))
//                 : '',
//             'end_date': item['end_date'] != null
//                 ? DateFormat('yyyy-MM-dd')
//                     .format(DateTime.parse(item['end_date']))
//                 : '',
//           };
//         }).toList();
//       } else {
//         if (result.isEmpty) {
//           hasMoreData = false;
//         } else {
//           items.addAll(result.map((item) {
//             return {
//               ...item,
//               'start_date': item['start_date'] != null
//                   ? DateFormat('yyyy-MM-dd')
//                       .format(DateTime.parse(item['start_date']))
//                   : '',
//               'end_date': item['end_date'] != null
//                   ? DateFormat('yyyy-MM-dd')
//                       .format(DateTime.parse(item['end_date']))
//                   : '',
//             };
//           }).toList());
//         }
//       }
//     } else {
//       // handle error
//     }

//     isLoading = false;
//     isFetchingMore = false;
//     currentPage = page;
//     saveTodos(); // Save todos after fetching
//     notifyListeners();
//   }

//   Future<void> deleteById(String id) async {
//     final url = 'https://api.nstack.in/v1/todos/$id';
//     final uri = Uri.parse(url);
//     final response = await http.delete(uri);

//     if (response.statusCode == 200) {
//       items.removeWhere((element) => element['_id'] == id);
//       saveTodos();
//       notifyListeners();
//     } else {
//       // handle error
//     }
//   }

//   Future<void> addTodo(Map item) async {
//     const url = 'https://api.nstack.in/v1/todos';
//     final uri = Uri.parse(url);
//     final response = await http.post(
//       uri,
//       body: jsonEncode(item),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 201) {
//       fetchTodo();
//     } else {
//       // handle error
//     }
//   }

//   Future<void> updateTodo(String id, Map item) async {
//     final url = 'https://api.nstack.in/v1/todos/$id';
//     final uri = Uri.parse(url);
//     final response = await http.put(
//       uri,
//       body: jsonEncode(item),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       fetchTodo();
//     } else {
//       // handle error
//     }
//   }

//   // Getter for favorite items
//   List get favoriteItems {
//     return items.where((item) => _favoriteProvider.isFavorite(item['_id'])).toList();
//   }

//   void toggleFavorite(String todoId) {
//     if (_favoriteProvider.isFavorite(todoId)) {
//       _favoriteProvider.removeFavorite(todoId);
//     } else {
//       _favoriteProvider.addFavorite(todoId);
//     }
//     notifyListeners();
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'favourite_provider.dart';

class Taskprovider with ChangeNotifier {
  bool isLoading = true;
  List items = [];
  int currentPage = 1;
  bool isFetchingMore = false;
  bool hasMoreData = true;

  late final FavoriteProvider _favoriteProvider;

  Taskprovider(FavoriteProvider favoriteProvider) {
    _favoriteProvider = favoriteProvider;
    loadTodos(); // Load todos when the provider is initialized
    fetchTodo();
  }

  void addNewItem(Map<String, dynamic> newItem) {
    items.add(newItem);
    notifyListeners();
  }

  Future<void> loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('todos');
    if (savedData != null) {
      items = jsonDecode(savedData);
      notifyListeners();
    }
  }

  Future<void> saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', jsonEncode(items));
  }

  Future<void> fetchTodo({
    int page = 1,
  }) async {
    if (page == 1) {
      isLoading = true;
    } else {
      isFetchingMore = true;
    }
    notifyListeners();

    final url = 'https://api.nstack.in/v1/todos?page=$page&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;

      if (page == 1) {
        items = result;
      } else {
        if (result.isEmpty) {
          hasMoreData = false;
        } else {
          items.addAll(result);
        }
      }
    } else {
      // handle error
    }

    isLoading = false;
    isFetchingMore = false;
    currentPage = page;
    saveTodos(); // Save todos after fetching
    notifyListeners();
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      items.removeWhere((element) => element['_id'] == id);
      saveTodos();
      notifyListeners();
    } else {
      // handle error
    }
  }

  Future<void> addTodo(Map item) async {
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(item),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      fetchTodo();
    } else {
      // handle error
    }
  }

  Future<void> updateTodo(String id, Map item) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(item),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      fetchTodo();
    } else {
      // handle error
    }
  }

  // Getter for favorite items
  List get favoriteItems {
    return items.where((item) => _favoriteProvider.isFavorite(item['_id'])).toList();
  }

  void toggleFavorite(String todoId) {
    if (_favoriteProvider.isFavorite(todoId)) {
      _favoriteProvider.removeFavorite(todoId);
    } else {
      _favoriteProvider.addFavorite(todoId);
    }
    notifyListeners();
  }
}
