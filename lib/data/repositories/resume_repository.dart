import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resume_model.dart';

class ResumeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ResumeModel> fetchResume() async {
    var doc = await _firestore.collection('resume').doc('LjbzZQsRSRQXjM68qtdU').get();
    return ResumeModel.fromJson(doc.data()!);
  }
}
