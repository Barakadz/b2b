//
// Created by Kamel.OULEBSIR on 27/09/2022.
//
#include <jni.h>
#include <cerrno>
#include <string>
#include "base64.h"
#include <stdint.h>
#include <android/log.h>

#ifndef TEST_NDK_ENTRIES_H
#define TEST_NDK_ENTRIES_H

#define LOG_TAG "barabashka"
#define PROPERTY_VALUE_MAX  92

/*#ifdef NDEBUG
    #define LOGE(...)
    #define LOGW(...)
    #define LOGI(...)
    #define LOGD(...)
#else*/
    #define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
    #define LOGW(...) __android_log_print(ANDROID_LOG_WARN, LOG_TAG, __VA_ARGS__)
    #define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
    #define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
//#endif

class entries {

    const char map1[83] = {
        'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','s','r','t','u','v','w','x','y','z',
        'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','S','R','T','U','V','W','X','Y','Z',
        '0','1','2','3','4','5','6','7','8','9','_','.','/',';','|','-','(',')','$','[',']','<','>','%',':',' ',
        ',','+','{','}','"'
    };

    const char map2[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

    public:

    /* UAT */
    /// Client Secret
    //const long indexes1[28] = { 27,57,58,20,33,46,14,36,5,19,32,21,12,47,52,21,40,17,3,19,16,52,14,5,21,16,17,0 };
    /// Client ID
     //const long indexes2[28] = { 36,13,2,48,4,55,35,61,56,38,4,6,49,3,21,39,21,62,16,60,51,61,43,2,14,24,46,0 };

    /// Client Secret
    const long indexes1[28] = { 51,36,51,42,17,42,29,5,37,44,9,21,40,58,13,49,55,8,47,48,34,0,42,3,4,39,6,0 };
    /// Client ID
    const long indexes2[28] = { 58,30,58,28,22,45,10,15,60,33,53,28,24,42,23,18,0,41,12,2,30,35,41,42,59,23,10,0 };
    /// URLS
    static constexpr const char* url1 = "https://apim.djezzy.dz/";
    static constexpr const char* url2 = "/uat/oauth2/token";
    static constexpr const char* url3 = "/uat/oauth2/registration";
    static constexpr const char* url4 = "/uat/djezzy-api/api/v1/subscribers";
    static constexpr const char* url5 = "/uat/djezzy-content/api/v1/services";
    static constexpr const char* url6 = "/uat/djezzy-api/api/v1/subscribers/%s/community-user-group/%s";
    static constexpr const char* url7 = "/uat/djezzy-api/content/services/v1/subscribers/%s%s";
    static constexpr const char* url8 = "https://apim.djezzy.dz/uat%s";
    static constexpr const char* url9 = "/uat/djezzy-api/api/v1/assets/settings/%s";
    static constexpr const char* url10 = "/uat/djezzy-api/internal/v1/notification/push-message/%s";
    static constexpr const char* url11 = "/uat/djezzy-api/cc/services/v1/customer_care/";
    static constexpr const char* url12 = "/uat/djezzy-api/dfs/v1/order-payment/";
    static constexpr const char* url13 = "/uat/djezzy-event/api/v1/events/%s";
    static constexpr const char* url14 = "/uat/djezzy-api/content/services/v1/subscribers/%s?include=quiz-subscriptions";
    static constexpr const char* url15 = "/uat/djezzy-api/content/services/v1/subscribers/%s/subscription-service";
    static constexpr const char* url16 = "/uat/djezzy-api/content/services/v1/subscribers/%s/subscription-service";
    static constexpr const char* url17 = "/uat/djezzy-api/content/services/v1/subscribers/%s";
    static constexpr const char* url18 = "/uat/djezzy-api/api/v1/subscribers/%s";
    static constexpr const char* url19 = "/uat/djezzy-api/api/v1/subscribers/%s/bill-info/%s";
    ///End UAT

    /*/PROD
    ///Client Secret
    const long indexes1[28] = { 38,47,15,49,33,48,62,34,12,20,38,17,23,36,34,22,18,35,15,14,47,47,38,33,9,44,17,0 };
    ///Client ID
    const long indexes2[28] = { 58,30,58,28,22,45,10,15,60,33,53,28,24,42,23,18,0,41,12,2,30,35,41,42,59,23,10,0 };
    //URLS
    static constexpr const char* url1 = "https://apim.djezzy.dz/";
    static constexpr const char* url2 = "/oauth2/token";
    static constexpr const char* url3 = "/oauth2/registration";
    static constexpr const char* url4 = "/djezzy-api/api/v1/subscribers";
    static constexpr const char* url5 = "/djezzy-content/api/v1/services";
    static constexpr const char* url6 = "/djezzy-api/api/v1/subscribers/%s/community-user-group/%s";
    static constexpr const char* url7 = "/djezzy-api/content/services/v1/subscribers/%s%s";
    static constexpr const char* url8 = "https://apim.djezzy.dz%s";
    static constexpr const char* url9 = "/djezzy-api/api/v1/assets/settings/%s";
    static constexpr const char* url10 = "/djezzy-api/internal/v1/notification/push-message/%s";
    static constexpr const char* url11 = "/djezzy-api/cc/services/v1/customer_care";
    static constexpr const char* url12 = "/djezzy-api/dfs/v1/order-payment/%s";
    static constexpr const char* url13 = "/djezzy-event/api/v1/events/%s";
    static constexpr const char* url14 = "/djezzy-api/content/services/v1/subscribers/%s?include=quiz-subscriptions";
    static constexpr const char* url15 = "/djezzy-api/content/services/v1/subscribers/%s/subscription-service";
    static constexpr const char* url16 = "/djezzy-api/content/services/v1/subscribers/%s/subscription-service";
    static constexpr const char* url17 = "/djezzy-api/content/services/v1/subscribers/%s";
    static constexpr const char* url18 = "/djezzy-api/api/v1/subscribers/%s";
    static constexpr const char* url19 = "/djezzy-api/api/v1/subscribers/%s/bill-info/%s";
    *///End Prod

    ///Mobile grant
    const long indexes3[6] = { 12,14,1,8,11,4 };
    ///Refresh Grant
    const long indexes4[13] = { 18,4,5,18,4,17,7,62,19,14,10,4,13 };
    ///OTP ID
    const long indexes5[6] = { 17,12,17,14,19,15 };
    ///OPEN ID
    const long indexes6[6] = { 14,15,4,13,8,3 };
    ///Version
    const long indexes7[5] = { 56,52,52,54,55 };

    /* COMMON */
    /// android/util/Base64
    const long cmn_val_01[19] = { 0,13,3,18,14,8,3,64,20,19,8,11,64,27,0,17,4,58,56 };
    /// I
    const long cmn_val_08[1] = { 34 };
    /// (Landroid/content/Context;Ljava/lang/String;)Ljava/lang/Object;
    const long cmn_val_09[63] = { 68,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,28,14,13,19,4,23,19,65,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,64,11,0,13,6,64,40,1,9,4,2,19,65 };
    /// ()Ljava/lang/String;
    const long cmn_val_10[20] = { 68,69,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65 };
    /// getPackageManager
    const long cmn_val_11[17] = { 6,4,19,41,0,2,10,0,6,4,38,0,13,0,6,4,18 };
    /// ()Landroid/content/pm/PackageManager;
    const long cmn_val_12[37] = { 68,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,41,0,2,10,0,6,4,38,0,13,0,6,4,18,65 };
    /// getInstallSourceInfo
    const long cmn_val_13[20] = { 6,4,19,34,13,17,19,0,11,11,43,14,20,18,2,4,34,13,5,14 };
    /// (Ljava/lang/String;)Landroid/content/pm/InstallSourceInfo;
    const long cmn_val_14[58] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,34,13,17,19,0,11,11,43,14,20,18,2,4,34,13,5,14,65 };
    /// getInstallingPackageName
    const long cmn_val_15[24] = { 6,4,19,34,13,17,19,0,11,11,8,13,6,41,0,2,10,0,6,4,39,0,12,4 };
    /// getInstallerPackageName
    const long cmn_val_17[23] = { 6,4,19,34,13,17,19,0,11,11,4,18,41,0,2,10,0,6,4,39,0,12,4 };
    /// (Ljava/lang/String;)Ljava/lang/String;
    const long cmn_val_18[38] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65 };
    /// getPackageName
    const long cmn_val_19[14] = { 6,4,19,41,0,2,10,0,6,4,39,0,12,4 };
    /// ()Ljava/io/File;
    const long cmn_val_20[16] = { 68,69,37,9,0,21,0,64,8,14,64,31,8,11,4,65 };
    /// getPackageInfo
    const long cmn_val_22[14] = { 6,4,19,41,0,2,10,0,6,4,34,13,5,14 };
    /// (Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    const long cmn_val_23[53] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,34,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,41,0,2,10,0,6,4,34,13,5,14,65 };
    /// signatures
    const long cmn_val_24[10] = { 17,8,6,13,0,19,20,18,4,17 };
    /// [Landroid/content/pm/Signature;
    const long cmn_val_25[31] = { 71,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,43,8,6,13,0,19,20,18,4,65 };
    /// toByteArray
    const long cmn_val_26[11] = { 19,14,27,24,19,4,26,18,18,0,24 };
    /// ()[B
    const long cmn_val_27[4] = { 68,69,71,27 };
    /// java/security/MessageDigest
    const long cmn_val_28[27] = { 9,0,21,0,64,17,4,2,20,18,8,19,24,64,38,4,17,17,0,6,4,29,8,6,4,17,19 };
    /// getInstance
    const long cmn_val_29[11] = { 6,4,19,34,13,17,19,0,13,2,4 };
    /// (Ljava/lang/String;)Ljava/security/MessageDigest;
    const long cmn_val_30[49] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,64,17,4,2,20,18,8,19,24,64,38,4,17,17,0,6,4,29,8,6,4,17,19,65 };
    /// ([B)V
    const long cmn_val_31[5] = { 68,71,27,69,47 };
    /// getBytes
    const long cmn_val_32[8] = { 6,4,19,27,24,19,4,17 };
    /// java/util/Arrays
    const long cmn_val_33[16] = { 9,0,21,0,64,20,19,8,11,64,26,18,18,0,24,17 };
    /// copyOf
    const long cmn_val_34[6] = { 2,14,15,24,40,5 };
    /// ([BI)[B
    const long cmn_val_35[7] = { 68,71,27,34,69,71,27 };
    /// javax/crypto/spec/SecretKeySpec
    const long cmn_val_36[31] = { 9,0,21,0,23,64,2,18,24,15,19,14,64,17,15,4,2,64,43,4,2,18,4,19,36,4,24,43,15,4,2 };
    /// <init>
    const long cmn_val_37[6] = { 73,8,13,8,19,74 };
    /// ([BIILjava/lang/String;)V
    const long cmn_val_38[25] = { 68,71,27,34,34,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,47 };
    /// javax/crypto/Cipher
    const long cmn_val_39[19] = { 9,0,21,0,23,64,2,18,24,15,19,14,64,28,8,15,7,4,18 };
    /// (Ljava/lang/String;)Ljavax/crypto/Cipher;
    const long cmn_val_40[41] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,23,64,2,18,24,15,19,14,64,28,8,15,7,4,18,65 };
    /// init
    const long cmn_val_41[4] = { 8,13,8,19 };
    /// (ILjava/security/Key;)V
    const long cmn_val_42[23] = { 68,34,37,9,0,21,0,64,17,4,2,20,18,8,19,24,64,36,4,24,65,69,47 };
    /// decode
    const long cmn_val_43[6] = { 3,4,2,14,3,4 };
    /// (Ljava/lang/String;I)[B"
    const long cmn_val_44[23] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,34,69,71,27 };
    /// doFinal
    const long cmn_val_45[7] = { 3,14,31,8,13,0,11 };
    /// ([B)[B
    const long cmn_val_46[6] = { 68,71,27,69,71,27 };
    /// encodeToString
    const long cmn_val_47[14] = { 4,13,2,14,3,4,45,14,43,19,18,8,13,6 };
    /// ([BI)Ljava/lang/String;
    const long cmn_val_48[23] = { 68,71,27,34,69,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65 };
    /// java/lang/String
    const long cmn_val_49[16] = { 9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6 };
    /// %d/%m/%Y %H:%M:%S
    const long cmn_val_50[17] = { 75,3,64,75,12,64,75,50,77,75,33,76,75,38,76,75,43 };
    /// (Ljava/lang/String;)[B
    const long cmn_val_51[22] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,71,27 };
    /// UTF-8
    const long cmn_val_52[5] = { 46,45,31,67,60 };
    /// SHA-1
    const long cmn_val_53[5] = { 43,33,26,67,53 };
    /// javax/crypto/spec/IvParameterSpec
    const long cmn_val_54[33] = { 9,0,21,0,23,64,2,18,24,15,19,14,64,17,15,4,2,64,34,21,41,0,18,0,12,4,19,4,18,43,15,4,2 };
    /// (ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V
    const long cmn_val_55[66] = { 68,34,37,9,0,21,0,64,17,4,2,20,18,8,19,24,64,36,4,24,65,37,9,0,21,0,64,17,4,2,20,18,8,19,24,64,17,15,4,2,64,26,11,6,14,18,8,19,7,12,41,0,18,0,12,4,19,4,18,43,15,4,2,65,69,47 };
    /// javax/crypto/KeyGenerator
    const long cmn_val_56[25] = { 9,0,21,0,23,64,2,18,24,15,19,14,64,36,4,24,32,4,13,4,18,0,19,14,18 };
    /// (Ljava/lang/String;)Ljavax/crypto/KeyGenerator;
    const long cmn_val_57[47] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,23,64,2,18,24,15,19,14,64,36,4,24,32,4,13,4,18,0,19,14,18,65 };
    /// (I)V
    const long cmn_val_58[4] = { 68,34,69,47 };
    /// generateKey
    const long cmn_val_59[11] = { 6,4,13,4,18,0,19,4,36,4,24 };
    /// ()Ljavax/crypto/SecretKey;
    const long cmn_val_60[26] = { 68,69,37,9,0,21,0,23,64,2,18,24,15,19,14,64,43,4,2,18,4,19,36,4,24,65 };
    /// getEncoded
    const long cmn_val_61[10] = { 6,4,19,30,13,2,14,3,4,3 };
    /// Blowfish
    const long cmn_val_62[8] = { 27,11,14,22,5,8,17,7 };
    /// getSharedPreferences
    const long cmn_val_63[20] = { 6,4,19,43,7,0,18,4,3,41,18,4,5,4,18,4,13,2,4,17 };
    /// (Ljava/lang/String;I)Landroid/content/SharedPreferences;
    const long cmn_val_64[56] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,34,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,43,7,0,18,4,3,41,18,4,5,4,18,4,13,2,4,17,65 };
    /// edit
    const long cmn_val_65[4] = { 4,3,8,19 };
    /// ()Landroid/content/SharedPreferences$Editor;
    const long cmn_val_66[44] = { 68,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,43,7,0,18,4,3,41,18,4,5,4,18,4,13,2,4,17,70,30,3,8,19,14,18,65 };
    /// putString
    const long cmn_val_67[9] = { 15,20,19,43,19,18,8,13,6 };
    /// (Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    const long cmn_val_68[80] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,43,7,0,18,4,3,41,18,4,5,4,18,4,13,2,4,17,70,30,3,8,19,14,18,65 };
    /// commit
    const long cmn_val_69[6] = { 2,14,12,12,8,19 };
    /// ()Z
    const long cmn_val_70[3] = { 68,69,51 };
    /// contains
    const long cmn_val_71[8] = { 2,14,13,19,0,8,13,17 };
    /// (Ljava/lang/String;)Z
    const long cmn_val_72[21] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,51 };
    /// getAll
    const long cmn_val_73[6] = { 6,4,19,26,11,11 };
    /// ()Ljava/util/Map;
    const long cmn_val_74[17] = { 68,69,37,9,0,21,0,64,20,19,8,11,64,38,0,15,65 };
    /// (Ljava/lang/Object;)Ljava/lang/Object;
    const long cmn_val_75[38] = { 68,37,9,0,21,0,64,11,0,13,6,64,40,1,9,4,2,19,65,69,37,9,0,21,0,64,11,0,13,6,64,40,1,9,4,2,19,65 };

    /// com/djezzy/b2b/internet/AppDelegate
    const long cmn_val_76[35] = { 2,14,12,64,3,9,4,25,25,24,64,1,54,1,64,8,13,19,4,18,13,4,19,64,26,15,15,29,4,11,4,6,0,19,4 };
    /// ()Lcom/djezzy/b2b/internet/AppDelegate;
    const long cmn_val_77[39] = { 68,69,37,2,14,12,64,3,9,4,25,25,24,64,1,54,1,64,8,13,19,4,18,13,4,19,64,26,15,15,29,4,11,4,6,0,19,4,65 };

    /// getBaseContext
    const long cmn_val_78[14] = { 6,4,19,27,0,17,4,28,14,13,19,4,23,19 };
    /// ()Landroid/content/Context;
    const long cmn_val_79[27] = { 68,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,28,14,13,19,4,23,19,65 };
    /// getApplicationContext
    const long cmn_val_80[21] = { 6,4,19,26,15,15,11,8,2,0,19,8,14,13,28,14,13,19,4,23,19 };

    /// getApplicationInfo
    const long cmn_val_81[18] = { 6,4,19,26,15,15,11,8,2,0,19,8,14,13,34,13,5,14 };
    /// ()Landroid/content/pm/ApplicationInfo;
    const long cmn_val_82[38] = { 68,69,37,0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,26,15,15,11,8,2,0,19,8,14,13,34,13,5,14,65 };
    /// flags
    const long cmn_val_83[5] = { 5,11,0,6,17 };
    /// android/content/pm/ApplicationInfo
    const long cmn_val_84[34] = { 0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,15,12,64,26,15,15,11,8,2,0,19,8,14,13,34,13,5,14 };
    /// FLAG_DEBUGGABLE
    const long cmn_val_85[15] = { 31,37,26,32,62,29,30,27,46,32,32,26,27,37,30 };

    /// DjezzyAppPrefs
    const long cmn_val_86[14] = { 29,9,4,25,25,24,26,15,15,41,18,4,5,17 };
    /// ProgressCount
    const long cmn_val_87[13] = { 41,18,14,6,18,4,17,17,28,14,20,13,19 };
    /// InitialCount
    const long cmn_val_88[12] = { 34,13,8,19,8,0,11,28,14,20,13,19 };

    /// android/content/Context
    const long cmn_val_89[23] = { 0,13,3,18,14,8,3,64,2,14,13,19,4,13,19,64,28,14,13,19,4,23,19 };
    /// CONNECTIVITY_SERVICE
    const long cmn_val_90[20] = { 28,40,39,39,30,28,45,34,47,34,45,50,62,43,30,44,47,34,28,30 };
    /// Ljava/lang/String;CharSequence
    const long cmn_val_91[18] = { 37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65 };
    /// android/net/NetworkCapabilities
    const long cmn_val_92[31] = { 0,13,3,18,14,8,3,64,13,4,19,64,39,4,19,22,14,18,10,28,0,15,0,1,8,11,8,19,8,4,17 };
    /// TRANSPORT_VPN
    const long cmn_val_93[13] = { 45,44,26,39,43,41,40,44,45,62,47,41,39 };
    /// getSystemService
    const long cmn_val_94[16] = { 6,4,19,43,24,17,19,4,12,43,4,18,21,8,2,4 };
    /// (Ljava/lang/String;)Ljava/lang/Object;
    const long cmn_val_95[38] = { 68,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65,69,37,9,0,21,0,64,11,0,13,6,64,40,1,9,4,2,19,65 };
    /// getAllNetworks
    const long cmn_val_96[14] = { 6,4,19,26,11,11,39,4,19,22,14,18,10,17 };
    /// ()[Landroid/net/Network;
    const long cmn_val_97[24] = { 68,69,71,37,0,13,3,18,14,8,3,64,13,4,19,64,39,4,19,22,14,18,10,65 };
    /// getNetworkCapabilities
    const long cmn_val_98[22] = { 6,4,19,39,4,19,22,14,18,10,28,0,15,0,1,8,11,8,19,8,4,17 };
    /// (Landroid/net/Network;)Landroid/net/NetworkCapabilities;
    const long cmn_val_99[56] = { 68,37,0,13,3,18,14,8,3,64,13,4,19,64,39,4,19,22,14,18,10,65,69,37,0,13,3,18,14,8,3,64,13,4,19,64,39,4,19,22,14,18,10,28,0,15,0,1,8,11,8,19,8,4,17,65 };
    /// toString
    const long cmn_val_100[8] = { 19,14,43,19,18,8,13,6 };
    /// hasTransport
    const long cmn_val_101[12] = { 7,0,17,45,18,0,13,17,15,14,18,19 };
    /// (I)Z
    const long cmn_val_102[4] = { 68,34,69,51 };
    /// labelRes
    const long cmn_val_103[8] = { 11,0,1,4,11,44,4,17 };
    /// I
    const long cmn_val_104[1] = { 34 };
    /// getString
    const long cmn_val_105[9] = { 6,4,19,43,19,18,8,13,6 };
    /// (I)Ljava/lang/String;
    const long cmn_val_106[21] = { 68,34,69,37,9,0,21,0,64,11,0,13,6,64,43,19,18,8,13,6,65 };
    /// AES
    const long cmn_val_107[3] = { 26,30,43 };
    /// AES/CBC/PKCS5Padding
    const long cmn_val_108[20] = { 26,30,43,64,28,27,28,64,41,36,28,43,57,41,0,3,3,8,13,6 };


    /// Special character
    const long idx_spl_00[1]  = { 65 };
    const long idx_spl_01[1]  = { 18 };
    const long idx_spl_02[18] = { 64,15,18,14,2,64,17,4,11,5,64,2,12,3,11,8,13,4 }; // /proc/self/cmdline

    ///SHA256
    const long idx_cmn_02[6] = { 43,33,26,54,57,58 };

    ///ro.build.version.incremental
    const long idx_cmn_03[28] = { 18,14,63,1,20,8,11,3,63,21,4,18,17,8,14,13,63,8,13,2,18,4,12,4,13,19,0,11 };
    ///ro.build.version.release
    const long idx_cmn_04[24] = { 18,14,63,1,20,8,11,3,63,21,4,18,17,8,14,13,63,18,4,11,4,0,17,4 };
    ///ro.build.version.sdk
    const long idx_cmn_05[20] = { 18,14,63,1,20,8,11,3,63,21,4,18,17,8,14,13,63,17,3,10 };
    ///ro.build.version.codename
    const long idx_cmn_06[25] = { 18,14,63,1,20,8,11,3,63,21,4,18,17,8,14,13,63,2,14,3,4,13,0,12,4 };

    ///ro.build.fingerprint
    const long idx_cmn_07[20] = { 18,14,63,1,20,8,11,3,63,5,8,13,6,4,18,15,18,8,13,19 };
    ///ro.build.host
    const long idx_cmn_08[13] = { 18,14,63,1,20,8,11,3,63,7,14,17,19 };
    ///ro.build.type
    const long idx_cmn_09[13] = { 18,14,63,1,20,8,11,3,63,19,24,15,4 };
    ///ro.build.tags
    const long idx_cmn_10[13] = { 18,14,63,1,20,8,11,3,63,19,0,6,17 };
    ///ro.build.id
    const long idx_cmn_11[11] = { 18,14,63,1,20,8,11,3,63,8,3 };

    ///ro.product.brand
    const long idx_cmn_12[16] = { 18,14,63,15,18,14,3,20,2,19,63,1,18,0,13,3 };
    ///ro.product.board
    const long idx_cmn_13[16] = { 18,14,63,15,18,14,3,20,2,19,63,1,14,0,18,3 };
    ///ro.product.manufacturer
    const long idx_cmn_14[23] = { 18,14,63,15,18,14,3,20,2,19,63,12,0,13,20,5,0,2,19,20,18,4,18 };
    ///ro.product.model BuildConfig
    const long idx_cmn_15[16] = { 18,14,63,15,18,14,3,20,2,19,63,12,14,3,4,11 };
    ///ro.product.device
    const long idx_cmn_16[17] = { 18,14,63,15,18,14,3,20,2,19,63,3,4,21,8,2,4 };
    ///ro.product.user
    const long idx_cmn_17[15] = { 18,14,63,15,18,14,3,20,2,19,63,20,17,4,18 };
    ///ro.product.name
    const long idx_cmn_18[15] = { 18,14,63,15,18,14,3,20,2,19,63,13,0,12,4 };
    ///ro.hardware
    const long idx_cmn_19[11] = { 18,14,63,7,0,18,3,22,0,18,4 };

    ///mobileNumber
    const long idx_cmn_20[12] = { 12,14,1,8,11,4,39,20,12,1,4,18 };
    ///access_token
    const long idx_cmn_21[12] = { 0,2,2,4,17,17,62,19,14,10,4,13 };
    ///token_type
    const long idx_cmn_22[10] = { 19,14,10,4,13,62,19,24,15,4 };
    ///refresh_token
    const long idx_cmn_23[13] = { 18,4,5,18,4,17,7,62,19,14,10,4,13 };
    ///language
    const long idx_cmn_24[8] = { 11,0,13,6,20,0,6,4 };
    ///locale
    const long idx_cmn_25[8] = { 11,0,13,6,20,0,6,4 };

    ///get
    const long idx_cmn_30[3] = { 6,4,19 };
    ///Android
    const long idx_cmn_31[7] = { 26,13,3,18,14,8,3 };
    /// F0e74ecf7
    const long idx_cmn_32[9] = { 31,52,4,59,56,4,2,5,59 };
    /// Fb8c0bb35
    const long idx_cmn_40[9] = { 31,1,60,2,52,1,1,55,57 };

    /// com/djezzy/b2b/internet/Constants
    const long idx_cmn_33[33] = { 2,14,12,64,3,9,4,25,25,24,64,1,54,1,64,8,13,19,4,18,13,4,19,64,28,14,13,17,19,0,13,19,17 };
    /// com/djezzy/b2b/internet/BuildConfig
    const long idx_cmn_34[35] = { 2,14,12,64,3,9,4,25,25,24,64,1,54,1,64,8,13,19,4,18,13,4,19,64,27,20,8,11,3,28,14,13,5,8,6 };

    /// getFilesDir
    const long idx_cmn_35[11] = { 6,4,19,31,8,11,4,17,29,8,18 };
    /// getPath
    const long idx_cmn_37[7] = { 6,4,19,41,0,19,7 };
    /// update
    const long idx_cmn_38[6] = { 20,15,3,0,19,4 };
    /// digest
    const long idx_cmn_39[6] = { 3,8,6,4,17,19 };

    /// /data/data/com.djezzy.internet/files/tmp.log
    const long idx_cmn_41[44] = { 64,3,0,19,0,64,3,0,19,0,64,2,14,12,63,3,9,4,25,25,24,63,8,13,19,4,18,13,4,19,64,5,8,11,4,17,64,19,12,15,63,11,14,6 };
    /// w+
    const long idx_cmn_42[2] = { 22,79 };

    /// VERSION_CODE
    const long idx_cmn_100[12] = {47, 30, 44, 43, 34, 40, 39, 62, 28, 40, 29, 30 };

    /// VERSION_NAME
    const long idx_cmn_101[12] = { 47,30,44,43,34,40,39,62,39,26,38,30 };

    /// DEBUG Mode
