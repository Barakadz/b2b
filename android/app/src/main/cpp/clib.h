#include <cctype>
#include "stdio.h"
#include <unistd.h>
//
// Created by Kamel.OULEBSIR on 10/10/2022.
//

#ifndef DJEZZYINTERNET_CLIB_H
#define DJEZZYINTERNET_CLIB_H

/**
 * Copy a char set to another char set
 * @param dst destination set
 * @param src source set
 * @param siz size of set to be copied
 * @return final size of the copied set
 */
__attribute__((always_inline))
static inline size_t cpy(char *dst, const char *src, size_t siz)
{
    char *d = dst;
    const char *s = src;
    size_t n = siz;
    /* Copy as many bytes as will fit */
    if (n != 0) {
        while (--n != 0) {
            if ((*d++ = *s++) == '\0')
                break;
        }
    }

    /* Not enough room in dst, add NUL and traverse rest of src */
    if (n == 0) {
        if (siz != 0)
            *d = '\0';		/* NUL-terminate dst */
        while (*s++);
    }
    return(s - src - 1);	/* count does not include NUL */
}

/**
 * Get char set size
 * @param s char set
 * @return char set size
 */
static inline size_t len(const char *array)
{
    size_t l = 0;
    while(*array++) l++;
    return l;
}

/**
* Compare two char sets but on the provided length only
* @param s1 first char set
* @param s2 second char set
 * @param n
* @return if s1 lower, equal or higher that s2
*/
__attribute__((always_inline))
static inline int my_strncmp(const char *s1, const char *s2, size_t n)
{
    if (n == 0)
        return (0);
    do {
        if (*s1 != *s2++)
            return (*(unsigned char *)s1 - *(unsigned char *)--s2);
        if (*s1++ == 0)
            break;
    } while (--n != 0);
    return (0);
}

/**
 * Return the first occurrence of char set in another char set
 * @param s main char set
 * @param find char set to be found
 * @return pointer to the fist occurence if found, null if not
 */
__attribute__((always_inline))
static inline char * my_strstr(const char *s, const char *find)
{
    char c, sc;
    size_t l;

    if ((c = *find++) != '\0') {
        l = len(find);
        do {
            do {
                if ((sc = *s++) == '\0')
                    return nullptr;
            } while (sc != c);
        } while (my_strncmp(s, find, l) != 0);
        s--;
    }
    return ((char *)s);
}

/**
 * Fill memory zone identified by it's address, size and the default value (as int)
 * @param dst pointer
 * @param c default value
 * @param n size of the memory
 * @return pointer
 */
__attribute__((always_inline))
static inline void*  my_memset(void*  dst, int c, size_t n)
{
    char*  q   = (char*)dst;
    char*  end = q + n;
    for (;;) {
        if (q >= end) break; *q++ = (char) c;
        if (q >= end) break; *q++ = (char) c;
        if (q >= end) break; *q++ = (char) c;
        if (q >= end) break; *q++ = (char) c;
    }
    return dst;
}

/**
 * Compare two char sets
 * @param s1 first char set
 * @param s2 second char set
 * @return if s1 lower, equal or higher that s2
 */
__attribute__((always_inline))
static inline int my_strcmp(const char *s1, const char *s2)
{
    while (*s1 == *s2++)
        if (*s1++ == 0)
            return (0);
    return (*(unsigned char *)s1 - *(unsigned char *)--s2);
}

/**
 * Convert char set from ASCII to integer
 * @param s char set
 * @return integer
 */
__attribute__((always_inline))
static inline int my_atoi(const char *s)
{
    int n=0, neg=0;
    while (isspace(*s)) s++;
    switch (*s) {
        case '-': neg=1;
        case '+': s++;
    }
    /* Compute n as a negative number to avoid overflow on INT_MIN */
    while (isdigit(*s))
        n = 10*n - (*s++ - '0');
    return neg ? n : -n;
}

static ssize_t read_line(int fd, char *buf, unsigned int max_len) {
    char b;
    ssize_t ret;
    ssize_t bytes_read = 0;
    my_memset(buf, 0, max_len);
    do {
        ret = read(fd, &b, 1);
        if (ret != 1) {
            if (bytes_read == 0) {
                // error or EOF
                return -1;
            } else {
                return bytes_read;
            }
        }

        if (b == '\n')
            return bytes_read;

        *(buf++) = b;
        bytes_read += 1;

    } while (bytes_read < max_len - 1);
    return bytes_read;
}

static unsigned long checksum(void *buffer, size_t len) {
    unsigned long seed = 0;
    uint8_t *buf = (uint8_t *) buffer;
    size_t i;
    for (i = 0; i < len; ++i)
        seed += (unsigned long) (*buf++);
    return seed;
}

#endif //DJEZZYINTERNET_CLIB_H
