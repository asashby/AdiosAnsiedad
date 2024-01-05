
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/preference_data_model.dart';

class SharedPrefFun{

  static Future<void> setPreferenceData(List<PreferenceData> data, {bool isDayInfo = true})async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(isDayInfo ? "DAY_INFO" : "IDEAL_PROGRAM_INFO",jsonEncode(data));
  }

  static Future<List<PreferenceData>> getPreferenceData({bool isDayInfo = true})async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(isDayInfo ? "DAY_INFO" : "IDEAL_PROGRAM_INFO");
    List<PreferenceData> prefData = [];
    if(data != null){
      for (var element in (jsonDecode(data) as List)) {
        prefData.add(PreferenceData.fromJson(element));
      }
    }
    return prefData;
  }

  static Future<void> setDayPercentageData(List<int> dataPer)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("DAY_PERCENTAGE", jsonEncode(dataPer));
  }

  static Future<List<int>> getDayPercentageData()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString("DAY_PERCENTAGE");
    List<int> dataPer = [];
    if(data != null){
      for (var element in (jsonDecode(data) as List)) {
        dataPer.add(int.parse(element.toString()));
      }
    }
    return dataPer;
  }



}