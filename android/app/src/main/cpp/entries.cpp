
#include "clib.h"
#include "base64.h"
#include "entries.h"
#include <cstdio>
#include <cstring>
#include <malloc.h>

/**
 * Retrieve a string using a list of indexes
 * @param indexes list of positions
 * @param size of the string
 * @return A string
 */
std::string entries::FUN_C197EEAE(const long *indexes, int size) {

    //Retrieve data
    std::string value;
    for (int i=0; i<size; i++)
        value += map1[indexes[i]];

    //return value
    return value;
}

/**
 * Get shared preference by key
 * @param env
 * @param context application context
 * @param param key of the parameter
 * @return value of the parameter
 */
const char * entries::FUN_0692317F(JNIEnv *env, jobject context, jstring param) {

    //Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.idx_cmn_33, sizeof(f.idx_cmn_33) / sizeof(f.idx_cmn_33[0]));
    auto val2 = f.FUN_C197EEAE(f.idx_cmn_32, sizeof(f.idx_cmn_32) / sizeof(f.idx_cmn_32[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_09, sizeof(f.cmn_val_09) / sizeof(f.cmn_val_09[0]));

    //Value
    auto val = (jstring) entries::FUN_34369A67(env, val1.c_str(), val2.c_str(), val3.c_str(),
                                               context, param);
    return val != nullptr ?  env->GetStringUTFChars(val, nullptr) : "";
}

/**
 * Get application version code
 * @param env
 * @return version code
 */
std::string entries::FUN_3D9F333A(JNIEnv *env) {

    //Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.idx_cmn_34, sizeof(f.idx_cmn_34) / sizeof(f.idx_cmn_34[0]));
    auto val2 = f.FUN_C197EEAE(f.idx_cmn_100, sizeof(f.idx_cmn_100) / sizeof(f.idx_cmn_100[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_08, sizeof(f.cmn_val_08) / sizeof(f.cmn_val_08[0]));

    //Value
    return std::to_string(entries::FUN_4F22ECB8(env, val1.c_str(), val2.c_str(), val3.c_str()));
}

/**
 * Get application version name
 * @param env
 * @return version name
 */
jstring entries::FUN_3D9F333B(JNIEnv *env) {

    //Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.idx_cmn_34, sizeof(f.idx_cmn_34) / sizeof(f.idx_cmn_34[0]));
    auto val2 = f.FUN_C197EEAE(f.idx_cmn_101, sizeof(f.idx_cmn_101) / sizeof(f.idx_cmn_101[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_91, sizeof(f.cmn_val_91) / sizeof(f.cmn_val_91[0]));

    //Value
    return (jstring) entries::FUN_4148b2c9(env, val1.c_str(), val2.c_str(), val3.c_str());
}

/**
 * Retrieve installer info
 * @param env
 * @param context application context
 * @return installer package installer
 */
std::string entries::FUN_76C8CBBD(JNIEnv *env, jobject context) {

    //Indexes
    entries f;
    auto val0 = f.FUN_C197EEAE(f.idx_cmn_05, sizeof(f.idx_cmn_05) / sizeof(f.idx_cmn_05[0]));
    auto val1 = f.FUN_C197EEAE(f.cmn_val_19, sizeof(f.cmn_val_19) / sizeof(f.cmn_val_19[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_10, sizeof(f.cmn_val_10) / sizeof(f.cmn_val_10[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_11, sizeof(f.cmn_val_11) / sizeof(f.cmn_val_11[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_12, sizeof(f.cmn_val_12) / sizeof(f.cmn_val_12[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_13, sizeof(f.cmn_val_13) / sizeof(f.cmn_val_13[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_14, sizeof(f.cmn_val_14) / sizeof(f.cmn_val_14[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_15, sizeof(f.cmn_val_15) / sizeof(f.cmn_val_15[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_17, sizeof(f.cmn_val_17) / sizeof(f.cmn_val_17[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_18, sizeof(f.cmn_val_18) / sizeof(f.cmn_val_18[0]));

    //Get Package Name
    auto packageName = (jstring) entries::FUN_2E8000B6(env, context, val1.c_str(), val2.c_str());

    //Get Package Manager
    auto packageManager = entries::FUN_2E8000B6(env, context, val3.c_str(), val4.c_str());

    //Get SDK Version
    std::string versionCode = entries::FUN_A432617E(val0.c_str());

    //Get Package Installer
    jstring installer;
    if(std::stoi(versionCode) >= 30)
    {
        //Get installer info
        jobject installInfo = entries::FUN_2E8000B6(env, packageManager, val5.c_str(), val6.c_str(),
                                                    packageName);

        //Get installer package name
        installer = (jstring) entries::FUN_2E8000B6(env, installInfo, val7.c_str(), val2.c_str());
    }
    else
    {
        //Get installer package name
        installer = (jstring) entries::FUN_2E8000B6(env, packageManager, val8.c_str(), val9.c_str(),
                                                    packageName);
    }
    //Return result
    return installer != nullptr ?  std::string(env->GetStringUTFChars(installer, nullptr)) : "";
}

/**
 * Retrieve value of a build config parameter by name
 * @param name of build config parameter
 * @return value of build config parameter
 */
char * entries::FUN_A432617E(const char *name) {
    char *matches = static_cast<char *>(malloc(PROPERTY_VALUE_MAX * sizeof(char *)));
    __system_property_get(name, matches);
    return matches;
}

/**
 * Retrieve file content
 * @param info
 * @param path cmd
 * @return
 */
std::string entries::FUN_CE8B479D(const char *param)
{
    ///Indexes
    entries f;
    auto var1 = f.FUN_C197EEAE(f.idx_spl_01, sizeof(f.idx_spl_01) / sizeof(f.idx_spl_01[0]));

    ///Get file content
    char info[64] = { 0 };
    FILE *cmdline = fopen(param, var1.c_str());
    if (cmdline)
    {
        fread(info, sizeof(info), 1, cmdline);
        fclose(cmdline);
    }

    ///Return result
    return std::string(info);
}

/**
 * Retrieve file directory path
 * @param info
 * @param path cmd
 * @return
 */
std::string entries::FUN_6F8A4DE6(JNIEnv *env, jobject context)
{
    ///Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.idx_cmn_35, sizeof(f.idx_cmn_35) / sizeof(f.idx_cmn_35[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_20, sizeof(f.cmn_val_20) / sizeof(f.cmn_val_20[0]));
    auto val3 = f.FUN_C197EEAE(f.idx_cmn_37, sizeof(f.idx_cmn_37) / sizeof(f.idx_cmn_37[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_10, sizeof(f.cmn_val_10) / sizeof(f.cmn_val_10[0]));

    ///Get getFilesDir result
    auto filesDir = entries::FUN_2E8000B6(env, context, val1.c_str(), val2.c_str());

    ///Get getPath result
    auto path = (jstring) entries::FUN_2E8000B6(env, filesDir, val3.c_str(), val4.c_str());

    ///Get Package Manager
    return std::string(path != nullptr ? env->GetStringUTFChars(path, nullptr):"");
}

/**
 * Get app signature
 * @param env
 * @param context
 * @param index
 * @return
 */
std::string entries::FUN_F8BF6A3E(JNIEnv *env, jobject context, jint index) {

    //Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_11, sizeof(f.cmn_val_11) / sizeof(f.cmn_val_11[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_12, sizeof(f.cmn_val_12) / sizeof(f.cmn_val_12[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_19, sizeof(f.cmn_val_19) / sizeof(f.cmn_val_19[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_10, sizeof(f.cmn_val_10) / sizeof(f.cmn_val_10[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_22, sizeof(f.cmn_val_22) / sizeof(f.cmn_val_22[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_23, sizeof(f.cmn_val_23) / sizeof(f.cmn_val_23[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_24, sizeof(f.cmn_val_24) / sizeof(f.cmn_val_24[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_25, sizeof(f.cmn_val_25) / sizeof(f.cmn_val_25[0]));

    // Get Package Manager
    auto package_manager = entries::FUN_2E8000B6(env, context, val1.c_str(), val2.c_str());

    // Get Package Name
    jobject packageName = entries::FUN_2E8000B6(env, context, val3.c_str(), val4.c_str());

    // Get package info
    jobject packageInfo = entries::FUN_2E8000B6(env, package_manager, val5.c_str(), val6.c_str(),
                                                packageName, 64);

    // Get signature
    auto signatures = (jobjectArray) entries::FUN_AE948769(env, packageInfo, val7.c_str(),
                                                           val8.c_str());

    // Take First Signature to make test
    return entries::FUN_F98D6DB9(env, env->GetObjectArrayElement(signatures, index));
}

/**
 * Get fingerprint from signature
 * @param env
 * @param signature
 * @return
 */
std::string entries::FUN_F98D6DB9(JNIEnv *env, jobject signature){

    // Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_26, sizeof(f.cmn_val_26) / sizeof(f.cmn_val_26[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_27, sizeof(f.cmn_val_27) / sizeof(f.cmn_val_27[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_28, sizeof(f.cmn_val_28) / sizeof(f.cmn_val_28[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_29, sizeof(f.cmn_val_29) / sizeof(f.cmn_val_29[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_30, sizeof(f.cmn_val_30) / sizeof(f.cmn_val_30[0]));
    auto val6 = f.FUN_C197EEAE(f.idx_cmn_02, sizeof(f.idx_cmn_02) / sizeof(f.idx_cmn_02[0]));
    auto val7 = f.FUN_C197EEAE(f.idx_cmn_38, sizeof(f.idx_cmn_38) / sizeof(f.idx_cmn_38[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_31, sizeof(f.cmn_val_31) / sizeof(f.cmn_val_31[0]));
    auto val9 = f.FUN_C197EEAE(f.idx_cmn_39, sizeof(f.idx_cmn_39) / sizeof(f.idx_cmn_39[0]));

    // Get ByteArray
    auto bytearray = (jbyteArray) entries::FUN_2E8000B6(env, signature, val1.c_str(), val2.c_str());

    // Get messageDigest instance
    jobject digestObj = entries::FUN_34369A67(env, val3.c_str(), val4.c_str(), val5.c_str(),
                                              env->NewStringUTF(val6.c_str()));

    // Performs update on digest
    entries::FUN_EE8EBEB9(env, digestObj, val7.c_str(), val8.c_str(), bytearray);

    // Performs update on the digest then completes the digest computation
    auto digest = (jbyteArray) entries::FUN_2E8000B6(env, digestObj, val9.c_str(), val2.c_str());

    // Return signature
    return f.FUN_E92EDF4B(env, digest);
}

/**
 * Convert bytes array to hex
 * @param env
 * @param byteArray
 * @return hex value
 */
std::string entries::FUN_E92EDF4B(JNIEnv *env, jbyteArray byteArray)
{
    /// Convert unsigned char*
    jint length = env->GetArrayLength(byteArray);
    auto* bytes = (unsigned char*)env->GetByteArrayElements(byteArray, nullptr);

    /// Convert to hex
    std::string s(length * 2, ' ');
    for (int i = 0; i < length; ++i) {
        unsigned char chr = bytes[i] & 0xFFu;
        s[i * 2] = map2[chr >> 4u];
        s[i * 2 + 1] = map2[chr & 0x0Fu];
    }
    return s;
}

/**
 * Encrypt or decrypt a value depending on mode value.
 * @param env
 * @param value to be encrypted or decrypted
 * @param key encryption key
 * @param generatorAlgo encryption key Algorithm "AES"
 * @param cipherAlgo Cipher Algorithm "AES/CBC/PKCS5Padding"
 * @param mode specify either to xencrypt or decrypt value 1 for cencrypt and 2 for decrypt
 * @return
 */
jstring entries::FUN_41821FFB(JNIEnv *env, jstring value, jstring key, jstring generatorAlgo, jstring cipherAlgo, jint mode) {

    /// Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_32, sizeof(f.cmn_val_32) / sizeof(f.cmn_val_32[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_27, sizeof(f.cmn_val_27) / sizeof(f.cmn_val_27[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_33, sizeof(f.cmn_val_33) / sizeof(f.cmn_val_33[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_34, sizeof(f.cmn_val_34) / sizeof(f.cmn_val_34[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_35, sizeof(f.cmn_val_35) / sizeof(f.cmn_val_35[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_36, sizeof(f.cmn_val_36) / sizeof(f.cmn_val_36[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_37, sizeof(f.cmn_val_37) / sizeof(f.cmn_val_37[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_38, sizeof(f.cmn_val_38) / sizeof(f.cmn_val_38[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_39, sizeof(f.cmn_val_39) / sizeof(f.cmn_val_39[0]));
    auto val10 = f.FUN_C197EEAE(f.cmn_val_29, sizeof(f.cmn_val_29) / sizeof(f.cmn_val_29[0]));
    auto val11 = f.FUN_C197EEAE(f.cmn_val_40, sizeof(f.cmn_val_40) / sizeof(f.cmn_val_40[0]));
    auto val12 = f.FUN_C197EEAE(f.cmn_val_41, sizeof(f.cmn_val_41) / sizeof(f.cmn_val_41[0]));
    auto val13 = f.FUN_C197EEAE(f.cmn_val_42, sizeof(f.cmn_val_42) / sizeof(f.cmn_val_42[0]));
    auto val14 = f.FUN_C197EEAE(f.cmn_val_43, sizeof(f.cmn_val_43) / sizeof(f.cmn_val_43[0]));
    auto val15 = f.FUN_C197EEAE(f.cmn_val_44, sizeof(f.cmn_val_44) / sizeof(f.cmn_val_44[0]));
    auto val16 = f.FUN_C197EEAE(f.cmn_val_01, sizeof(f.cmn_val_01) / sizeof(f.cmn_val_01[0]));
    auto val17 = f.FUN_C197EEAE(f.cmn_val_45, sizeof(f.cmn_val_45) / sizeof(f.cmn_val_45[0]));
    auto val18 = f.FUN_C197EEAE(f.cmn_val_46, sizeof(f.cmn_val_46) / sizeof(f.cmn_val_46[0]));
    auto val19 = f.FUN_C197EEAE(f.cmn_val_47, sizeof(f.cmn_val_47) / sizeof(f.cmn_val_47[0]));
    auto val20 = f.FUN_C197EEAE(f.cmn_val_48, sizeof(f.cmn_val_48) / sizeof(f.cmn_val_48[0]));
    auto val21 = f.FUN_C197EEAE(f.cmn_val_49, sizeof(f.cmn_val_49) / sizeof(f.cmn_val_49[0]));
    auto val22 = f.FUN_C197EEAE(f.cmn_val_31, sizeof(f.cmn_val_31) / sizeof(f.cmn_val_31[0]));
    auto val23 = f.FUN_C197EEAE(f.cmn_val_28, sizeof(f.cmn_val_28) / sizeof(f.cmn_val_28[0]));
    auto val24 = f.FUN_C197EEAE(f.idx_cmn_39, sizeof(f.idx_cmn_39) / sizeof(f.idx_cmn_39[0]));
    auto val25 = f.FUN_C197EEAE(f.cmn_val_30, sizeof(f.cmn_val_30) / sizeof(f.cmn_val_30[0]));
    auto val26 = f.FUN_C197EEAE(f.cmn_val_51, sizeof(f.cmn_val_51) / sizeof(f.cmn_val_51[0]));
    auto val27 = f.FUN_C197EEAE(f.cmn_val_52, sizeof(f.cmn_val_52) / sizeof(f.cmn_val_52[0]));
    auto val28 = f.FUN_C197EEAE(f.cmn_val_53, sizeof(f.cmn_val_53) / sizeof(f.cmn_val_53[0]));
    auto val29 = f.FUN_C197EEAE(f.cmn_val_54, sizeof(f.cmn_val_54) / sizeof(f.cmn_val_54[0]));
    auto val30 = f.FUN_C197EEAE(f.cmn_val_55, sizeof(f.cmn_val_55) / sizeof(f.cmn_val_55[0]));

    //Convert key to bytes array & retrieve sub array
    auto bytes = (jbyteArray) FUN_2E8000B6(env, key, val1.c_str(), val26.c_str(),
                                           env->NewStringUTF(val27.c_str()));
    jobject md = FUN_34369A67(env, val23.c_str(), val10.c_str(), val25.c_str(),
                              env->NewStringUTF(val28.c_str()));
    bytes = (jbyteArray) FUN_2E8000B6(env, md, val24.c_str(), val18.c_str(), bytes);
    bytes = (jbyteArray) FUN_34369A67(env, val3.c_str(), val4.c_str(), val5.c_str(), bytes, 16);

    //Calculate secret key
    jobject secretKey = FUN_D19FE64B(env, val6.c_str(), val7.c_str(), val8.c_str(), bytes, 0,
                                     env->GetArrayLength(bytes), generatorAlgo);
    // generate vi
    jobject iv = FUN_D19FE64B(env, val29.c_str(), val7.c_str(), val22.c_str(),
                              env->NewByteArray(16));

    // Get Cipher object & init
    jobject cipherObject = FUN_34369A67(env, val9.c_str(), val10.c_str(),
                                        val11.c_str(), cipherAlgo);
    FUN_EE8EBEB9(env, cipherObject, val12.c_str(), val30.c_str(), mode, secretKey, iv);

    // get Bytes depending on mode
    jbyteArray textBytes;
    if (mode == 1)
        textBytes = (jbyteArray) FUN_2E8000B6(env, value, val1.c_str(), val2.c_str());
    else
        textBytes = (jbyteArray) FUN_34369A67(env, val16.c_str(), val14.c_str(), val15.c_str(),
                                              value, 0);

    // Do final
    auto encryptedBytes = (jbyteArray) FUN_2E8000B6(env, cipherObject, val17.c_str(), val18.c_str(),
                                                    textBytes);

    // Return result depending on
    if (mode == 1)
        return (jstring) FUN_34369A67(env, val16.c_str(), val19.c_str(), val20.c_str(),
                                      encryptedBytes, 2);
    else
        return (jstring) FUN_D19FE64B(env, val21.c_str(), val7.c_str(), val22.c_str(),
                                      encryptedBytes);
}

/**
 * Generate random key
 * @param env JNI object
 * @param algo algorithm used for key generation
 * @return
 */
jstring entries::FUN_DE8EC5F5(JNIEnv *env, jstring algo){

    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_01, sizeof(f.cmn_val_01) / sizeof(f.cmn_val_01[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_29, sizeof(f.cmn_val_29) / sizeof(f.cmn_val_29[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_27, sizeof(f.cmn_val_27) / sizeof(f.cmn_val_27[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_41, sizeof(f.cmn_val_41) / sizeof(f.cmn_val_41[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_47, sizeof(f.cmn_val_47) / sizeof(f.cmn_val_47[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_48, sizeof(f.cmn_val_48) / sizeof(f.cmn_val_48[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_56, sizeof(f.cmn_val_56) / sizeof(f.cmn_val_56[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_57, sizeof(f.cmn_val_57) / sizeof(f.cmn_val_57[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_58, sizeof(f.cmn_val_58) / sizeof(f.cmn_val_58[0]));
    auto val10 = f.FUN_C197EEAE(f.cmn_val_59, sizeof(f.cmn_val_59) / sizeof(f.cmn_val_59[0]));
    auto val11 = f.FUN_C197EEAE(f.cmn_val_60, sizeof(f.cmn_val_60) / sizeof(f.cmn_val_60[0]));
    auto val12 = f.FUN_C197EEAE(f.cmn_val_61, sizeof(f.cmn_val_61) / sizeof(f.cmn_val_61[0]));

    auto generatorObject = FUN_34369A67(env, val7.c_str(), val2.c_str(), val8.c_str(), algo);
    FUN_EE8EBEB9(env, generatorObject, val4.c_str(), val9.c_str(), 256);
    auto key = FUN_2E8000B6(env, generatorObject, val10.c_str(), val11.c_str());
    auto keyBytes = (jbyteArray) FUN_2E8000B6(env, key, val12.c_str(), val3.c_str());
    return (jstring) FUN_34369A67(env, val1.c_str(), val5.c_str(),val6.c_str(), keyBytes, 2);
}

/**
 * Generate constants from string
 * @param keys array of std::string key
 * @param index of first constant
 * @param size of array
 */
void entries::FUN_20C720BD(std::string *keys, int index, int size) {

    //Retrieve data
    std::string value = "\n";
    int mapSize = sizeof(map1)/sizeof(map1[0]);
    //Loop
    for (int i=0; i<size; i++) {
        auto key = keys[i];
        auto length = key.size();
        value = "\n/// " + key + "\nconst long cmn_val_" + std::to_string(index) + "[" + std::to_string(length) + "] = { ";
        index++;

        for (int j = 0; j < length; j++) {
            auto keyVal = key[j];
            for (int k = 0; k < mapSize; k++) {
                auto mapVal = map1[k];
                if(keyVal==mapVal)
                    value += (j==0?"":",") + std::to_string(k);
            }
        }
        value += " };\n";
        LOGD("value is %s", value.c_str());
    }
}

/**
 * Get system current time
 * @return current time
 */
std::string entries::FUN_11F860EC(){

    // Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_50, sizeof(f.cmn_val_50) / sizeof(f.cmn_val_50[0]));

    time_t curr_time;
    time(&curr_time);
    tm * curr_tm = localtime(&curr_time);

    char buffer[256];
    strftime(buffer, sizeof(buffer), val1.c_str(), curr_tm);
    return buffer;
}

/**
 * Check if debug mode configured on manifest
 * @param env JNI object
 * @param context application context
 * @return true if debug mode configured, false if not.
 */
bool entries::FUN_138CD463(JNIEnv *env, jobject context){

    // Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_81, sizeof(f.cmn_val_81) / sizeof(f.cmn_val_81[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_82, sizeof(f.cmn_val_82) / sizeof(f.cmn_val_82[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_83, sizeof(f.cmn_val_83) / sizeof(f.cmn_val_83[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_08, sizeof(f.cmn_val_08) / sizeof(f.cmn_val_08[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_84, sizeof(f.cmn_val_84) / sizeof(f.cmn_val_84[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_85, sizeof(f.cmn_val_85) / sizeof(f.cmn_val_85[0]));

    // Get app info
    auto appInfo = FUN_2E8000B6(env, context, val1.c_str(), val2.c_str());

    // Get flags
    unsigned int flags = FUN_A5D8FCDF(env, appInfo, val3.c_str(), val4.c_str());

    // Get FLAG_DEBUGGABLE value
    unsigned int debugMode = FUN_4F22ECB8(env, val5.c_str(), val6.c_str(), val4.c_str());

    // Check FLAG_DEBUGGABLE & return result
    return (debugMode & flags) != 0;
}

/**
 * Check if VPN activate or not
 * @param env JNI object
 * @param context application context
 * @return false if no VPN network connected else, return true
 */
bool entries::FUN_4148B2C0(JNIEnv *env, jobject context){

    //Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_89, sizeof(f.cmn_val_89) / sizeof(f.cmn_val_89[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_90, sizeof(f.cmn_val_90) / sizeof(f.cmn_val_90[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_91, sizeof(f.cmn_val_91) / sizeof(f.cmn_val_91[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_92, sizeof(f.cmn_val_92) / sizeof(f.cmn_val_92[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_93, sizeof(f.cmn_val_93) / sizeof(f.cmn_val_93[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_08, sizeof(f.cmn_val_08) / sizeof(f.cmn_val_08[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_94, sizeof(f.cmn_val_94) / sizeof(f.cmn_val_94[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_95, sizeof(f.cmn_val_95) / sizeof(f.cmn_val_95[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_96, sizeof(f.cmn_val_96) / sizeof(f.cmn_val_96[0]));
    auto val10 = f.FUN_C197EEAE(f.cmn_val_97, sizeof(f.cmn_val_97) / sizeof(f.cmn_val_97[0]));
    auto val11 = f.FUN_C197EEAE(f.cmn_val_98, sizeof(f.cmn_val_98) / sizeof(f.cmn_val_98[0]));
    auto val12 = f.FUN_C197EEAE(f.cmn_val_99, sizeof(f.cmn_val_99) / sizeof(f.cmn_val_99[0]));
    auto val13 = f.FUN_C197EEAE(f.cmn_val_100, sizeof(f.cmn_val_100) / sizeof(f.cmn_val_100[0]));
    auto val14 = f.FUN_C197EEAE(f.cmn_val_10, sizeof(f.cmn_val_10) / sizeof(f.cmn_val_10[0]));
    auto val15 = f.FUN_C197EEAE(f.cmn_val_101, sizeof(f.cmn_val_101) / sizeof(f.cmn_val_101[0]));
    auto val16 = f.FUN_C197EEAE(f.cmn_val_102, sizeof(f.cmn_val_102) / sizeof(f.cmn_val_102[0]));

    //Get constants
    auto cs = (jstring)FUN_4148b2c9(env, val1.c_str(),val2.c_str(),val3.c_str());
    auto vpn = FUN_4F22ECB8(env, val4.c_str(),val5.c_str(),val6.c_str());

    //Get connectivityManager
    auto cm = FUN_2E8000B6(env, context, val7.c_str(), val8.c_str(), cs);

    //Get current networks
    auto networks = (jobjectArray)FUN_2E8000B6(env, cm, val9.c_str(), val10.c_str());
    auto size = env->GetArrayLength(networks);
    for (int i=0; i<size; i++)
    {
        //Get network capabilities
        auto network = env->GetObjectArrayElement(networks, i);
        auto caps = FUN_2E8000B6(env, cm, val11.c_str(), val12.c_str(), network);

        //Check VPN capability
        auto name = (jstring)FUN_2E8000B6(env, network, val13.c_str(), val14.c_str());
        if(FUN_5465B1EA(env, caps, val15.c_str(), val16.c_str(), vpn))
            return true;
    }
    return false;
}

/**
 * Get application context
 * @param env JNI object
 * @return application context
 */
jobject entries::FUN_0DCECDCB(JNIEnv *env){
    /// Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_29, sizeof(f.cmn_val_29) / sizeof(f.cmn_val_29[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_76, sizeof(f.cmn_val_76) / sizeof(f.cmn_val_76[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_77, sizeof(f.cmn_val_77) / sizeof(f.cmn_val_77[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_78, sizeof(f.cmn_val_78) / sizeof(f.cmn_val_78[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_79, sizeof(f.cmn_val_79) / sizeof(f.cmn_val_79[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_80, sizeof(f.cmn_val_80) / sizeof(f.cmn_val_80[0]));

    jobject appObj = entries::FUN_34369A67(env, val2.c_str(), val1.c_str(), val3.c_str());
    jobject baseContext = entries::FUN_2E8000B6(env, appObj, val4.c_str(), val5.c_str());
    return entries::FUN_2E8000B6(env, baseContext, val6.c_str(), val5.c_str());
}

/**
 * Set value for a key into shared preferences. Both key & value will be encrypted before saving
 * @param env JNI object
 * @param name Desired preferences file.
 * @param key The name of the preference to modify.
 * @param value The new value for the preference.
 * @return
 */
bool entries::FUN_DE4F0F56(JNIEnv *env, jstring name, jstring key, jstring value){

    /// Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_62, sizeof(f.cmn_val_62) / sizeof(f.cmn_val_62[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_63, sizeof(f.cmn_val_63) / sizeof(f.cmn_val_63[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_64, sizeof(f.cmn_val_64) / sizeof(f.cmn_val_64[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_65, sizeof(f.cmn_val_65) / sizeof(f.cmn_val_65[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_66, sizeof(f.cmn_val_66) / sizeof(f.cmn_val_66[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_67, sizeof(f.cmn_val_67) / sizeof(f.cmn_val_67[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_68, sizeof(f.cmn_val_68) / sizeof(f.cmn_val_68[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_69, sizeof(f.cmn_val_69) / sizeof(f.cmn_val_69[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_70, sizeof(f.cmn_val_70) / sizeof(f.cmn_val_70[0]));


    jobject context = FUN_0DCECDCB(env);
    jstring signature = env->NewStringUTF(FUN_F8BF6A3E(env, context, 0).c_str()) ;
    jstring algo = env->NewStringUTF(val1.c_str());

    jobject shared = FUN_2E8000B6(env, context, val2.c_str(), val3.c_str(), name, 0);
    jobject editorObj = FUN_2E8000B6(env, shared, val4.c_str(), val5.c_str());

    jstring encryptedKey = FUN_41821FFB(env, key, signature, algo, algo, 1);
    jstring encryptedValue = FUN_41821FFB(env, value, signature, algo, algo, 1);

    editorObj = FUN_2E8000B6(env, editorObj, val6.c_str(), val7.c_str(), encryptedKey,
                             encryptedValue);
    return FUN_5465B1EA(env, editorObj, val8.c_str(), val9.c_str());
}

/**
 * Get the value to which the specified key is mapped into preferences, or {@code null} if no
 * mapping found.
 * @param env JNI object
 * @param name Desired preferences file.
 * @param key The name of the preference to retrieve.
 * @return value for the preference.
 */
jstring entries::FUN_0330E9A3(JNIEnv *env, jstring name, jstring key){

    /// Indexes
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_62, sizeof(f.cmn_val_62) / sizeof(f.cmn_val_62[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_63, sizeof(f.cmn_val_63) / sizeof(f.cmn_val_63[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_64, sizeof(f.cmn_val_64) / sizeof(f.cmn_val_64[0]));
    auto val4 = f.FUN_C197EEAE(f.idx_cmn_30, sizeof(f.idx_cmn_30) / sizeof(f.idx_cmn_30[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_71, sizeof(f.cmn_val_71) / sizeof(f.cmn_val_71[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_72, sizeof(f.cmn_val_72) / sizeof(f.cmn_val_72[0]));
    auto val7 = f.FUN_C197EEAE(f.cmn_val_73, sizeof(f.cmn_val_73) / sizeof(f.cmn_val_73[0]));
    auto val8 = f.FUN_C197EEAE(f.cmn_val_74, sizeof(f.cmn_val_74) / sizeof(f.cmn_val_74[0]));
    auto val9 = f.FUN_C197EEAE(f.cmn_val_75, sizeof(f.cmn_val_75) / sizeof(f.cmn_val_75[0]));

    jstring algo = env->NewStringUTF(val1.c_str());
    jobject context = FUN_0DCECDCB(env);
    jstring signature = env->NewStringUTF(entries::FUN_F8BF6A3E(env, context, 0).c_str());
    jstring encryptedKey = FUN_41821FFB(env, key, signature, algo, algo, 1);

    jobject shared = FUN_2E8000B6(env, context, val2.c_str(), val3.c_str(), name, 0);

    auto isContain = FUN_5465B1EA(env, shared, val5.c_str(), val6.c_str(), encryptedKey);

    if(isContain){
        jobject mapObject = FUN_2E8000B6(env, shared, val7.c_str(), val8.c_str());
        auto encryptedValue = (jstring) FUN_2E8000B6(env, mapObject, val4.c_str(), val9.c_str(),
                                                     encryptedKey);
        return FUN_41821FFB(env, encryptedValue, signature, algo, algo, 2);
    }
    else
        return nullptr;
}

/**
 * Get the {@code int} value to which the specified key is mapped into preferences, or {@code null}
 * if no mapping found.
 * @param env JNI object
 * @param name Desired preferences file.
 * @param key The name of the preference to retrieve.
 * @return {@code int} value for the preference.
 */
jint entries::FUN_B9023215(JNIEnv *env, jstring name, jstring key){

    auto counter = FUN_0330E9A3(env, name, key);
    // convert String to int
    if(counter != nullptr){
        const char *counterAsString = env->GetStringUTFChars(counter, nullptr);
        return stoi(std::string(counterAsString));
    }
    else
        return -1 ;
}

std::string entries::FUN_B9023216(JNIEnv *env) {
    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_81, sizeof(f.cmn_val_81) / sizeof(f.cmn_val_81[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_82, sizeof(f.cmn_val_82) / sizeof(f.cmn_val_82[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_103, sizeof(f.cmn_val_103) / sizeof(f.cmn_val_103[0]));
    auto val4 = f.FUN_C197EEAE(f.cmn_val_104, sizeof(f.cmn_val_104) / sizeof(f.cmn_val_104[0]));
    auto val5 = f.FUN_C197EEAE(f.cmn_val_105, sizeof(f.cmn_val_105) / sizeof(f.cmn_val_105[0]));
    auto val6 = f.FUN_C197EEAE(f.cmn_val_106, sizeof(f.cmn_val_106) / sizeof(f.cmn_val_106[0]));

    /// Get version name
    auto version = FUN_3D9F333B(env);

    /// Get app name
    jstring appName;
    jobject context = FUN_0DCECDCB(env);
    jobject getAppInfo = FUN_2E8000B6(env, context, val1.c_str(), val2.c_str());
    jint labelRes = FUN_A5D8FCDF(env, getAppInfo, val3.c_str(), val4.c_str());

    if(labelRes == 0){
        auto localizedLabel = (jobject) FUN_AE948769(env, getAppInfo, "nonLocalizedLabel", "Ljava/lang/CharSequence;");
        appName = (jstring) entries::FUN_2E8000B6(env, localizedLabel, "toString", "()Ljava/lang/String;");
    }
    else {
        appName = (jstring) FUN_2E8000B6(env, context, val5.c_str(), val6.c_str(), labelRes);
    }

    const auto *appNameByte = reinterpret_cast<const jbyte *>(env->GetStringUTFChars(appName,
                                                                                     nullptr));
    const auto *versionByte = reinterpret_cast<const jbyte *>(env->GetStringUTFChars(version,
                                                                                     nullptr));
    char *concatenated = static_cast<char *>(malloc(
            strlen(reinterpret_cast<const char *const>(appNameByte)) + strlen("/") + strlen(
                    reinterpret_cast<const char *const>(versionByte)) + 1));
    strcpy(concatenated, reinterpret_cast<const char *>(appNameByte));
    strcat(concatenated, "/");
    strcat(concatenated, reinterpret_cast<const char *>(versionByte));
    // return appName

    // convert *char to std:string
    std::string str(concatenated);
    return concatenated;
}

std::string entries::FUN_4148b2e4(JNIEnv *env, jstring jStr) {

    entries f;
    auto val1 = f.FUN_C197EEAE(f.cmn_val_32, sizeof(f.cmn_val_32) / sizeof(f.cmn_val_32[0]));
    auto val2 = f.FUN_C197EEAE(f.cmn_val_51, sizeof(f.cmn_val_51) / sizeof(f.cmn_val_51[0]));
    auto val3 = f.FUN_C197EEAE(f.cmn_val_52, sizeof(f.cmn_val_52) / sizeof(f.cmn_val_52[0]));

    jbyteArray stringJbytes = (jbyteArray) FUN_2E8000B6(env,jStr,val1.c_str(), val2.c_str(),env->NewStringUTF(val3.c_str()));
    jbyte* pBytes = env->GetByteArrayElements(stringJbytes, nullptr);
    std::string ret = std::string((char *)pBytes, env->GetArrayLength(stringJbytes));
    env->ReleaseByteArrayElements(stringJbytes, pBytes, JNI_ABORT);
    env->DeleteLocalRef(stringJbytes);
    return ret;
}