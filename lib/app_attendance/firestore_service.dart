import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference attendanceCollection = FirebaseFirestore.instance.collection('attendance');

  Future<void> markAttendance(String userId, bool present) async {
    await attendanceCollection.doc(userId).set({
      'present': present,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getAttendanceRecords() {
    return attendanceCollection.snapshots();
  }

  Stream<QuerySnapshot> getFilteredAttendanceRecords(bool present) {
    return attendanceCollection.where('present', isEqualTo: present).snapshots();
  }
}