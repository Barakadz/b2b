import 'dart:convert';
import 'dart:io';
import 'package:business/src/exceptions/api_exceptions.dart';
import 'package:business/src/models/other/faq_list.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/services/native/information_retriever.dart';
import 'package:business/src/services/native/preferences.dart';
import 'package:dio/dio.dart';

class FaqRepository {
  static Future<FaqListModel> getFaqs(
      {String? category, int? size, int? page}) async {
    try {
      var msisdn = await Preferences.getMobileNumber();
      var url = await InformationRetriever.getCareUrl();
      var response = await Api.getRequest(
          '$url$msisdn',
          //'https://apim.djezzy.dz/uat/djezzy-api/cc/services/v1/customer_care/$msisdn',
          true,
          true,
          {'type': 'faq', 'category': category, 'size': size, 'page': page});
      return FaqListModel.fromJson(json.decode(response));
    } catch (exception) {
      if (exception is DioException) {
        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.connectionTimeout) {
          throw SocketException(exception.message ?? "");
        } else if (exception.type == DioExceptionType.badResponse) {
          throw BadRequestException('');
        } else {
          throw FetchDataException('');
        }
      } else {
        throw DataFormatException('INVALID_VALUE');
      }
    }
  }

  static Map<String, dynamic> staticData = {
    "code": 200,
    "message": "OK",
    "faq": [
      /*{
        "id": "1",
        "type": "supplementary-informations",
        "attributes": {
          "category": "line",
          "informations": [
            {
              "name": {
                "text": {
                  "fr": "Code PIN / PUK oublié ?",
                  "ar": "نسيت رمز PIN / PUK ؟",
                  "en": "Forgot PIN / PUK code ?"
                }
              },
              "description": {
                "text": {
                  "fr":
                      "Si vous entrez trois fois un code PIN de manière erronée, votre carte SIM sera automatiquement bloquée. Dès lors, vous devrez utiliser votre code PUK qui se trouve à l’intérieur de l’emballage d’origine. Veuillez le conserver dans un endroit sûr & facile d’accès.\nSi vous ne retrouvez plus votre code PUK, veuillez vous diriger vers le nouveau volet code PUK du menu latéral de la Djezzy App.",
                  "ar":
                      "إذا أدخلت رمز PIN بشكل غير صحيح ثلاث مرات ، فسيتم حظر بطاقة SIM تلقائيًا. لذلك ، سوف تحتاج إلى استخدام رمز PUK الموجود داخل العبوة الأصلية. يرجى الاحتفاظ بها في مكان آمن ويمكن الوصول إليه بسهولة.\nإذا لم يعد بإمكانك العثور على رمز PUK الخاص بك ، فالرجاء التوجه إلى جزء رمز PUK الجديد من القائمة الجانبية لتطبيق جازي ",
                  "en":
                      "If you enter a PIN incorrectly three times, your SIM card will be automatically blocked. Therefore, you will need to use your PUK code which is inside the original packaging. Please keep it in a safe & easily accessible place.\nIf you can no longer find your PUK code, please go to the new PUK code pane of the Djezzy App side menu."
                }
              }
            },
            {
              "name": {
                "text": {
                  "fr":
                      "Comment puis-je avoir mon code PIN2 et à quoi sert-il ?",
                  "ar":
                      "كيف يمكنني الحصول على رمز PIN2 الخاص بي وما هو استخدامه؟",
                  "en": "How can I get my PIN2 code and what is it used for?"
                }
              },
              "description": {
                "text": {
                  "fr":
                      "Le code PIN2 vous permettra de :\n- Obtenir votre code PUK si vous souhaitez l’avoir à partir d’une autre ligne Djezzy\n- Déconnecter votre ligne Djezzy en cas de vol ou de perte\n- Reconnecter votre ligne Djezzy si vous la retrouvez après une perte\nPour l’obtenir, appelez le 777 ou composez *777#",
                  "ar":
                      "سيسمح لك رمز PIN2 بما يلي:\n- الحصول على رمز PUK الخاص بك إذا كنت ترغب في الحصول عليه من خط جازي آخر\n- توقيف خط جازي الخاص بك في حالة السرقة أو الضياع\n- إعادة تشغيل الخط  إذا وجدته بعد الضياع\nللحصول عليه، اتصل على 777 أو اطلب # 777 *",
                  "en":
                      "The PIN2 code will allow you to:\n- Obtain your PUK code if you wish to have it from another Djezzy line\n- Disconnect your Djezzy line in case of theft or loss\n- Reconnect your Djezzy line if you find it after a loss\nTo obtain it, call 777 or dial * 777 #"
                }
              }
            },
            {
              "name": {
                "text": {
                  "fr":
                      "Pendant combien de temps puis-je conserver mon numéro Djezzy, sans utiliser vos services ( Appels, SMS & Internet ) ?",
                  "ar":
                      "ما هي المدة التي يمكنني خلالها الاحتفاظ برقم جازي الخاص بي دون استخدام خدماتكم (المكالمات والرسائل النصية والإنترنت)؟",
                  "en":
                      "How long can I keep my Djezzy number, without using your services (Calls, SMS & Internet)?"
                }
              },
              "description": {
                "text": {
                  "fr":
                      "En cas de non utilisation de nos services Djezzy, votre numéro peut etre conserver pendant 90 jours. Dépassant ce delai, votre numéro est suspendu.\nVous pouvez appeler le 777 pour vous informer si votre numéro est toujours disponible et passer à la Boutique Djezzy pour pour pouvoir le récupérer ou le racheter. La nouvelle acquisition se fera sous un profil Djezzy commercialisé au prix de 300 DA.",
                  "ar":
                      "إذا كنت لا تستخدم خدمات جازي ، فيمكن الاحتفاظ برقمك لمدة 90 يومًا. بعد هذه الفترة ، تم تعليق رقمك.\nيمكنك الاتصال بـ 777 لمعرفة ما إذا كان رقمك لا يزال متاحًا و التوجه لمركز الخدمات جازي لتتمكن من استلامه أو استرداده.\nسيتم الاستحواذ الجديد في عرض مسوًق بسعر 300 دج",
                  "en":
                      "If you do not use our Djezzy services, your number can be kept for 90 days. Beyond this period, your number is suspended.\nYou can call 777 to find out if your number is still available and go to the Djezzy Store to be able to retrieve or redeem it. The new acquisition will be made under a Djezzy profile marketed at a price of 300 DA."
                }
              }
            },
            {
              "name": {
                "text": {
                  "fr":
                      "Je n'ai pas utilisé ma puce pendant un moment et je ne peux pas effectuer d'appel ou envoyer de messages",
                  "ar":
                      "لم أستخدم شريحتي منذ فترة ولا يمكنني إجراء مكالمة أو إرسال رسائل",
                  "en":
                      "I have not used my SIM for a while and cannot make calls or send messages"
                }
              },
              "description": {
                "text": {
                  "fr":
                      "Si vous n’émettez aucun appel, si vous n’effectuez aucune recharge ou si vous n’envoyez pas de messages textes pour une période de trois mois, votre ligne sera bloquée. Pour vous assurer que votre carte Sim reste active vous devez effectuer un appel, envoyer un SMS ou activer une offre au moins une fois tous les 90 jours.",
                  "ar":
                      "إذا لم تقم بإجراء مكالمة أو تعبئة رصيد أو إرسال رسائل نصية لمدة ثلاثة أشهر ، فسيتم حظر خطك. للتأكد من أن بطاقة Sim الخاصة بك تظل نشطة ، فأنت بحاجة إلى إجراء مكالمة ، إرسال رسالة نصية أو تشغيل عرض مرة واحدة على الأقل كل 90 يومًا.",
                  "en":
                      "If you don't make a call, top up, or send text messages for a period of three months, your line will be blocked. To make sure your Sim card stays active you need to make a call, text, or activate an offer at least once every 90 days."
                }
              }
            },
            {
              "name": {
                "text": {
                  "fr": "Comment puis-je connaitre mon numéro Djezzy ?",
                  "ar": "كيف يمكنني معرفة رقم جازي الخاص بي ؟",
                  "en": "How can I know my Djezzy number ?"
                }
              },
              "description": {
                "text": {
                  "fr":
                      "Vous pouvez l'afficher via la formule *99# ou bien en appelant le 700 gratuitement. Votre numéro est aussi visible sur la page d'acceuil de la Djezzy app.",
                  "ar":
                      "يمكنك عرضها باستخدام الصيغة #99* أو عن طريق الاتصال بـ 700 مجانًا. رقمك متوفر أيضًا في الصفحة الرئيسية لتطبيق جازي",
                  "en":
                      "You can display it using the formula *99# or by calling 700 free of charge. Your number is also visible on the home page of the Djezzy app."
                }
              }
            }
          ]
        }
      }*/
    ]
  };
}
