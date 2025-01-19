#include <jni.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <malloc.h>
#include <unistd.h>
#include <pthread.h>
#include <fcntl.h>
#include <elf.h>
#include <dirent.h>
#include <cctype>
#include <sstream>
#include <fstream>

#include <cerrno>
#include "checker.h"
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <asm/unistd.h>
#include <android/log.h>
#include <sys/system_properties.h>

#include "clib.h"
#include "entries.h"

#ifdef _32_BIT
    typedef Elf32_Ehdr Elf_Ehdr;
    typedef Elf32_Shdr Elf_Shdr;
#elif _64_BIT
    typedef Elf64_Ehdr Elf_Ehdr;
    typedef Elf64_Shdr Elf_Shdr;
#endif

static execSection *elfSectionArr[NUM_LIBS] = { nullptr };
static const char *libstocheck[NUM_LIBS] = { "libnativeegl.so" };

__attribute__((constructor))
void launch() {

    /// Get files path
    char *filePaths[NUM_LIBS];
    getFilePaths(filePaths);
    for (int i = 0; i < NUM_LIBS; i++)
    {
        fetchChecksum(filePaths[i], &elfSectionArr[i]);
        filePaths[i] = nullptr;
    }

    /// Launch thread loop
    pthread_t t;
    pthread_create(&t, nullptr, &looper, nullptr);
}

[[noreturn]] void* looper(void* args) {
    entries f;
    auto val1 = f.FUN_C197EEAE(cmn_cst_90, sizeof(cmn_cst_90) / sizeof(cmn_cst_90[0]));
    auto val3 = f.FUN_C197EEAE(cmn_cst_91, sizeof(cmn_cst_91) / sizeof(cmn_cst_91[0]));
    auto val4 = f.FUN_C197EEAE(cmn_cst_92, sizeof(cmn_cst_92) / sizeof(cmn_cst_92[0]));

    struct timespec timer{};
    timer.tv_nsec = 0;
    timer.tv_sec  = 30;
    while (true)
    {
        /// Check root
        std::string result =val1;
        result += process1() + val3;
        result += process2() + val4;

        /// Check frida
        compareMemDisk();
        //detect_frida_threads();
        //detect_frida_namedpipe();

        /// Save result into file
        LOGE("ROOT CHECK // runls result: %s", result.c_str());
        entries::FUN_97627150(result);

        /// Sleep for "tv_sec" seconds currently configured for 30 secs
        nanosleep(&timer, nullptr);
    }
}

