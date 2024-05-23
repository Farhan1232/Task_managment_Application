



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/provider/task_list_provider.dart';

import '../provider/favourite_provider.dart';
import 'addpage.dart';
import 'colors.dart';
import 'detail_screen.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<Taskprovider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.amberAccent,
        title: const Center(
          child: Text(
            'Task List',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              shadows: [Shadow(color: Colors.transparent)],
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Visibility(
        visible: todoProvider.isLoading,
        replacement: RefreshIndicator(
          onRefresh: () => todoProvider.fetchTodo(page: 1),
          color: Colors.black,
          child: Visibility(
            visible: todoProvider.items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Task ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (!todoProvider.isFetchingMore &&
                    todoProvider.hasMoreData &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  todoProvider.fetchTodo(
                      page: todoProvider.currentPage + 1);
                  return true;
                }
                return false;
              },
              child: ListView.builder(
                itemCount: todoProvider.items.length + 1,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  if (index == todoProvider.items.length) {
                    return Visibility(
                      visible: todoProvider.isFetchingMore,
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  final item = todoProvider.items[index] as Map;
                  final id = item['_id'] as String;
                  final isFavorite = favoriteProvider.isFavorite(id);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            title: item['title'],
                            description: item['description'],
                            
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.amberAccent,
                      
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColor.brownColor,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        textColor: Colors.black,
                        title: Text(
                          item['title'],
                          style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        // subtitle: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       item['description'],
                        //       style: const TextStyle(color: Colors.black45),
                        //     ),
                        //     const SizedBox(height: 5),
                        //     // Text(
                        //     //   'Start Date: ${item['start_date']}',
                        //     //   style: const TextStyle(color: Colors.black54),
                        //     // ),
                        //     // Text(
                        //     //   'End Date: ${item['end_date']}',
                        //     //   style: const TextStyle(color: Colors.black54),
                        //     // ),
                        //   ],
                        // ),


subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item['description'],
          style: const TextStyle(color: Colors.black45),
        ),
         SizedBox(height: 5.h),
      
        
      ],
    ),


                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer<FavoriteProvider>(
                              builder: (context, favoriteProvider, child) {
                                return IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    if (isFavorite) {
                                      favoriteProvider.removeFavorite(id);
                                    } else {
                                      favoriteProvider.addFavorite(id);
                                    }
                                  },
                                );
                              },
                            ),
                            PopupMenuButton(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  // Open edit page
                                  navigateToEditPage(context, item);
                                } else if (value == 'delete') {
                                  // Open delete page
                                  todoProvider.deleteById(id);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigateToAddPage(context),
        label: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amberAccent,
        elevation: 1,
      ),
    );
  }

  Future<void> navigateToEditPage(BuildContext context, Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(todo: item),
    );
    await Navigator.push(context, route);
  }

  Future<void> navigateToAddPage(BuildContext context) async {
    final route = MaterialPageRoute(
      builder: (context) => const AddPage(),
    );
    await Navigator.push(context, route);
  }
}





