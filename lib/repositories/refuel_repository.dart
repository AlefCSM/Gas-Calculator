import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gas_calculator/models/refuel_model.dart';

class RefuelRepository {
  CollectionReference vehiclesReference;

  static const USERS_COLLECTION = "users";
  static const VEHICLES_COLLECTION = "vehicles";
  static const REFUELS_COLLECTION = "refuels";

  void setReference(String userId) {
    if (vehiclesReference == null) {
      vehiclesReference = FirebaseFirestore.instance
          .collection(USERS_COLLECTION)
          .doc(userId)
          .collection(VEHICLES_COLLECTION);
    }
  }

  Future<List<Refuel>> getFirebaseRefuels(
      {@required String userId, @required String vehicleFirebaseId}) async {
    List<Refuel> list = [];

    setReference(userId);

    QuerySnapshot snapshot =
        await vehiclesReference.doc(vehicleFirebaseId).collection(REFUELS_COLLECTION).get();

    snapshot.docs.forEach((firebaseRefuel) {
      var json = firebaseRefuel.data() as Map<String, dynamic>;
      var refuel = Refuel.fromJson(json, sync: true);
      refuel.firebaseId = firebaseRefuel.id;
      list.add(refuel);
    });

    return list;
  }

  Future<String> saveFirebaseRefuel(
      {@required String userId,
      @required String vehicleFirebaseId,
      @required Refuel refuel}) async {
    setReference(userId);

    var document = await vehiclesReference
        .doc(vehicleFirebaseId)
        .collection(REFUELS_COLLECTION)
        .add(refuel.toJson(sync: true));

    return document.id;
  }

  Future<void> updateFirebaseRefuel(
      {@required String userId,
      @required String vehicleFirebaseId,
      @required Refuel refuel}) async {
    setReference(userId);

    await vehiclesReference
        .doc(vehicleFirebaseId)
        .collection(REFUELS_COLLECTION)
        .doc(refuel.firebaseId)
        .update(refuel.toJson(sync: true));
  }

  Future<void> deleteFirebaseRefuel(
      {@required String userId,
      @required String vehicleFirebaseId,
      @required Refuel refuel}) async {
    setReference(userId);
    await vehiclesReference
        .doc(vehicleFirebaseId)
        .collection(REFUELS_COLLECTION)
        .doc(refuel.firebaseId)
        .delete();
  }
}