std::string process1(){

    //Init
    entries f;
    std::string apps = "[";

    //Check root apps
    auto app1 = f.FUN_C197EEAE(cmn_cst_01, sizeof(cmn_cst_01) / sizeof(cmn_cst_01[0]));
    auto app2 = f.FUN_C197EEAE(cmn_cst_02, sizeof(cmn_cst_02) / sizeof(cmn_cst_02[0]));
    auto app3 = f.FUN_C197EEAE(cmn_cst_03, sizeof(cmn_cst_03) / sizeof(cmn_cst_03[0]));
    auto app4 = f.FUN_C197EEAE(cmn_cst_04, sizeof(cmn_cst_04) / sizeof(cmn_cst_04[0]));
    auto app5 = f.FUN_C197EEAE(cmn_cst_05, sizeof(cmn_cst_05) / sizeof(cmn_cst_05[0]));
    auto app6 = f.FUN_C197EEAE(cmn_cst_06, sizeof(cmn_cst_06) / sizeof(cmn_cst_06[0]));
    auto app7 = f.FUN_C197EEAE(cmn_cst_07, sizeof(cmn_cst_07) / sizeof(cmn_cst_07[0]));
    auto app8 = f.FUN_C197EEAE(cmn_cst_08, sizeof(cmn_cst_08) / sizeof(cmn_cst_08[0]));
    auto app9 = f.FUN_C197EEAE(cmn_cst_09, sizeof(cmn_cst_09) / sizeof(cmn_cst_09[0]));
    auto app10 = f.FUN_C197EEAE(cmn_cst_10, sizeof(cmn_cst_10) / sizeof(cmn_cst_10[0]));
    auto app11 = f.FUN_C197EEAE(cmn_cst_11, sizeof(cmn_cst_11) / sizeof(cmn_cst_11[0]));
    const char* rootApps[] = {
            app1.c_str(),
            app2.c_str(),
            app3.c_str(),
            app4.c_str(),
            app5.c_str(),
            app6.c_str(),
            app7.c_str(),
            app8.c_str(),
            app9.c_str(),
            app10.c_str(),
            app11.c_str()
    };
    for (const char *app:rootApps)
    {
        bool installed = pm(app);
        if(installed)
            apps += (apps.size()<=1 ? "\"" : ",\"") + std::string(app) + "\"";
    }

    // Check dangerous apps
    auto app12 = f.FUN_C197EEAE(cmn_cst_12, sizeof(cmn_cst_12) / sizeof(cmn_cst_12[0]));
    auto app13 = f.FUN_C197EEAE(cmn_cst_13, sizeof(cmn_cst_13) / sizeof(cmn_cst_13[0]));
    auto app14 = f.FUN_C197EEAE(cmn_cst_14, sizeof(cmn_cst_14) / sizeof(cmn_cst_14[0]));
    auto app15 = f.FUN_C197EEAE(cmn_cst_15, sizeof(cmn_cst_15) / sizeof(cmn_cst_15[0]));
    auto app16 = f.FUN_C197EEAE(cmn_cst_16, sizeof(cmn_cst_16) / sizeof(cmn_cst_16[0]));
    auto app17 = f.FUN_C197EEAE(cmn_cst_17, sizeof(cmn_cst_17) / sizeof(cmn_cst_17[0]));
    auto app18 = f.FUN_C197EEAE(cmn_cst_18, sizeof(cmn_cst_18) / sizeof(cmn_cst_18[0]));
    auto app19 = f.FUN_C197EEAE(cmn_cst_19, sizeof(cmn_cst_19) / sizeof(cmn_cst_19[0]));
    auto app20 = f.FUN_C197EEAE(cmn_cst_20, sizeof(cmn_cst_20) / sizeof(cmn_cst_20[0]));
    auto app21 = f.FUN_C197EEAE(cmn_cst_21, sizeof(cmn_cst_21) / sizeof(cmn_cst_21[0]));
    auto app22 = f.FUN_C197EEAE(cmn_cst_22, sizeof(cmn_cst_22) / sizeof(cmn_cst_22[0]));
    auto app23 = f.FUN_C197EEAE(cmn_cst_23, sizeof(cmn_cst_23) / sizeof(cmn_cst_23[0]));
    auto app24 = f.FUN_C197EEAE(cmn_cst_24, sizeof(cmn_cst_24) / sizeof(cmn_cst_24[0]));
    auto app25 = f.FUN_C197EEAE(cmn_cst_25, sizeof(cmn_cst_25) / sizeof(cmn_cst_25[0]));
    auto app26 = f.FUN_C197EEAE(cmn_cst_26, sizeof(cmn_cst_26) / sizeof(cmn_cst_26[0]));
    auto app27 = f.FUN_C197EEAE(cmn_cst_27, sizeof(cmn_cst_27) / sizeof(cmn_cst_27[0]));
    auto app28 = f.FUN_C197EEAE(cmn_cst_28, sizeof(cmn_cst_28) / sizeof(cmn_cst_28[0]));
    auto app29 = f.FUN_C197EEAE(cmn_cst_29, sizeof(cmn_cst_29) / sizeof(cmn_cst_29[0]));
    auto app30 = f.FUN_C197EEAE(cmn_cst_30, sizeof(cmn_cst_30) / sizeof(cmn_cst_30[0]));
    auto app31 = f.FUN_C197EEAE(cmn_cst_31, sizeof(cmn_cst_31) / sizeof(cmn_cst_31[0]));
    auto app32 = f.FUN_C197EEAE(cmn_cst_32, sizeof(cmn_cst_32) / sizeof(cmn_cst_32[0]));
    auto app33 = f.FUN_C197EEAE(cmn_cst_33, sizeof(cmn_cst_33) / sizeof(cmn_cst_33[0]));
    auto app34 = f.FUN_C197EEAE(cmn_cst_34, sizeof(cmn_cst_34) / sizeof(cmn_cst_34[0]));
    auto app35 = f.FUN_C197EEAE(cmn_cst_35, sizeof(cmn_cst_35) / sizeof(cmn_cst_35[0]));
    const char* dangerousApps[] = {
            app12.c_str(),
            app13.c_str(),
            app14.c_str(),
            app15.c_str(),
            app16.c_str(),
            app17.c_str(),
            app18.c_str(),
            app19.c_str(),
            app20.c_str(),
            app21.c_str(),
            app22.c_str(),
            app23.c_str(),
            app24.c_str(),
            app25.c_str(),
            app26.c_str(),
            app27.c_str(),
            app28.c_str(),
            app29.c_str(),
            app30.c_str(),
            app31.c_str(),
            app32.c_str(),
            app33.c_str(),
            app34.c_str(),
            app35.c_str()
    };
    for (const char *app:dangerousApps)
    {
        bool installed = pm(app);
        if(installed)
            apps += (apps.size()<=1 ? "\"" : ",\"") + std::string(app) + "\"";
    }

    // Check cloaking apps
    auto app36 = f.FUN_C197EEAE(cmn_cst_36, sizeof(cmn_cst_36) / sizeof(cmn_cst_36[0]));
    auto app37 = f.FUN_C197EEAE(cmn_cst_37, sizeof(cmn_cst_37) / sizeof(cmn_cst_37[0]));
    auto app38 = f.FUN_C197EEAE(cmn_cst_38, sizeof(cmn_cst_38) / sizeof(cmn_cst_38[0]));
    auto app39 = f.FUN_C197EEAE(cmn_cst_39, sizeof(cmn_cst_39) / sizeof(cmn_cst_39[0]));
    auto app40 = f.FUN_C197EEAE(cmn_cst_40, sizeof(cmn_cst_40) / sizeof(cmn_cst_40[0]));
    auto app41 = f.FUN_C197EEAE(cmn_cst_41, sizeof(cmn_cst_41) / sizeof(cmn_cst_41[0]));
    auto app42 = f.FUN_C197EEAE(cmn_cst_42, sizeof(cmn_cst_42) / sizeof(cmn_cst_42[0]));
    auto app43 = f.FUN_C197EEAE(cmn_cst_43, sizeof(cmn_cst_43) / sizeof(cmn_cst_43[0]));
    auto app44 = f.FUN_C197EEAE(cmn_cst_44, sizeof(cmn_cst_44) / sizeof(cmn_cst_44[0]));
    const char* cloakingApps[] = {
            app12.c_str(),
            app13.c_str(),
            app14.c_str(),
            app15.c_str(),
            app16.c_str(),
            app17.c_str(),
            app18.c_str(),
            app19.c_str(),
            app20.c_str(),
            app21.c_str(),
            app22.c_str(),
            app23.c_str(),
            app24.c_str(),
            app25.c_str(),
            app26.c_str(),
            app27.c_str(),
            app28.c_str(),
            app29.c_str(),
            app30.c_str(),
            app31.c_str(),
            app32.c_str(),
            app33.c_str(),
            app34.c_str(),
            app35.c_str()
    };
    for (const char *app:cloakingApps)
    {
        bool installed = pm(app);
        if(installed)
            apps += (apps.size()<=1 ? "\"" : ",\"") + std::string(app) + "\"";
    }

    //Insert final result into shared preferences
    apps += "]";
    return apps;
}

