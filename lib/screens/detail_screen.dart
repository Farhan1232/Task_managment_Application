




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String description;

  DetailScreen({
    required this.title,
    required this.description,
  });

  void _markAsCompleted(BuildContext context) {
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,backgroundColor: Colors.amberAccent,
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Image.network(
                'https://media.istockphoto.com/id/1450388655/photo/planning-project-management-and-marketing-with-business-people-in-meeting-for-research.jpg?s=1024x1024&w=is&k=20&c=2omDnjr7_v527ajmAEo1x42rykF5B81v7nCav3t_WYA=',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            
          ],
        ),
      ),
    );
  }
}
