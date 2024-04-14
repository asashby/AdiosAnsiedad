import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quantum/main.dart';

import '../Const/const_string.dart';
import '../Model/day_info_model.dart';

class FirestoreServices{
  static Map<String,Content> contentData  = {
    "A1" : Content(
        id: "A1",
        title: "ENTENDIENDO LA ANSIEDAD Y EL MIEDO",
        contentType: 1,
        path: astContentA1,
        number: 1,
        duration: 667
    ),
    "A2" : Content(
        id: "A2",
        title: "CAUSAS DE LA ANSIEDAD",
        contentType: 1,
        path: astContentA2,
        number: 2,
        duration: 755
    ),
    "V1" : Content(
        id: "V1",
        title: "COMIDAS QUE CAUSAN ANSIEDA",
        contentType: 2,
        path: astContentV1,
        number: 1,
        duration: 652
    ),
    "A3" : Content(
        id: "A3",
        title: "REPRO PARA DORMIR",
        contentType: 1,
        path: astContentA3,
        number: 3,
        duration: 3947
    ),
    "A4" : Content(
        id: "A4",
        title: "GESTIONANDO TUS PENSAMIENTOS",
        contentType: 1,
        path: astContentA4,
        number: 4,
        duration: 905
    ),
    "V2" : Content(
        id: "V2",
        title: "CONTROL DE PENSAMIENTOS",
        contentType: 2,
        path: astContentV2,
        number: 2,
        duration: 1263
    ),
    "A5" : Content(
        id: "A5",
        title: "GESTIONANDO TUS EMOCIONES",
        contentType: 1,
        path: astContentA5,
        number: 5,
        duration: 660
    ),
    "V3" : Content(
        id: "V3",
        title: "DRENAJE DE EMOCIONES Y ESTRES",
        contentType: 2,
        path: astContentV3,
        number: 3,
        duration: 503
    ),
    "V4" : Content(
        id: "V4",
        title: "EJERCICIO DE RESPIRACION",
        contentType: 2,
        path: astContentV4,
        number: 4,
        duration: 916
    ),
    "A6" : Content(
        id: "A6",
        title: "CAMBIO DE ACTITUD GUIADO",
        contentType: 1,
        path: astContentA6,
        number: 6,
        duration: 347
    ),
    "A7" : Content(
        id: "A7",
        title: "RENOVACION",
        contentType: 1,
        path: astContentA7,
        number: 7,
        duration: 1599
    ),
  };

