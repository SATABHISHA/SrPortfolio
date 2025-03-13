import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_model.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch resume data from Firestore
  static Future<ResumeModel?> getResumeData() async {
    try {
      DocumentSnapshot doc = await _firestore.collection('resume').doc('LjbzZQsRSRQXjM68qtdU').get();
      print("🔥 Firestore Raw Document: ${doc.data()}");

      if (doc.exists) {
        return ResumeModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print("No resume data found in Firestore.");
        return null;
      }
    } catch (e) {
      print("🔥 Firestore Error: $e");
      return null;
    }
  }
}
