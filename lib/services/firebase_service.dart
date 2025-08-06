import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication methods
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Storage methods
  Future<String?> uploadImage(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  // Firestore methods
  Future<void> addTeamMember(Map<String, dynamic> member) async {
    await _firestore.collection('team_members').add(member);
  }

  Future<void> updateTeamMember(String id, Map<String, dynamic> data) async {
    await _firestore.collection('team_members').doc(id).update(data);
  }

  Future<void> deleteTeamMember(String id) async {
    await _firestore.collection('team_members').doc(id).delete();
  }

  Stream<QuerySnapshot> getTeamMembers() {
    return _firestore.collection('team_members').snapshots();
  }

  Future<void> addEvent(Map<String, dynamic> event) async {
    await _firestore.collection('events').add(event);
  }

  Future<void> updateEvent(String id, Map<String, dynamic> data) async {
    await _firestore.collection('events').doc(id).update(data);
  }

  Future<void> deleteEvent(String id) async {
    await _firestore.collection('events').doc(id).delete();
  }

  Stream<QuerySnapshot> getEvents() {
    return _firestore.collection('events').snapshots();
  }

  Future<void> addYouTubeLink(Map<String, dynamic> video) async {
    await _firestore.collection('youtube_videos').add(video);
  }

  Future<void> updateYouTubeLink(String id, Map<String, dynamic> data) async {
    await _firestore.collection('youtube_videos').doc(id).update(data);
  }

  Future<void> deleteYouTubeLink(String id) async {
    await _firestore.collection('youtube_videos').doc(id).delete();
  }

  Stream<QuerySnapshot> getYouTubeVideos() {
    return _firestore.collection('youtube_videos').snapshots();
  }

  Future<void> addGalleryImage(Map<String, dynamic> image) async {
    await _firestore.collection('gallery').add(image);
  }

  Future<void> deleteGalleryImage(String id) async {
    await _firestore.collection('gallery').doc(id).delete();
  }

  Stream<QuerySnapshot> getGalleryImages() {
    return _firestore.collection('gallery').snapshots();
  }
} 