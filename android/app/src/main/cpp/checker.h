//
// Created by Kamel.OULEBSIR on 10/10/2022.
//

#ifndef DJEZZYINTERNET_CHECKER_H
#define DJEZZYINTERNET_CHECKER_H

#include <vector>

#define NUM_LIBS   1
#define MAX_LINE   512
#define MAX_LENGTH 256

#define LIBC "libc.so"
#define PROPERTY_VALUE_MAX  92

static const char *PROC_MAPS = "/proc/self/maps";
static const char *FRIDA_THREAD_GMAIN = "gmain";

static const char *FRIDA_THREAD_GUM_JS_LOOP = "gum-js-loop";
static const char *FRIDA_NAMEDPIPE_LINJECTOR = "linjector";
static const char *PROC_STATUS = "/proc/self/task/%s/status";
static const char *PROC_FD = "/proc/self/fd";
static const char *PROC_TASK = "/proc/self/task";

/// com.noshufou.android.su
const long cmn_cst_01[23] = { 2,14,12,63,13,14,17,7,20,5,14,20,63,0,13,3,18,14,8,3,63,17,20 };
/// eu.chainfire.supersu
const long cmn_cst_02[20] = { 4,20,63,2,7,0,8,13,5,8,18,4,63,17,20,15,4,18,17,20 };
/// com.koushikdutta.superuser
const long cmn_cst_03[26] = { 2,14,12,63,10,14,20,17,7,8,10,3,20,19,19,0,63,17,20,15,4,18,20,17,4,18 };
/// com.thirdparty.superuser
const long cmn_cst_04[24] = { 2,14,12,63,19,7,8,18,3,15,0,18,19,24,63,17,20,15,4,18,20,17,4,18 };
/// com.yellowes.su
const long cmn_cst_05[15] = { 2,14,12,63,24,4,11,11,14,22,4,17,63,17,20 };
/// com.topjohnwu.magisk
const long cmn_cst_06[20] = { 2,14,12,63,19,14,15,9,14,7,13,22,20,63,12,0,6,8,17,10 };
/// com.kingroot.kinguser
const long cmn_cst_07[21] = { 2,14,12,63,10,8,13,6,18,14,14,19,63,10,8,13,6,20,17,4,18 };
/// com.kingo.root
const long cmn_cst_08[14] = { 2,14,12,63,10,8,13,6,14,63,18,14,14,19 };
/// com.smedialink.oneclickroot
const long cmn_cst_09[27] = { 2,14,12,63,17,12,4,3,8,0,11,8,13,10,63,14,13,4,2,11,8,2,10,18,14,14,19 };
/// com.zhiqupk.root.global
const long cmn_cst_10[23] = { 2,14,12,63,25,7,8,16,20,15,10,63,18,14,14,19,63,6,11,14,1,0,11 };
/// com.alephzain.framaroot
const long cmn_cst_11[23] = { 2,14,12,63,0,11,4,15,7,25,0,8,13,63,5,18,0,12,0,18,14,14,19 };
/// com.koushikdutta.rommanager
const long cmn_cst_12[27] = { 2,14,12,63,10,14,20,17,7,8,10,3,20,19,19,0,63,18,14,12,12,0,13,0,6,4,18 };
/// com.dimonvideo.luckypatcher
const long cmn_cst_13[27] = { 2,14,12,63,3,8,12,14,13,21,8,3,4,14,63,11,20,2,10,24,15,0,19,2,7,4,18 };
/// com.chelpus.lackypatch
const long cmn_cst_14[22] = { 2,14,12,63,2,7,4,11,15,20,17,63,11,0,2,10,24,15,0,19,2,7 };
/// com.ramdroid.appquarantine
const long cmn_cst_15[26] = { 2,14,12,63,18,0,12,3,18,14,8,3,63,0,15,15,16,20,0,18,0,13,19,8,13,4 };
/// com.android.vending.billing.InAppBillingService
const long cmn_cst_16[47] = { 2,14,12,63,0,13,3,18,14,8,3,63,21,4,13,3,8,13,6,63,1,8,11,11,8,13,6,63,34,13,26,15,15,27,8,11,11,8,13,6,43,4,18,21,8,2,4 };
/// com.chelpus.luckypatcher
const long cmn_cst_17[24] = { 2,14,12,63,2,7,4,11,15,20,17,63,11,20,2,10,24,15,0,19,2,7,4,18 };
/// com.blackmartalpha
const long cmn_cst_18[18] = { 2,14,12,63,1,11,0,2,10,12,0,18,19,0,11,15,7,0 };
/// org.blackmart.market
const long cmn_cst_19[20] = { 14,18,6,63,1,11,0,2,10,12,0,18,19,63,12,0,18,10,4,19 };
/// com.allinone.free
const long cmn_cst_20[17] = { 2,14,12,63,0,11,11,8,13,14,13,4,63,5,18,4,4 };
/// com.repodroid.app
const long cmn_cst_21[17] = { 2,14,12,63,18,4,15,14,3,18,14,8,3,63,0,15,15 };
/// org.creeplays.hack
const long cmn_cst_22[18] = { 14,18,6,63,2,18,4,4,15,11,0,24,17,63,7,0,2,10 };
/// com.baseappfull.fwd
const long cmn_cst_23[19] = { 2,14,12,63,1,0,17,4,0,15,15,5,20,11,11,63,5,22,3 };
/// com.zmapp
const long cmn_cst_24[9] = { 2,14,12,63,25,12,0,15,15 };
/// com.dv.marketmod.installer
const long cmn_cst_25[26] = { 2,14,12,63,3,21,63,12,0,18,10,4,19,12,14,3,63,8,13,17,19,0,11,11,4,18 };
/// org.mobilism.android
const long cmn_cst_26[20] = { 14,18,6,63,12,14,1,8,11,8,17,12,63,0,13,3,18,14,8,3 };
/// com.android.wp.net.log
const long cmn_cst_27[22] = { 2,14,12,63,0,13,3,18,14,8,3,63,22,15,63,13,4,19,63,11,14,6 };
/// com.android.camera.update
const long cmn_cst_28[25] = { 2,14,12,63,0,13,3,18,14,8,3,63,2,0,12,4,18,0,63,20,15,3,0,19,4 };
/// cc.madkite.freedom
const long cmn_cst_29[18] = { 2,2,63,12,0,3,10,8,19,4,63,5,18,4,4,3,14,12 };
/// com.solohsu.android.edxp.manager
const long cmn_cst_30[32] = { 2,14,12,63,17,14,11,14,7,17,20,63,0,13,3,18,14,8,3,63,4,3,23,15,63,12,0,13,0,6,4,18 };
/// org.meowcat.edxposed.manager
const long cmn_cst_31[28] = { 14,18,6,63,12,4,14,22,2,0,19,63,4,3,23,15,14,17,4,3,63,12,0,13,0,6,4,18 };
/// com.xmodgame
const long cmn_cst_32[12] = { 2,14,12,63,23,12,14,3,6,0,12,4 };
/// com.cih.game_cih
const long cmn_cst_33[16] = { 2,14,12,63,2,8,7,63,6,0,12,4,62,2,8,7 };
/// com.charles.lpoqasert
const long cmn_cst_34[21] = { 2,14,12,63,2,7,0,18,11,4,17,63,11,15,14,16,0,17,4,18,19 };
/// catch_.me_.if_.you_.can_
const long cmn_cst_35[24] = { 2,0,19,2,7,62,63,12,4,62,63,8,5,62,63,24,14,20,62,63,2,0,13,62 };
/// com.devadvance.rootcloak
const long cmn_cst_36[24] = { 2,14,12,63,3,4,21,0,3,21,0,13,2,4,63,18,14,14,19,2,11,14,0,10 };
/// com.devadvance.rootcloakplus
const long cmn_cst_37[28] = { 2,14,12,63,3,4,21,0,3,21,0,13,2,4,63,18,14,14,19,2,11,14,0,10,15,11,20,17 };
/// de.robv.android.xposed.installer
const long cmn_cst_38[32] = { 3,4,63,18,14,1,21,63,0,13,3,18,14,8,3,63,23,15,14,17,4,3,63,8,13,17,19,0,11,11,4,18 };
/// com.saurik.substrate
const long cmn_cst_39[20] = { 2,14,12,63,17,0,20,18,8,10,63,17,20,1,17,19,18,0,19,4 };
/// com.zachspong.temprootremovejb
const long cmn_cst_40[30] = { 2,14,12,63,25,0,2,7,17,15,14,13,6,63,19,4,12,15,18,14,14,19,18,4,12,14,21,4,9,1 };
/// com.amphoras.hidemyroot
const long cmn_cst_41[23] = { 2,14,12,63,0,12,15,7,14,18,0,17,63,7,8,3,4,12,24,18,14,14,19 };
/// com.amphoras.hidemyrootadfree
const long cmn_cst_42[29] = { 2,14,12,63,0,12,15,7,14,18,0,17,63,7,8,3,4,12,24,18,14,14,19,0,3,5,18,4,4 };
/// com.formyhm.hiderootPremium
const long cmn_cst_43[27] = { 2,14,12,63,5,14,18,12,24,7,12,63,7,8,3,4,18,14,14,19,41,18,4,12,8,20,12 };
/// com.formyhm.hideroot
const long cmn_cst_44[20] = { 2,14,12,63,5,14,18,12,24,7,12,63,7,8,3,4,18,14,14,19 };