  static List<Day> daysList = [
    Day(
        percent: 0,
        title: "¿POR QUÉ TIENES ANSIEDAD Y MIEDO?",
        description: "Aprenderás a reconocer las causas que originan tu ansiedad y comprenderás por qué experimentas estos sentimientos de ansiedad y miedo.",
        number: 1
    ),
    Day(
        percent: -1,
        title: "COMIDAS QUE TE CAUSAN ANSIEDAD",
        description: '''¿Sabí­as que algunas comidas pueden provocar ansiedad sin que te des cuenta? Es importante evitarlas. 

También contamos con un audio diseñado para reprogramar tu subconsciente mientras duermes. Te recomendamos escucharlo todas las noches con auriculares a un volumen bajo a la hora de dormir.''',
        number: 2
    ),
    Day(
        percent: -1,
        title: "CONTROLANDO LA ANSIEDAD Y PREOCUPACIÓN",
        description: '''Tienes a tu disposición un audio que te guí­a a gestionar los pensamientos negativos que te atormentan.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 3
    ),
    Day(
        percent: -1,
        title: "BLOQUEANDO PENSAMIENTOS NEGATIVOS",
        description: '''Activa tu poder para detener y bloquear los pensamientos negativos con una técnica poderosa.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 4
    ),
    Day(
        percent: -1,
        title: "CONTROLANDO EMOCIONES NEGATIVAS",
        description: '''Aplica esta poderosa técnica para que controles la ansiedad, miedo, preocupación y la desesperación en forma efectiva.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 5
    ),
    Day(
        percent: -1,
        title: "ELIMINANDO EL ESTRÉS DE TU ORGANISMO",
        description: '''Te guiará a eliminar el estrés acumulado de tu mente y de tu cuerpo fí­sico con este vídeo.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 6
    ),
    Day(
        percent: -1,
        title: "ALCANZA EL BALANCE EMOCIONAL",
        description: '''En este ví­deo, te guiará para lograr un equilibrio mental y emocional. Solo relájate y déjate llevar por mis indicaciones.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 7
    ),
    Day(
        percent: -1,
        title: "ACTIVA TU SEGURIDAD EMOCIONAL",
        description: '''En este audio te guío para que actives una seguridad mental y emocional en cualquier momento y lugar.

Recuerda continuar escuchando el audio para reprogramar tu subconsciente mientras duermes. Está diseñado con frecuencias especiales y mensajes subliminales sumamente poderosos.''',
        number: 8
    ),
    Day(
        percent: -1,
        title: "CONTINÚA TU TRANSFORMACIÓN",
        description: '''¡Felicitaciones por seguir con tu compromiso de vencer la ansiedad! 

A partir de este dí­a, puedes elegir los ejercicios que sean más efectivos para ti y hacerlos todos los dí­as, hasta que logres el equilibrio emocional y la tranquilidad.

De lo contrario, aquí­ tienes 3 opciones según el nivel de ansiedad que experimentes:''',
        number: 9,
        isIdealProgram: true
    ),
  ];

  static final contentRef = FirebaseFirestore.instance.collection("content");
  static final dayRef = FirebaseFirestore.instance.collection("day");

  static Future<void> setContentData()async{
    List<Future<void>> trigger = [];
    contentData.forEach((key, value) {
      trigger.add(contentRef.doc(key).set(value.toJson()));
    });
    await Future.wait(trigger);
  }

  static Future<Map<String,Content>> getContentData()async{
    Map<String,Content> data = {};
    final response = await contentRef.get();
    print(response);
    if(response.docs.isNotEmpty){
      List<Content> content = [];
      for (var element in response.docs) {
       content.add(Content.fromJson(element.data()));
      }
      for (var element in content) {
        data.addAll({
          element.id??"" : element
        });
      }
    }
    return data;
  }

  static Future<void> setDayData()async{
    for (var element in daysList) {
      await dayRef.add(element.toJson());
    }
  }

  static Future<List<Day>> getDayData()async{
    /*List<Day> days = [];
    final response = await dayRef.get();
    if(response.docs.isNotEmpty){
      for (var element in response.docs) {
        Day day = Day.fromJson(element.data());
        days.add(day);
        print(day.description);
      }
    }
    days.sort((a,b)=> a.number.compareTo(b.number));*/
    return daysList;
  }
}

// static final dayInfoRef = FirebaseFirestore.instance.collection("dayInfo");
// static final idealProgramRef = FirebaseFirestore.instance.collection("IdealProgram");

// static Future<void> setDayInfoData()async{
//     List<DayInfo> days = [
//       DayInfo(
//           day: daysList[0],
//           id: daysList[0].number,
//           contents: [
//             contentData["A1"]!.copyWith(),
//             contentData["A2"]!.copyWith(),
//           ]
//       ),
//       DayInfo(
//         day: daysList[1],
//         id: daysList[1].number,
//         contents: [
//           contentData["V1"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[2],
//         id: daysList[2].number,
//         contents: [
//           contentData["A4"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[3],
//         id: daysList[3].number,
//         contents: [
//           contentData["V2"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[4],
//         id: daysList[4].number,
//         contents: [
//           contentData["A5"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[5],
//         id: daysList[5].number,
//         contents: [
//           contentData["V3"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[6],
//         id: daysList[6].number,
//         contents: [
//           contentData["V4"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[7],
//         id: daysList[7].number,
//         contents: [
//           contentData["A6"]!.copyWith(),
//           contentData["A3"]!.copyWith(),
//         ],
//       ),
//       DayInfo(
//         day: daysList[8],
//         id: daysList[8].number,
//         contents: [],
//       ),
//     ];
//     for (var element in days) {
//       await dayInfoRef.add(element.toJson());
//     }
//   }
//
//   static Future<List<DayInfo>> getDayInfoData()async{
//     List<DayInfo> dayInfo = [];
//     final response = await dayInfoRef.get();
//     if(response.docs.isNotEmpty){
//       for (var element in response.docs) {
//         dayInfo.add(DayInfo.fromJson(element.data()));
//       }
//     }
//     return dayInfo;
//   }
//
//   static Future<void> setIdealProgramData()async{
//     BuildContext context = appKey.currentState!.context;
//     List<IdealProgram> days = [
//       IdealProgram(
//           id: 1,
//           title: "${AppLocalizations.of(context)?.lowAnxietyLevel}",
//           content: [
//             contentData["A6"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.inTheMorning}"
//             ),
//             contentData["V4"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.inTheAfternoon}"
//             ),
//             contentData["A3"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.atBedtime}"
//             ),
//           ]
//       ),
//       IdealProgram(
//           id: 2,
//           title: "${AppLocalizations.of(context)?.mediumAnxietyLevel}",
//           content: [
//             contentData["A6"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.inTheMorning}"
//             ),
//             contentData["A4"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.medMorning}"
//             ),
//             contentData["V4"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.inTheAfternoon}"
//             ),
//             contentData["A3"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.atBedtime}"
//             ),
//           ]
//       ),
//       IdealProgram(
//           id: 3,
//           title: "${AppLocalizations.of(context)?.highAnxietyLevel}",
//           content: [
//             contentData["A6"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.morEightOrNine}"
//             ),
//             contentData["A4"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.midMorTenOrEleven}"
//             ),
//             contentData["A7"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.noon}"
//             ),
//             contentData["V4"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.afterFourOrFive}"
//             ),
//             contentData["V2"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.nightSixOrSeven}"
//             ),
//             contentData["A3"]!.copyWith(
//                 timeDes: "${AppLocalizations.of(context)?.atBedtime}"
//             ),
//           ]
//       )
//     ];
//     for (var element in days) {
//       await idealProgramRef.add(element.toJson());
//     }
//   }
//
//   static Future<List<IdealProgram>> getIdealProgramData()async{
//     List<IdealProgram> idealProgram = [];
//     final response = await idealProgramRef.get();
//     if(response.docs.isNotEmpty){
//       for (var element in response.docs) {
//         idealProgram.add(IdealProgram.fromJson(element.data()));
//       }
//     }
//     return idealProgram;
//   }