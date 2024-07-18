import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/data/user/models/journal_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JournalService {
  final AuthServices _authServices = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new Journal for a specific user
  Future<void> addJournal(JournalModel journal) async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentReference userDoc =
          _firestore.collection('journals').doc(user!.uid);
      DocumentSnapshot userSnapshot = await userDoc.get();

      if (userSnapshot.exists) {
        // If the user document exists, update the Journals array
        await userDoc.update({
          'journals': FieldValue.arrayUnion([journal.toJson()])
        });
      } else {
        // If the user document does not exist, create it with the first Journal
        await userDoc.set({
          'journals': [journal.toJson()]
        });
      }
    } catch (e) {
      showToast("Error adding Journal: $e");
    }
  }

  // Fetch all Journals for a specific user
  Future<List<JournalModel>> fetchJournals() async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentSnapshot userSnapshot =
          await _firestore.collection('journals').doc(user!.uid).get();
      if (userSnapshot.exists) {
        List<dynamic> journalsData = userSnapshot.get('journals');
        return journalsData
            .map((journalData) =>
                JournalModel.fromJson(journalData as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      showToast("Error fetching Journals: $e");
      return [];
    }
  }

  // Update the entire list of Journals for a specific user
  Future<void> updateJournals(List<JournalModel> updatedJournals) async {
    try {
      User? user = await _authServices.getCurrentUser();
      DocumentReference userDoc =
          _firestore.collection('journals').doc(user!.uid);
      List<Map<String, dynamic>> updatedJournalsData =
          updatedJournals.map((journal) => journal.toJson()).toList();
      await userDoc.update({'journals': updatedJournalsData});
    } catch (e) {
      showToast("Error updating Journals: $e");
    }
  }
}