std::string process2(){

    //Init
    std::string paths = "[";
    entries f;

    //commands
    auto su = f.FUN_C197EEAE(cmn_cst_55, sizeof(cmn_cst_55) / sizeof(cmn_cst_55[0]));
    auto daemonsu = f.FUN_C197EEAE(cmn_val_56, sizeof(cmn_val_56) / sizeof(cmn_val_56[0]));
    auto superuser = f.FUN_C197EEAE(cmn_val_57, sizeof(cmn_val_57) / sizeof(cmn_val_57[0]));

    //Check /system/xbin/su
    auto path1 = f.FUN_C197EEAE(cmn_cst_45, sizeof(cmn_cst_45) / sizeof(cmn_cst_45[0]));
    auto fullPath1 = path1 + su;
    if(open(fullPath1.c_str()) || fstream(fullPath1.c_str()) || ls(path1.c_str(), su.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + fullPath1 + "\"";

    //Check /system/xbin/daemonsu
    auto fullPath2 = path1 + daemonsu;
    if(ls(path1.c_str(), daemonsu.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + fullPath2 + "\"";

    //Check /su/bin/su
    auto path3 = f.FUN_C197EEAE(cmn_cst_46, sizeof(cmn_cst_46) / sizeof(cmn_cst_46[0]));
    if(open(path3.c_str()) || fstream(path3.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path3 + "\"";

    //Check /system/app/Superuser.apk
    auto path4 = f.FUN_C197EEAE(cmn_cst_47, sizeof(cmn_cst_47) / sizeof(cmn_cst_47[0]));
    auto fullPath4 = path4 + superuser;
    if(open(fullPath4.c_str()) || fstream(fullPath4.c_str()) || ls(path4.c_str(), superuser.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + fullPath4 + "\"";

    //Check /sbin/su
    auto path5 = f.FUN_C197EEAE(cmn_cst_48, sizeof(cmn_cst_48) / sizeof(cmn_cst_48[0]));
    if(open(path5.c_str()) || fstream(path5.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path5 + "\"";

    //Check /system/bin/
    auto path6 = f.FUN_C197EEAE(cmn_cst_49, sizeof(cmn_cst_49) / sizeof(cmn_cst_49[0]));
    auto fullPath6 = path6 + su;
    if(open(fullPath6.c_str()) || fstream(fullPath6.c_str()) || ls(path6.c_str(), su.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + fullPath6 + "\"";

    //Check /data/local/xbin/su
    auto path7 = f.FUN_C197EEAE(cmn_cst_50, sizeof(cmn_cst_50) / sizeof(cmn_cst_50[0]));
    if(open(path7.c_str()) || fstream(path7.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path7 + "\"";

    //Check /data/local/bin/su
    auto path8 = f.FUN_C197EEAE(cmn_cst_51, sizeof(cmn_cst_51) / sizeof(cmn_cst_51[0]));
    if(open(path8.c_str()) || fstream(path8.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path8 + "\"";

    //Check /system/sd/xbin/su
    auto path9 = f.FUN_C197EEAE(cmn_cst_52, sizeof(cmn_cst_52) / sizeof(cmn_cst_52[0]));
    if(open(path9.c_str()) || fstream(path9.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path9 + "\"";

    //Check /system/bin/failsafe/su
    auto path10 = f.FUN_C197EEAE(cmn_cst_53, sizeof(cmn_cst_53) / sizeof(cmn_cst_53[0]));
    if(open(path10.c_str()) || fstream(path10.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path10 + "\"";

    //Check /data/local/su
    auto path11 = f.FUN_C197EEAE(cmn_cst_54, sizeof(cmn_cst_54) / sizeof(cmn_cst_54[0]));
    if(open(path11.c_str()) || fstream(path11.c_str()))
        paths += (paths.size()<=1 ? "\"" : ",\"") + path11 + "\"";

    //Insert final result into shared preferences
    paths += "]";
    return paths;
}

/// Root detection methods

//Check installed packages
static bool pm(char const *package) {

    //Init string to be checked
    entries f;
    char searchString[100];
    sprintf(searchString, "%s", package);

    //Init cmd to be executed
    auto cmd = f.FUN_C197EEAE(cmn_val_58, sizeof(cmn_val_58) / sizeof(cmn_val_58[0]));
    cmd += package;

    pid_t pid;
    int link[2];
    char buf[4096];
    ssize_t bytesRead;
    if (pipe(link)==-1)
        exit(-1);

    if ((pid = fork()) == -1)
        exit(-1);

    if(pid == 0)
    {
        dup2(link[1], STDOUT_FILENO);
        close(link[0]);

        //Execute request
        execlp("sh" , "sh", "-c", cmd.c_str(), nullptr);
        exit(-1);
    }
    else
    {
        close(link[1]);
        wait(nullptr);
        while(true)
        {
            bytesRead = read_line(link[0], buf, MAX_LINE);
            if(bytesRead<=0)
                break;

            buf[bytesRead] = 0;
            if (my_strstr(buf, searchString) != nullptr)
            {
                close(link[0]);
                return true;
            }
        }
        close(link[0]);
    }
    return false;
}

//Check if file exist
static bool open(char const *path)
{
    FILE *fp;
    jboolean fileExists = false;
    fp = fopen(path, "r");
    if (fp!=nullptr) {
        fileExists = true;
        fclose(fp);
    }
    return fileExists;
}

//Check if file stream exist
static bool fstream(char const *path)
{
    jboolean fileExists = false;
    std::ifstream stream(path);
    if (stream.is_open()) {
        fileExists = true;
        stream.close();
    }
    return fileExists;
}

//To be checked
static bool stat(char const *path) {

    struct stat attrs{};
    if (stat(path, &attrs) < 0)
        return false;
    return true;
}

//To be checked
static bool ls(char const *path, char const *name) {

    //Init string to be checked
    entries f;
    char searchString[100];
    sprintf(searchString, "%s", name);

    pid_t pid;
    int link[2];
    char buf[4096];
    ssize_t bytesRead;
    if (pipe(link)==-1)
        exit(-1);

    if ((pid = fork()) == -1)
        exit(-1);

    if(pid == 0)
    {
        dup2(link[1], STDOUT_FILENO);
        close(link[0]);

        //Execute request
        execlp("ls" , "ls", path, nullptr);
        exit(-1);
    }
    else
    {
        close(link[1]);
        wait(nullptr);
        while(true)
        {
            bytesRead = read_line(link[0], buf, MAX_LINE);
            if(bytesRead<=0)
                break;

            buf[bytesRead] = 0;
            if (my_strstr(buf, searchString) != nullptr)
            {
                close(link[0]);
                return true;
            }
        }
        close(link[0]);
    }
    return false;
}

//To be checked
static bool runsu(char const *path)
{
    int status = 1;
    jboolean success = 1;
    LOGD("ROOT CHECK // runsu: starting...");

    pid_t pid;
    pid = fork();
    LOGD("ROOT CHECK // runsu: pid is: [%d]", pid);
    // Child process will return 0 from fork()
    if(pid == 0)
    {
        LOGD("ROOT CHECK // runsu: Child process here.");
        int result = execl(path, "su", NULL);
        int errsv = errno;
        if (result != 0) {
            char buffer[256];
            char * errorMessage = (char *)strerror_r( errsv, buffer, 256 ); // get string message from errno
            LOGD("ROOT CHECK // runsu: execl error: [%s]\n", errorMessage);
            exit(1);
        } else {
            LOGD("ROOT CHECK // runsu: execl no error\n");
            exit(0);
        }
    }
        // Parent process will return a non-zero value from fork()
    else if (pid > 0)
    {
        LOGD("ROOT CHECK // runsu: Parent process here.\n");
        //wait(&status);
        LOGD("ROOT CHECK // runsu: Parent done waiting.\n");
    }
    else
    {
        LOGD("ROOT CHECK: runsu: error with fork()\n");
        status = 1;
    }

    LOGD("ROOT CHECK // runsu: status: [%d]\n", status);
    if (status)
        success = 0;

    LOGD("ROOT CHECK // runsu: finishing...\n");
    return success;
}

/// Frida detection methods

static void getFilePaths(char **filePaths) {
    int fd = 0;
    int counter = 0;
    char map[MAX_LINE];

    if ((fd = openat(AT_FDCWD, PROC_MAPS, O_RDONLY | O_CLOEXEC, 0)) != 0)
    {
        while ((read_line(fd, map, MAX_LINE)) > 0)
        {
            for (int i = 0; i < NUM_LIBS; i++)
            {
                if (my_strstr(map, libstocheck[i]) != nullptr)
                {
                    char buf[5] = "";
                    char tmp[MAX_LENGTH] = "";
                    char path[MAX_LENGTH] = "";
                    sscanf(map, "%s %s %s %s %s %s", tmp, buf, tmp, tmp, tmp, path);
                    LOGE("MAP1: %s %s %s %s %s %s", tmp, buf, tmp, tmp, tmp, path);

                    ///Check if library is set as having executable code
                    if (buf[2] == 'x')
                    {
                        size_t size = len(path) + 1;
                        filePaths[i] = static_cast<char *>(malloc(size));
                        strlcpy(filePaths[i], path, size);
                        counter++;
                    }
                }
            }
            if (counter == NUM_LIBS)
                break;
        }
        close(fd);
    }
}

static bool fetchChecksum(const char *filePath, execSection **pTextSection) {
    Elf_Ehdr ehdr;
    Elf_Shdr sectHeader;
    int fd;
    int execSectionCount = 0;

    /// Open file descriptor
    fd = openat(AT_FDCWD, filePath, O_CLOEXEC|O_RDONLY, 0);
    if (fd < 0)
        return false;

    /// Read file descriptor
    read(fd, &ehdr, sizeof(Elf_Ehdr));

    /// Set reading to offset starting from the begging of the file.
    lseek(fd, (off_t) ehdr.e_shoff, SEEK_SET);

    unsigned long memsize[2] = {0};
    unsigned long offset[2] = {0};
    for (int i = 0; i < ehdr.e_shnum; i++)
    {
        /// Fill sectHeader's memory
        my_memset(&sectHeader, 0, sizeof(Elf_Shdr));

        /// Read current section header of file descriptor
        read(fd, &sectHeader, sizeof(Elf_Shdr));

        /// Typically PLT and Text Sections are executable sections which are protected
        auto flag = sectHeader.sh_flags;
        if (flag & SHF_EXECINSTR)
        {
            offset[execSectionCount] = sectHeader.sh_offset;
            memsize[execSectionCount] = sectHeader.sh_size;
            execSectionCount++;
            if (execSectionCount == 2)
                break;
        }
    }

    if (execSectionCount == 0) {
        //TODO: rise a warning (No executable section found)
        close(fd);
        return false;
    }

    *pTextSection = static_cast<execSection *>(malloc(sizeof(execSection)));
    (*pTextSection)->execSectionCount = execSectionCount;
    (*pTextSection)->startAddrinMem = 0;
    for (int i = 0; i < execSectionCount; i++)
    {
        lseek(fd, offset[i], SEEK_SET);
        auto *buffer = static_cast<uint8_t *>(malloc(memsize[i] * sizeof(uint8_t)));
        read(fd, buffer, memsize[i]);
        (*pTextSection)->offset[i] = offset[i];
        (*pTextSection)->memsize[i] = memsize[i];
        (*pTextSection)->checksum[i] = checksum(buffer, memsize[i]);
        LOGE("Path: %s. Checksum is: [%lu]", filePath, (*pTextSection)->checksum[i]);
        free(buffer);
    }
    close(fd);
    return true;
}

static void compareMemDisk() {
    int fd = 0;
    char map[MAX_LINE];
    if ((fd = openat(AT_FDCWD, PROC_MAPS, O_RDONLY | O_CLOEXEC, 0)) != 0)
    {
        while ((read_line(fd, map, MAX_LINE)) > 0)
        {
            for (int i = 0; i < NUM_LIBS; i++) {
                if (my_strstr(map, libstocheck[i]) != nullptr) {
                    if (scanSegments(map, elfSectionArr[i], libstocheck[i]))
                        break;
                }
            }
        }
    } else {
        LOGE("Error opening /proc/self/maps. That's usually a bad sign.");
    }
    close(fd);
}

static bool scanSegments(char *map, execSection *pElfSectArr, const char *libraryName) {
    unsigned long start, end;
    char buf[MAX_LINE] = "";
    char path[MAX_LENGTH] = "";
    char tmp[100] = "";

    sscanf(map, "%lx-%lx %s %s %s %s %s", &start, &end, buf, tmp, tmp, tmp, path);
    if (buf[2] == 'x')
    {
        if (buf[0] == 'r')
        {
            LOGD("MAP2: %lx-%lx %s %s %s %s %s", start, end, buf, tmp, tmp, tmp, path);
            uint8_t *buffer;
            buffer = (uint8_t *) start;
            for (int i = 0; i < pElfSectArr->execSectionCount; i++) {
                if (start + pElfSectArr->offset[i] + pElfSectArr->memsize[i] > end){
                    if (pElfSectArr->startAddrinMem != 0) {
                        buffer = (uint8_t *) pElfSectArr->startAddrinMem;
                        pElfSectArr->startAddrinMem = 0;
                        break;
                    }
                }
            }
            for (int i = 0; i < pElfSectArr->execSectionCount; i++)
            {
                unsigned long output = checksum(buffer + pElfSectArr->offset[i], pElfSectArr->memsize[i]);
                ///Executable Section Manipulated, maybe due to Frida or other hooking framework. Act Now!!!
                if (output != pElfSectArr->checksum[i])
                    exit(-1);
            }
        }
        else
        {
            int version = my_atoi(entries::FUN_A432617E("ro.build.version.release"));
            int version1 = my_atoi(entries::FUN_A432617E("ro.system.build.version.release"));
            if (version < 10 || version1 < 10)
                LOGE("Suspicious to get XOM in version < Android10");
            else
            {
                /// If it is not readable, then most likely it is not manipulated by Frida
                if (0 == my_strncmp(libraryName, LIBC, len(LIBC)))
                    LOGE("LIBC Executable Section not readable!");
                else
                    LOGE("Suspicious to get XOM for non-system library on Android 10 and above");
            }
        }
        return true;
    } else {
        if (buf[0] == 'r') {
            pElfSectArr->startAddrinMem = start;
        }
    }
    return false;
}