#ifndef NDEBUG
    const long idx_cmn_51[1] = { 53 };
#else
    const long idx_cmn_51[1] = { 52 };
#endif

    /// Retrieve string using indexes
    std::string FUN_C197EEAE(const long *indexes, int size);
    /// Get shared preference by key
    static const char * FUN_0692317F(JNIEnv *env, jobject context, jstring param);
    /// Retrieve application version code
    static std::string FUN_3D9F333A(JNIEnv *env);
    /// Retrieve application version name
    static jstring FUN_3D9F333B(JNIEnv *env);
    /// Retrieve installer info
    static std::string FUN_76C8CBBD(JNIEnv *env, jobject context);
    /// Retrieve value of a build config parameter by name
    static char * FUN_A432617E(const char *name);
    /// Retrieve file content
    static std::string FUN_CE8B479D(const char *name);
    /// Retrieve file directory path
    static std::string FUN_6F8A4DE6(JNIEnv *env, jobject context);

    /// Get signature
    static std::string FUN_F8BF6A3E(JNIEnv *env, jobject context, jint index);
    /// Get Fingerprint
    static std::string FUN_F98D6DB9(JNIEnv *env, jobject signature);
    /// Convert byte Array to hex
    std::string FUN_E92EDF4B(JNIEnv *env, jbyteArray byteArray);
    /// Encrypt & decrypt
    static jstring FUN_41821FFB(JNIEnv *env, jstring value, jstring key, jstring generatorAlgo, jstring cipherAlgo, jint mode);
    /// Convert keys to long array
    void FUN_20C720BD(std::string *keys, int index, int size);
    /// Get formatted datetime
    static std::string FUN_11F860EC();
    /// Check if debug mode configured on manifest
    static bool FUN_138CD463(JNIEnv *env, jobject context);
    /// Check if vpn configured
    static bool FUN_4148B2C0(JNIEnv *env, jobject context);

    /// Get application context
    static jobject FUN_0DCECDCB(JNIEnv *env);
    /// Generate random key
    static jstring FUN_DE8EC5F5(JNIEnv *env, jstring algo);
    /// Modify value for a key into preference file
    static bool FUN_DE4F0F56(JNIEnv *env, jstring name, jstring key, jstring value);
    /// Retrieve value for a key from preference file
    static jstring FUN_0330E9A3(JNIEnv *env, jstring name, jstring key);
    /// Retrieve int value for a key from preference file
    static jint FUN_B9023215(JNIEnv *env, jstring name, jstring key);

    /// Retrieve String Value of the user-agent
    static std::string FUN_B9023216(JNIEnv *env);

    /**
     * Retrieve static int field from class (callStaticIntField)
     * @param env JNI object
     * @param clazz java class name to use
     * @param name field
     * @param type type of the field (I for int in this case)
     * @return static field int value
     */
    static auto FUN_4F22ECB8(JNIEnv *env, const char* clazz, const char* name, const char* type) {
        jclass class1 = env->FindClass(clazz);
        jfieldID fieldId = env->GetStaticFieldID(class1, name, type);
        return env->GetStaticIntField(class1, fieldId);
    }

    /**
     * Retrieve static object field from class (callStaticObjectField)
     * @param env JNI object
     * @param clazz java class name to use
     * @param name field
     * @param type type of the field (I for int in this case)
     * @return static field int value
     */
    static jobject FUN_4148b2c9(JNIEnv *env, const char* clazz, const char* name, const char* type) {
        jclass class1 = env->FindClass(clazz);
        jfieldID fieldId = env->GetStaticFieldID(class1, name, type);
        return env->GetStaticObjectField(class1, fieldId);
    }

    /**
     * Retrieve static field from object (callObjectField)
     * @param env JNI object
     * @param object instance
     * @param name field
     * @param type of the field (I for int in this case)
     * @return static field value
     */
    static jobject FUN_AE948769(JNIEnv *env, jobject object, const char* name, const char* type) {
        jclass clazz = env->GetObjectClass(object);
        jfieldID field = env->GetFieldID(clazz, name, type);
        return env->GetObjectField(object, field);
    }

    /**
     * Retrieve field from object (callIntField)
     * @param env JNI object
     * @param object instance
     * @param name field
     * @param type of the field (I for int in this case)
     * @return field value
     */
    static int FUN_A5D8FCDF(JNIEnv *env, jobject object, const char* name, const char* type) {
        jclass clazz = env->GetObjectClass(object);
        jfieldID field = env->GetFieldID(clazz, name, type);
        return env->GetIntField(object, field);
    }

    /**
     * Call static method of a class (callStaticMethod)
     * @param env JNI object
     * @param clazz java class name to use
     * @param name of the method
     * @param sig signature of the method
     * @param args others args
     * @return result of the call
     */
    template <class... Args>
    static jobject FUN_34369A67(JNIEnv *env, const char* clazz, const char* name, const char* sig, Args&&... args) {
        jclass jClass = env->FindClass(clazz);
        jmethodID copyOfID = env->GetStaticMethodID(jClass, name, sig);
        return env->CallStaticObjectMethod(jClass, copyOfID, args...);
    }

    /**
     * Call method of an object (callObjectMethod)
     * @param env JNI object
     * @param object instance
     * @param name of the method
     * @param sig signature of the method
     * @param args others args
     * @return
     */
    template <class... Args>
    static jobject FUN_2E8000B6(JNIEnv *env, jobject object, const char* name, const char* sig, Args&&... args) {
        jclass jClass = env->GetObjectClass(object);
        jmethodID methodId = env->GetMethodID(jClass, name, sig);
        return env->CallObjectMethod(object, methodId, args...);
    }

    /**
     * Call a void method of an object (callVoidMethod)
     * @param env JNI object
     * @param object instance
     * @param name of the method
     * @param sig signature of the method
     * @param args others args
     */
    template <class... Args>
    static void FUN_EE8EBEB9(JNIEnv *env, jobject object, const char* name, const char* sig, Args&&... args) {
        jclass jClass = env->GetObjectClass(object);
        jmethodID methodId = env->GetMethodID(jClass, name, sig);
        env->CallVoidMethod(object, methodId, args...);
    }

    /**
     * Call boolean method of an object (callBooleanMethod)
     * @param env JNI object
     * @param object instance
     * @param name of the method
     * @param sig signature of the method
     * @param args others args
     * @return
     */
    template <class... Args>
    static bool FUN_5465B1EA(JNIEnv *env, jobject object, const char* name, const char* sig, Args&&... args) {
        jclass jClass = env->GetObjectClass(object);
        jmethodID methodId = env->GetMethodID(jClass, name, sig);
        return env->CallBooleanMethod(object, methodId, args...);
    }

    /**
     * Create new instance of a class (newObject)
     * @param env JNI object
     * @param clazz java class name to use
     * @param name of the method
     * @param sig signature of the method
     * @param args others args
     * @return
     */
    template <class... Args>
    static jobject FUN_D19FE64B(JNIEnv *env, const char* clazz, const char* name, const char* sig, Args&&... args) {
        jclass jClass = env->FindClass(clazz);
        jmethodID methodId = env->GetMethodID(jClass, name, sig);
        return env->NewObject(jClass, methodId, args...);
    }

    /**
     * Save root checks into local file (saveChecks)
     * @param value instance (JSON)
     * @return error code related to opening the file
     */
    static int FUN_97627150(std::string value)
    {
        //Init
        entries f;
        auto val5 = f.FUN_C197EEAE(f.idx_cmn_41, sizeof(f.idx_cmn_41) / sizeof(f.idx_cmn_41[0]));
        auto val6 = f.FUN_C197EEAE(f.idx_cmn_42, sizeof(f.idx_cmn_42) / sizeof(f.idx_cmn_42[0]));

        //Write in file
        FILE* file = fopen(val5.c_str(), val6.c_str());
        if (file != nullptr)
        {
            std::string res1 = encode(value.c_str());
            fputs(res1.data(), file);
            fflush(file);
            fclose(file);
        }

        //Return errno
        return errno;
    }

    /**
     * Convert jString to std::string
     * @param jString instance (jStr)
     * @return std::string
     */
    static std::string FUN_4148b2e4(JNIEnv *env, jstring jStr);

    /**
     * Get root checks saved into local file (getChecks)
     * @return checks value (JSON)
     */
    static std::string FUN_E9F2740A(){

        //Init
        entries f;
        auto val1 = f.FUN_C197EEAE(f.idx_cmn_41, sizeof(f.idx_cmn_41) / sizeof(f.idx_cmn_41[0]));
        auto val2 = f.FUN_C197EEAE(f.idx_spl_01, sizeof(f.idx_spl_01) / sizeof(f.idx_spl_01[0]));

        //read from file
        char info[512] = {0};
        FILE *file = fopen(val1.c_str(), val2.c_str());
        if (file)
        {
            fread(info, sizeof(info), 1, file);
            fclose(file);
        }

        //Convert
        return decode(info);
    }
};

#endif //TEST_NDK_ENTRIES_H