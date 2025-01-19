package com.djezzy.b2b.internet;

public class Constants {

    private static Constants instance;
    public static Constants getInstance() {
        if(instance == null)
            instance = new Constants();
        return instance;
    }

    private Constants() {

    }

    //Retrieve constants from JNI
    static {
        System.loadLibrary("globale");
    }

    //region WEBSERVICE INFORMATION

    /**
     * Get client secret
     * @return client secret
     */
    public native String F94027e6f();

    /**
     * Get client id
     * @return client id
     */
    public native String F0ca8c48e();

    /**
     * Get Mobile grant
     * @return Mobile grant
     */
    public native String F49c4f779();

    /**
     * Get Refresh Grant
     * @return Refresh Grant
     */
    public native String Fe8ed80d7();

    /**
     * Get OTP ID
     * @return OTP ID
     */
    public native String Ff07c6783();

    /**
     * Get OPEN ID
     * @return OPEN ID
     */
    public native String F624ec337();

    /**
     * Get Base URL
     * @return Base URL
     */
    public native String Ffa442cd3();

    /**
     * Get Token URL
     * @return Token URL
     */
    public native String Fe54a2fc7();

    /**
     * Get Registration URL
     * @return Registration URL
     */
    public native String F48628b49();

    /**
     * Get Information URL
     * @return Information URL
     */
    public native String Fe0c2ae9e();

    /**
     * Get Services URL
     * @return Services URL
     */
    public native String F1b0745bf();

    /**
     * Get Community URL
     * @return Community URL
     */
    public native String F6ee05df9();

    /**
     * Get Contents URL
     * @return Contents URL
     */
    public native String Fbdef6330();

    /**
     * Get Assets URL
     * @return Assets URL
     */
    public native String Fd12f231c();

    /**
     * Get Settings URL
     * @return Settings URL
     */
    public native String Fd72d49da();

    /**
     * Get Notifications URL
     * @return Notifications URL
     */
    public native String F04ab60bc();

    /**
     * Get Customer care URL
     * @return Customer care URL
     */
    public native String Fccd83952();

    /**
     * Get Payment URL
     * @return Payment URL
     */
    public native String Fee12c08d();

    /**
     * Get Events URL
     * @return Events URL
     */
    public native String F59dfb1c0();

    /**
     * Get Language
     * @return Language
     */
    public native String F7406ff09();

    /**
     * Get EPayment B Party
     * @return get b party info URL
     */
    public native String F4148be56();

    /**
     * Get Encryption string
     * @return Encryption string
     */
    public native String Fcda93ebb();

    //endregion

    //region SHARED PREFERENCES

    /**
     * Get mobile number from Shared preferences
     * @return value
     */
    public native String Fb8c0bb40();

    /**
     * Save mobile number into shared preferences
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb41(String value);

    /**
     * Get Access Token from Shared preferences
     * @return value
     */
    public native String Fb8c0bb42();

    /**
     * Save Access Token into shared preferences
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb43(String value);

    /**
     * Get Refresh Token from Shared preferences
     * @return value
     */
    public native String Fb8c0bb44();

    /**
     * Save Refresh Token into shared preferences
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb45(String value);

    /**
     * Get Token Type from Shared preferences
     * @return value
     */
    public native String Fb8c0bb46();

    /**
     * Save Token Type into shared preferences
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb47(String value);

    /**
     * Get Language from Shared preferences
     * @return value
     */
    public native String Fb8c0bb48();

    /**
     * Save Language into shared preferences
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb49(String value);

    /**
     * Get value for a given key from Shared preferences
     * @param key to search
     * @return value
     */
    public native String Fb8c0bb50(String key);

    /**
     * Save value for a given key into shared preferences
     * @param key to search
     * @param value to save
     * @return true if value saved, false if not
     */
    public native boolean Fb8c0bb51(String key, String value);

    //endregion

    /**
     * nativeEncryption
     */
    public native String Fda936f3e(String text, String key, String generatorAlgo, String cipherAlgo, int mode);

    /**
     * randomKey
     */
    public native String Fa0a9bc91(String algo);

    /**
     * Get Web agent as a concatenation between App name & version
     * @return web agent value
     */
    public native String F90a64e59();
}