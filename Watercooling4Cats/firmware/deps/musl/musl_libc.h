#ifndef	_MUSL_MEM_H
#define	_MUSL_MEM_H


#include <stdint.h>
#include <stddef.h>

extern int memcmp(const void *vl, const void *vr, size_t n);
extern void *memmove (void *, const void *, size_t);
extern void *memset (void *, int, size_t);
void *memcpy(void *restrict dest, const void *restrict src, size_t n);
char *Astrcpy(char *restrict dest, const char *restrict src);
size_t strlen(const char *s);
char *stpcpy(char *restrict d, const char *restrict s);

#endif // _MUSL_MEM_H
