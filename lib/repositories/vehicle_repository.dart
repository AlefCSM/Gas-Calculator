import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gas_calculator/models/vehicle_model.dart';

class VehicleRepository {
  CollectionReference vehiclesReference;

  static const USERS_COLLECTION = "users";
  static const VEHICLES_COLLECTION = "vehicles";

  void setReference(String userId) {
    if (vehiclesReference == null) {
      vehiclesReference = FirebaseFirestore.instance
          .collection(USERS_COLLECTION)
          .doc(userId)
          .collection(VEHICLES_COLLECTION);
    }
  }

  Future<List<Vehicle>> getFirebaseVehicles({@required String userId}) async {
    List<Vehicle> list = [];

    setReference(userId);

    QuerySnapshot snapshot = await vehiclesReference.get();

    snapshot.docs.forEach((firebaseVehicle) {
      var json = firebaseVehicle.data() as Map<String, dynamic>;
      var vehicle = Vehicle.fromJson(json, sync: true);
      vehicle.firebaseId = firebaseVehicle.id;
      list.add(vehicle);
    });

    return list;
  }

  Future<String> saveFirebaseVahicle(
      {@required String userId, @required Vehicle vehicle}) async {
    setReference(userId);

    var document = await vehiclesReference.add(vehicle.toJson(firebase: true));

    return document.id;
  }

  Future<void> updateFirebaseVahicle(
      {@required String userId, @required Vehicle vehicle}) async {
    setReference(userId);

    await vehiclesReference
        .doc(vehicle.firebaseId)
        .update(vehicle.toJson(firebase: true));
  }

  Future<void> deleteFirebaseVehicle(
      {@required String userId, @required Vehicle vehicle}) async {
    setReference(userId);

    await vehiclesReference.doc(vehicle.firebaseId).delete();
  }
}