///[Confirmed] /system/xbin/
const long cmn_cst_45[13] = { 64,17,24,17,19,4,12,64,23,1,8,13,64 };
/// /su/bin/su
const long cmn_cst_46[10] = { 64,17,20,64,1,8,13,64,17,20 };
/// /system/app/
const long cmn_cst_47[12] = { 64,17,24,17,19,4,12,64,0,15,15,64 };
///[Confirmed] /sbin/su
const long cmn_cst_48[8] = { 64,17,1,8,13,64,17,20 };
///[Confirmed] /system/bin/
const long cmn_cst_49[12] = { 64,17,24,17,19,4,12,64,1,8,13,64 };
/// /data/local/xbin/su
const long cmn_cst_50[19] = { 64,3,0,19,0,64,11,14,2,0,11,64,23,1,8,13,64,17,20 };
/// /data/local/bin/su
const long cmn_cst_51[18] = { 64,3,0,19,0,64,11,14,2,0,11,64,1,8,13,64,17,20 };
/// /system/sd/xbin/su
const long cmn_cst_52[18] = { 64,17,24,17,19,4,12,64,17,3,64,23,1,8,13,64,17,20 };
/// /system/bin/failsafe/su
const long cmn_cst_53[23] = { 64,17,24,17,19,4,12,64,1,8,13,64,5,0,8,11,17,0,5,4,64,17,20 };
/// /data/local/su
const long cmn_cst_54[14] = { 64,3,0,19,0,64,11,14,2,0,11,64,17,20 };

