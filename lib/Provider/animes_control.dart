import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class AnimesControl with ChangeNotifier{

  Response response;

  Dio _dio = new Dio();

  var nomes="";


   getAllAnimes() async {
    response = await _dio.get('https://otaku-list.herokuapp.com/animes');

    return response.data;
  }

  getDailyAnimes() async {
    response = await _dio.get('https://otaku-list.herokuapp.com/search/day');

    return response.data;
  }


  getSeasonAnimes() async {
    response = await _dio.get('https://otaku-list.herokuapp.com/search/season');

    return response.data;
  }

  // Future getDailyAnimesNotifications() async {
  //   await _dio.get('https://otaku-list.herokuapp.com/search/day').then(
  //     (response)=>{
  //       List animesdaily = response.data


  //     }
  //   );

  // }

}