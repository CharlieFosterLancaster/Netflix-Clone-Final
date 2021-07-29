import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/content_model.dart';

class DatabaseManager {



    //Store user info while sign up
    Future<void> storeUserInfo(String name, String email, String mobileNo) async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    users.doc(email).set({
    'uid' : uid,
    'dispName': name,
    'email': email,
    'mobileNo' : mobileNo,
    'isAdmin' : false,
    'watchList' : [],
    });


    print('User info stored');

    return ;


    }




    //Store content detail in add new content
    Future<void> storeContent(String contentName, String imgUrl,  String videoUrl, String description, String typeOfContent) async{

        DocumentReference documentReference = FirebaseFirestore.instance.collection('Content').doc();
        documentReference.set({
                'contentName' : contentName,
                'searchName' : contentName.toLowerCase(),
                'imgUrl' : imgUrl,
                'videoUrl' : videoUrl,
                'description' : description,
                'typeOfContent' : typeOfContent,
                'views' : 0,
                'id' : documentReference.id,



        });


        // CollectionReference content = FirebaseFirestore.instance.collection('Content');
        //
        // content.doc(imgUrl).set({
        //     'contentName' : contentName,
        //     'searchName' : contentName.toLowerCase(),
        //     'imgUrl' : imgUrl,
        //     'videoUrl' : videoUrl,
        //     'description' : description,
        //     'typeOfContent' : typeOfContent,
        //     'views' : 0,
        //
        // });
        //
        // print('Content info stored');


        return ;

    }


    //Update content
    Future<int> updateContent(String contentName, String id, String imgUrl,  String videoUrl, String description, String typeOfContent) async{

      try{
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('Content');
        await collectionReference.doc(id).update({
          'contentName' : contentName,
          'searchName' : contentName.toLowerCase(),
          'imgUrl' : imgUrl,
          'videoUrl' : videoUrl,
          'description' : description,
          'typeOfContent' : typeOfContent,


        });
        return 0;

      }catch(e){
        print(e);
        return 1;
      }

    }

    //Increase view
    Future<int> increaseView(String id) async{

      try{
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('Content');
        await collectionReference.doc(id).update({

          'views': FieldValue.increment(1),


        });
        return 0;

      }catch(e){
        print(e);
        return 1;
      }

    }




    //search content
    getContent(String val) async {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
            'Content').where('searchName', isEqualTo: val.toLowerCase().trim()).get();


        final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
        return allData;


    }

    //delete content
    Future<int> deleteContent(String id) async{

      try{
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('Content');
        await collectionReference.doc(id).delete();
        return 0;

      }catch(e){
        print(e);
        return 1;
      }

    }


}