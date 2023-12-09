import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_login_test/app_attendance/firestore_service.dart';

class AttendancePage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Tracker'),
      ),
      body: StreamBuilder(
        stream: firestoreService.getAttendanceRecords(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final records = snapshot.data!.docs;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index].data() as Map<String, dynamic>;
              final userId = records[index].id;
              final present = record['present'];
              final timestamp = record['timestamp'] as Timestamp?;

              return ListTile(
                title: Text('User ID: $userId - ${present ? 'Present' : 'Absent'}'),
                subtitle: Text('Timestamp: ${timestamp?.toDate()}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Mark attendance for a user
          firestoreService.markAttendance('user123', true);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}