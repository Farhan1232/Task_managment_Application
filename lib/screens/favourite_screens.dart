

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/provider/task_list_provider.dart';

import 'colors.dart';


class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<Taskprovider>(context);
    return Scaffold(backgroundColor: Colors.white70,
      appBar: AppBar(centerTitle: true,
        title: Text('Favorites Task'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(10.r),
        child: ListView.builder(
          itemCount: todoProvider.favoriteItems.length,
          itemBuilder: (context, index) {
            final item = todoProvider.favoriteItems[index];
            return Card(
        
              color: Colors.amberAccent,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
              child: ListTile(
                leading: CircleAvatar(
                          backgroundColor: AppColor.brownColor,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                
                title: Text(item['title']),
                //subtitle: Text(item['description']),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    todoProvider.toggleFavorite(item['_id']);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




