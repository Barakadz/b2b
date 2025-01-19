#include <string>
#include <vector>
//
// Created by Kamel.OULEBSIR on 26/10/2022.
//

#ifndef DJEZZYINTERNET_BASE64_H
#define DJEZZYINTERNET_BASE64_H

static const std::string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static std::string encode(const std::string &in) {
    std::string out;

    int val=0, valb=-6;
    for (unsigned char c : in)
    {
        val = (val<<8) + c;
        valb += 8;
        while (valb>=0)
        {
            out.push_back(chars[(val>>valb)&0x3F]);
            valb-=6;
        }
    }
    if (valb>-6) out.push_back(chars[((val<<8)>>(valb+8))&0x3F]);
    while (out.size()%4) out.push_back('=');
    return out;
}

static std::string decode(const std::string &in) {

    std::string out = "";
    std::vector<int> T(256,-1);
    for (int i=0; i<64; i++) T[chars[i]] = i;

    int val=0, valb=-8;
    for (unsigned char c : in)
    {
        if (T[c] == -1) break;
        val = (val<<6) + T[c];
        valb += 6;
        if (valb>=0) {
            out.push_back(char((val>>valb)&0xFF));
            valb-=8;
        }
    }
    return out;
}

#endif //DJEZZYINTERNET_BASE64_H