/// su
const long cmn_cst_55[2] = { 17,20 };
/// daemonsu
const long cmn_val_56[8] = { 3,0,4,12,14,13,17,20 };
/// Superuser.apk
const long cmn_val_57[13] = { 43,20,15,4,18,20,17,4,18,63,0,15,10 };

/// pm list packages | grep
const long cmn_val_58[24] = { 15,12,77,11,8,17,19,77,15,0,2,10,0,6,4,17,77,66,77,6,18,4,15,77 };

/// {"apps":
const long cmn_cst_90[8] = { 80,82,0,15,15,17,82,76 };
/// ,"paths":
const long cmn_cst_91[9] = { 78,82,15,0,19,7,17,82,76 };
/// }
const long cmn_cst_92[1] = { 81 };

//Structure to hold the details of executable section of library
typedef struct stExecSection {
    int execSectionCount;
    unsigned long offset[2];
    unsigned long memsize[2];
    unsigned long checksum[2];
    unsigned long startAddrinMem;
} execSection;

typedef struct prop_area prop_area;struct prop_area {
    unsigned volatile count;
    unsigned volatile serial;
    unsigned magic;
    unsigned version;
    unsigned reserved[4];
    unsigned toc[1];
};

[[noreturn]] void* looper(void* args);
static std::string process1();
static std::string process2();

/// Frida detection methods
static void getFilePaths(char **filePaths);
static bool fetchChecksum(const char *filePath, execSection **pTextSection);
static void compareMemDisk();
static bool scanSegments(char *map, execSection *pElfSectArr, const char *libraryName);

/// Root detection methods
static bool pm(char const *package);
static bool open(char const *path);
static bool stat(char const *path);
static bool fstream(char const *path);
static bool runsu(char const *command);
static bool ls(char const *path, char const *name);

#endif //DJEZZYINTERNET_CHECKER_H
