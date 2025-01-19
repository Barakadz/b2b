#include <jni.h>
#include <string>
#include <cstdio>
#include <cstring>
#include <cstdint>
#include <unistd.h>
#include <malloc.h>
#include "entries.h"
#include "checker.h"
#include <sys/system_properties.h>

extern "C"
{
JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* reserved) {
    JNIEnv* env;
    auto version = JNI_VERSION_1_6;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), version) != JNI_OK || env==nullptr)
        return JNI_ERR;

    // Check debug mode
    //exit(-1);
#ifdef NDEBUG
    jobject context = entries::FUN_0DCECDCB(env);
    auto res1 = entries::FUN_138CD463(env, context);
    auto res2 = entries::FUN_4148B2C0(env, context);
    if(res1 || res2)
        exit(-1);
#endif

    // Return JNI version
    return version;
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F90a64e59(JNIEnv *env, jobject instance) {
    return env->NewStringUTF(entries::FUN_B9023216(env).c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F94027e6f(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes1, sizeof(f.indexes1) / sizeof(f.indexes1[0]));

    int size = 1;
    std::string keys[size];
    keys[0] = "locale";
    f.FUN_20C720BD(keys, 1, size);

    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F0ca8c48e(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes2, sizeof(f.indexes2) / sizeof(f.indexes2[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F49c4f779(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes3, sizeof(f.indexes3) / sizeof(f.indexes3[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fe8ed80d7(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes4, sizeof(f.indexes4) / sizeof(f.indexes4[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Ff07c6783(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes5, sizeof(f.indexes5) / sizeof(f.indexes5[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F624ec337(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes6, sizeof(f.indexes6) / sizeof(f.indexes6[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Ffa442cd3(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url1);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fe54a2fc7(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url2);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F48628b49(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url3);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fe0c2ae9e(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url4);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F1b0745bf(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url5);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F6ee05df9(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url6);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fbdef6330(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url7);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fd12f231c(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url8);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fd72d49da(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url9);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F04ab60bc(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url10);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fccd83952(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url11);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fee12c08d(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url12);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F59dfb1c0(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url13);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fd6e3c01b(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url14);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F604668e1(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url15);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F6fe11bc8(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url16);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fab2b0e09(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url17);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F7406ff09(JNIEnv *env, __unused jobject thiz) {
    return env->NewStringUTF(entries::url18);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F4148be56(JNIEnv *env, jobject instance) {
    return (env)->NewStringUTF( entries::url19);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_F3c7164c2(JNIEnv *env, __unused jobject thiz) {

    //Populate data
    entries f;
    std::string entry = f.FUN_C197EEAE(f.indexes7, sizeof(f.indexes7) / sizeof(f.indexes7[0]));
    //Return data
    return env->NewStringUTF(entry.c_str());
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fcda93ebb(JNIEnv *env, __unused jobject instance) {

    /// Get Init entries
    entries f;
    std::string val;

    auto val0 = f.FUN_C197EEAE(f.cmn_val_107, sizeof(f.cmn_val_107) / sizeof(f.cmn_val_107[0]));
    auto val1 = f.FUN_C197EEAE(f.cmn_val_108, sizeof(f.cmn_val_108) / sizeof(f.cmn_val_108[0]));

    /// Get application context
    jobject context = entries::FUN_0DCECDCB(env);

    /// Get |
    std::string idx_cmn_00 = f.FUN_C197EEAE(f.idx_spl_00,sizeof(f.idx_spl_00) / sizeof(f.idx_spl_00[0]));

    /// Get & add datetime
    val += entries::FUN_11F860EC() + idx_cmn_00;

    /// Get & add platform name
    std::string idx_cmn_23 = f.FUN_C197EEAE(f.idx_cmn_31,sizeof(f.idx_cmn_31) / sizeof(f.idx_cmn_31[0]));
    val += idx_cmn_23 + idx_cmn_00;

    /// Get & add application version
    val += entries::FUN_3D9F333A(env) + idx_cmn_00;

    /// Get & add installer info
    val += entries::FUN_76C8CBBD(env, context) + idx_cmn_00;

    /// Get & add debug mode
    std::string idx_cmn_51 = f.FUN_C197EEAE(f.idx_cmn_51,sizeof(f.idx_cmn_51) / sizeof(f.idx_cmn_51[0]));
    val += idx_cmn_51 + idx_cmn_00;

    /// Get & add msisdn
    std::string idx_cmn_20 = f.FUN_C197EEAE(f.idx_cmn_20,sizeof(f.idx_cmn_20) / sizeof(f.idx_cmn_20[0]));
    val += entries::FUN_0692317F(env, context, env->NewStringUTF(idx_cmn_20.c_str())) + idx_cmn_00;

    /// Get & add access token
    std::string idx_cmn_21 = f.FUN_C197EEAE(f.idx_cmn_21,sizeof(f.idx_cmn_21) / sizeof(f.idx_cmn_21[0]));
    val += entries::FUN_0692317F(env, context, env->NewStringUTF(idx_cmn_21.c_str())) + idx_cmn_00;

    /// Get & add Signature
    val += entries::FUN_F8BF6A3E(env, context, 0) + idx_cmn_00;

    /// Get & add version incremental
    std::string idx_cmn_03 = f.FUN_C197EEAE(f.idx_cmn_03,sizeof(f.idx_cmn_03) / sizeof(f.idx_cmn_03[0]));
    val += entries::FUN_A432617E(idx_cmn_03.c_str()) + idx_cmn_00;

    /// Get & add version release
    std::string idx_cmn_04 = f.FUN_C197EEAE(f.idx_cmn_04,sizeof(f.idx_cmn_04) / sizeof(f.idx_cmn_04[0]));
    val += entries::FUN_A432617E(idx_cmn_04.c_str()) + idx_cmn_00;

    /// Get & add version sdk
    std::string idx_cmn_05 = f.FUN_C197EEAE(f.idx_cmn_05,sizeof(f.idx_cmn_05) / sizeof(f.idx_cmn_05[0]));
    val += entries::FUN_A432617E(idx_cmn_05.c_str()) + idx_cmn_00;

    /// Get & add version codename
    std::string idx_cmn_06 = f.FUN_C197EEAE(f.idx_cmn_06,sizeof(f.idx_cmn_06) / sizeof(f.idx_cmn_06[0]));
    val += entries::FUN_A432617E(idx_cmn_06.c_str()) + idx_cmn_00;

    /// Get & add ro.build.fingerprint
    std::string idx_cmn_07 = f.FUN_C197EEAE(f.idx_cmn_07,sizeof(f.idx_cmn_07) / sizeof(f.idx_cmn_07[0]));
    val += entries::FUN_A432617E(idx_cmn_07.c_str()) + idx_cmn_00;

    /// Get & add ro.build.host
    std::string idx_cmn_08 = f.FUN_C197EEAE(f.idx_cmn_08,sizeof(f.idx_cmn_08) / sizeof(f.idx_cmn_08[0]));
    val += entries::FUN_A432617E(idx_cmn_08.c_str()) + idx_cmn_00;

    /// Get & add ro.build.type
    std::string idx_cmn_09 = f.FUN_C197EEAE(f.idx_cmn_09,sizeof(f.idx_cmn_09) / sizeof(f.idx_cmn_09[0]));
    val += entries::FUN_A432617E(idx_cmn_09.c_str()) + idx_cmn_00;

    /// Get & add ro.build.tags
    std::string idx_cmn_10 = f.FUN_C197EEAE(f.idx_cmn_10,sizeof(f.idx_cmn_10) / sizeof(f.idx_cmn_10[0]));
    val += entries::FUN_A432617E(idx_cmn_10.c_str()) + idx_cmn_00;

    /// Get & add ro.build.id
    std::string idx_cmn_11 = f.FUN_C197EEAE(f.idx_cmn_11,sizeof(f.idx_cmn_11) / sizeof(f.idx_cmn_11[0]));
    val += entries::FUN_A432617E(idx_cmn_11.c_str()) + idx_cmn_00;

    /// Get & add ro.product.brand
    std::string idx_cmn_12 = f.FUN_C197EEAE(f.idx_cmn_12,sizeof(f.idx_cmn_12) / sizeof(f.idx_cmn_12[0]));
    val += entries::FUN_A432617E(idx_cmn_12.c_str()) + idx_cmn_00;

    /// Get ro.product.board
    std::string idx_cmn_13 = f.FUN_C197EEAE(f.idx_cmn_13,sizeof(f.idx_cmn_13) / sizeof(f.idx_cmn_13[0]));
    val += entries::FUN_A432617E(idx_cmn_13.c_str()) + idx_cmn_00;

    /// Get ro.product.manufacturer
    std::string idx_cmn_14 = f.FUN_C197EEAE(f.idx_cmn_14,sizeof(f.idx_cmn_14) / sizeof(f.idx_cmn_14[0]));
    val += entries::FUN_A432617E(idx_cmn_14.c_str()) + idx_cmn_00;

    /// Get ro.product.model
    std::string idx_cmn_15 = f.FUN_C197EEAE(f.idx_cmn_15,sizeof(f.idx_cmn_15) / sizeof(f.idx_cmn_15[0]));
    val += entries::FUN_A432617E(idx_cmn_15.c_str()) + idx_cmn_00;

    /// Get ro.product.device
    std::string idx_cmn_16 = f.FUN_C197EEAE(f.idx_cmn_16,sizeof(f.idx_cmn_16) / sizeof(f.idx_cmn_16[0]));
    val += entries::FUN_A432617E(idx_cmn_16.c_str()) + idx_cmn_00;

    /// Get ro.product.user
    std::string idx_cmn_17 = f.FUN_C197EEAE(f.idx_cmn_17,sizeof(f.idx_cmn_17) / sizeof(f.idx_cmn_17[0]));
    val += entries::FUN_A432617E(idx_cmn_17.c_str()) + idx_cmn_00;

    /// Get ro.product.name
    std::string idx_cmn_18 = f.FUN_C197EEAE(f.idx_cmn_18,sizeof(f.idx_cmn_18) / sizeof(f.idx_cmn_18[0]));
    val += entries::FUN_A432617E(idx_cmn_18.c_str()) + idx_cmn_00;

    /// Get ro.hardware
    std::string idx_cmn_19 = f.FUN_C197EEAE(f.idx_cmn_19,sizeof(f.idx_cmn_19) / sizeof(f.idx_cmn_19[0]));
    val += entries::FUN_A432617E(idx_cmn_19.c_str()) + idx_cmn_00;

    /// Get package name
    std::string idx_spl_02 = f.FUN_C197EEAE(f.idx_spl_02,sizeof(f.idx_spl_02) / sizeof(f.idx_spl_02[0]));
    val += entries::FUN_CE8B479D(idx_spl_02.c_str()) + idx_cmn_00;

    /// Get application path
    val += entries::FUN_6F8A4DE6(env, context) + idx_cmn_00;

    /// Get & add root detection result
    val += entries::FUN_E9F2740A() + idx_cmn_00;

    /// Get & add user-agent
    val += entries::FUN_B9023216(env) + idx_cmn_00;

    /// Generate encryption key
    jstring key = f.FUN_DE8EC5F5(env,env->NewStringUTF(val0.c_str()));

    /// encrypt the fingerprint result
    jstring encryptedText = entries::FUN_41821FFB(env,env->NewStringUTF(val.c_str()),key,env->NewStringUTF(val0.c_str()),env->NewStringUTF(val1.c_str()),1);

    /// concat key & encrypted fingerprint
    auto fingerprint = entries::FUN_4148b2e4(env, encryptedText) + "." + entries::FUN_4148b2e4(env, key);

    /// remove white spaces
    remove_if(fingerprint.begin(), fingerprint.end(), isspace);

    /// global encryption key
    std::string globalKey =entries::FUN_0692317F(env, context, env->NewStringUTF(idx_cmn_20.c_str()));
    globalKey += entries::FUN_4148b2e4(env, entries::FUN_3D9F333B(env));
    globalKey += entries::FUN_0692317F(env, context, env->NewStringUTF(idx_cmn_21.c_str()));

    /// return csrf token
    jstring globalFingerprint = entries::FUN_41821FFB(env,env->NewStringUTF(fingerprint.c_str()),env->NewStringUTF(globalKey.c_str()),env->NewStringUTF(val0.c_str()),env->NewStringUTF(val1.c_str()),1);
    return globalFingerprint;
}

JNIEXPORT jint JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb35(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string val1 = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));
    std::string val2 = f.FUN_C197EEAE(f.cmn_val_88, sizeof(f.cmn_val_88) / sizeof(f.cmn_val_88[0]));

    //Return result
    return entries::FUN_B9023215(env, env->NewStringUTF(val1.c_str()), env->NewStringUTF(val2.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_F315e5837(JNIEnv *env, __unused jobject instance, jint counter) {

    //Get values
    entries f;
    std::string val1 = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));
    std::string val2 = f.FUN_C197EEAE(f.cmn_val_88, sizeof(f.cmn_val_88) / sizeof(f.cmn_val_88[0]));

    //Return result
    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val1.c_str()),
                                 env->NewStringUTF(val2.c_str()),
                                 env->NewStringUTF(std::to_string(counter).c_str()));
}

JNIEXPORT jint JNICALL
Java_com_djezzy_b2b_internet_Constants_F6ef01974(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string val1 = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));
    std::string val2 = f.FUN_C197EEAE(f.cmn_val_87, sizeof(f.cmn_val_87) / sizeof(f.cmn_val_87[0]));

    //Return result
    jint result = entries::FUN_B9023215(env,
                                        env->NewStringUTF(val1.c_str()),
                                        env->NewStringUTF(val2.c_str()));
    return result != -1 ? result : 0;
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fa0ab31e1(JNIEnv *env, __unused jobject instance, jint counter) {

    //Get values
    entries f;
    std::string val1 = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));
    std::string val2 = f.FUN_C197EEAE(f.cmn_val_87, sizeof(f.cmn_val_87) / sizeof(f.cmn_val_87[0]));

    //Return result
    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val1.c_str()),
                                 env->NewStringUTF(val2.c_str()),
                                 env->NewStringUTF(std::to_string(counter).c_str()));
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fda936f3e(JNIEnv *env, __unused jobject instance, jstring text, jstring key,jstring generatorAlgo, jstring cipherAlgo, jint mode) {
    return entries::FUN_41821FFB(env, text, key, generatorAlgo, cipherAlgo, mode);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fa0a9bc91(JNIEnv *env, __unused jobject instance, jstring algo) {
    return entries::FUN_DE8EC5F5(env, algo);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb40(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_20, sizeof(f.idx_cmn_20) / sizeof(f.idx_cmn_20[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb41(JNIEnv *env, __unused jobject instance, jstring value) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_20, sizeof(f.idx_cmn_20) / sizeof(f.idx_cmn_20[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()),
                                 value);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb42(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_21, sizeof(f.idx_cmn_21) / sizeof(f.idx_cmn_21[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb43(JNIEnv *env, __unused jobject instance, jstring value) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_21, sizeof(f.idx_cmn_21) / sizeof(f.idx_cmn_21[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()),
                                 value);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb44(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_23, sizeof(f.idx_cmn_23) / sizeof(f.idx_cmn_23[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb45(JNIEnv *env, __unused jobject instance, jstring value) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_23, sizeof(f.idx_cmn_23) / sizeof(f.idx_cmn_23[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()),
                                 value);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb46(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_22, sizeof(f.idx_cmn_22) / sizeof(f.idx_cmn_22[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb47(JNIEnv *env, __unused jobject instance, jstring value) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_22, sizeof(f.idx_cmn_22) / sizeof(f.idx_cmn_22[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()),
                                 value);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb48(JNIEnv *env, __unused jobject instance) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_25, sizeof(f.idx_cmn_25) / sizeof(f.idx_cmn_25[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()));
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb49(JNIEnv *env, __unused jobject instance, jstring value) {

    //Get values
    entries f;
    std::string key = f.FUN_C197EEAE(f.idx_cmn_25, sizeof(f.idx_cmn_25) / sizeof(f.idx_cmn_25[0]));
    std::string val = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(val.c_str()),
                                 env->NewStringUTF(key.c_str()),
                                 value);
}

JNIEXPORT jstring JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb50(JNIEnv *env, __unused jobject instance, jstring key) {

    //Get values
    entries f;
    std::string name = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_0330E9A3(env,
                                 env->NewStringUTF(name.c_str()),
                                 key);
}

JNIEXPORT jboolean JNICALL
Java_com_djezzy_b2b_internet_Constants_Fb8c0bb51(JNIEnv *env, __unused jobject instance, jstring key, jstring value) {

    //Get values
    entries f;
    std::string name = f.FUN_C197EEAE(f.cmn_val_86, sizeof(f.cmn_val_86) / sizeof(f.cmn_val_86[0]));

    return entries::FUN_DE4F0F56(env,
                                 env->NewStringUTF(name.c_str()),
                                 key,
                                 value);
}
}