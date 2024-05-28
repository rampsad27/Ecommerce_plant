import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:plant_app/ui/modules/model/plantmodel.dart';
import 'package:plant_app/ui/modules/mycart/bloc/eventfirebase_bloc.dart';

class EventRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String _event = 'planttt';
  Future<void> addEventAndSaveUser(PlantModel plantModel) async {
    CollectionReference cr = _firebaseFirestore.collection(_event);
    plantModel = plantModel.copyWith(imageUrl: await uploadImage());
    await cr.doc(plantModel.uid).set(plantModel.toMap());
    // await saveUser(plantModel);
  }

  Future<void> saveUser(PlantModel plantModel) async {
    CollectionReference cr = _firebaseFirestore.collection(_event);
    plantModel = plantModel.copyWith(imageUrl: await uploadImage());
    await cr.doc(plantModel.name).set(plantModel.toMap());
  }

  Future<List<PlantModel>?> getEvents() async {
    List<PlantModel> events = [];
    try {
      // CollectionReference cr = _firebaseFirestore.collection(_event);
      final QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(_event)
          // .where('uid', isEqualTo: _auth.currentUser!.uid)
          // .orderBy('createAt', descending: true)
          .get();
      events = querySnapshot.docs
          .map((doc) => PlantModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return events;
    } on FirebaseException catch (e) {
      log(e.toString());
    } on Exception catch (e) {
      print("sdgdsg $e");
    }
    return events;
  }

  Future<void> deleteEvent(String uid) async {
    CollectionReference cr = _firebaseFirestore.collection(_event);
    await cr.doc(uid).delete();
  }

//storage
  Future<String> uploadImage() async {
    Reference ref = _firebaseStorage.ref(_event).child("/images");

    var res =
        await ref.putFile(await getFileFromAssets()); //4.retured and upload
    var url = await res.ref.getDownloadURL(); //ref url tanyo
    return url;
  }

  Future<File> getFileFromAssets() async {
    //chipkaide
    var tempDir = await getTemporaryDirectory();
    var file = File('${tempDir.path}/1.png'); //append in dir
    var bytes = await rootBundle.load('assets/img/1.png'); // 2.load img
    await file.writeAsBytes(//3.write gar
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}
