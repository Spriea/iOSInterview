/* bu_compat.h -- Backwards compatible interface for older versions
   Version 2.8.6, April 8, 2019
   part of the MiniZip project

   Copyright (C) 2010-2019 Nathan Moinvaziri
     https://github.com/nmoinvaz/minizip
   Copyright (C) 1998-2010 Gilles Vollant
     https://www.winimage.com/zLibDll/minizip.html

   This program is distributed under the terms of the same license as zlib.
   See the accompanying LICENSE file for the full text of the license.
*/

#ifndef bu_COMPAT_H
#define bu_COMPAT_H

#include "bu.h"
#include "BUZipCommon.h"

#ifdef __cplusplus
extern "C" {
#endif

/***************************************************************************/

#if defined(HAVE_ZLIB) && defined(MAX_MEM_LEVEL)
#ifndef DEF_MEM_LEVEL
#  if MAX_MEM_LEVEL >= 8
#    define DEF_MEM_LEVEL 8
#  else
#    define DEF_MEM_LEVEL  MAX_MEM_LEVEL
#  endif
#endif
#endif
#ifndef MAX_WBITS
#define MAX_WBITS     15
#endif
#ifndef DEF_MEM_LEVEL
#define DEF_MEM_LEVEL 8
#endif

#ifndef BUEXPORT
#  define BUEXPORT bu_EXPORT
#endif

/***************************************************************************/

#if defined(STRICTZIP) || defined(STRICTZIPUNZIP)
/* like the STRICT of WIN32, we define a pointer that cannot be converted
    from (void*) without cast */
typedef struct TagzipFile__ { int unused; } zip_file__;
typedef zip_file__ *zipFile;
#else
typedef void *zipFile;
#endif

/***************************************************************************/

typedef void *zlib_filefunc_def;
typedef void *zlib_filefunc64_def;
typedef const char *zipcharpc;

typedef struct tm tm_unz;
typedef struct tm tm_zip;

typedef uint64_t ZPOS64_T;

/***************************************************************************/

// ZipArchive 2.x uses dos_date
#define bu_COMPAT_VERSION 120

#if bu_COMPAT_VERSION <= 110
#define bu_dos_date dosDate
#else
#define bu_dos_date dos_date
#endif

typedef struct
{
    uint32_t    bu_dos_date;
    struct tm   tbu_date;
    uint16_t    internal_fa;        /* internal file attributes        2 bytes */
    uint32_t    external_fa;        /* external file attributes        4 bytes */
} bu_zip_fileinfo;

/***************************************************************************/

#define BU_ZIP_OK                          (0)
#define BU_ZIP_EOF                         (0)
#define BU_ZIP_ERRNO                       (-1)
#define BU_ZIP_PARAMERROR                  (-102)
#define BU_ZIP_BADZIPFILE                  (-103)
#define BU_ZIP_INTERNALERROR               (-104)

#define BU_Z_BZIP2ED                       (12)

#define BU_APPEND_STATUS_CREATE            (0)
#define BU_APPEND_STATUS_CREATEAFTER       (1)
#define BU_APPEND_STATUS_ADDINZIP          (2)

/***************************************************************************/
/* Writing a zip file  */

BUEXPORT zipFile bu_zipOpen(const char *path, int append);
BUEXPORT zipFile bu_zipOpen64(const void *path, int append);
BUEXPORT zipFile bu_zipOpen2(const char *path, int append, const char **globalcomment,
    zlib_filefunc_def *pzlib_filefunc_def);
BUEXPORT zipFile bu_zipOpen2_64(const void *path, int append, const char **globalcomment,
    zlib_filefunc64_def *pzlib_filefunc_def);
        zipFile bu_zipOpen_MZ(void *stream, int append, const char **globalcomment);

BUEXPORT int     bu_zipOpenNewFileInZip5(zipFile file, const char *filename, const bu_zip_fileinfo *zipfi,
    const void *extrafield_local, uint16_t size_extrafield_local, const void *extrafield_global,
    uint16_t size_extrafield_global, const char *comment, uint16_t compression_method, int level,
    int raw, int windowBits, int memLevel, int strategy, const char *password,
    signed char aes, uint16_t version_madeby, uint16_t flag_base, int zip64);

BUEXPORT int     bu_zipWriteInFileInZip(zipFile file, const void *buf, uint32_t len);

BUEXPORT int     bu_zipCloseFileInZipRaw(zipFile file, uint32_t uncompressed_size, uint32_t crc32);
BUEXPORT int     bu_zipCloseFileInZipRaw64(zipFile file, int64_t uncompressed_size, uint32_t crc32);
BUEXPORT int     bu_zipCloseFileInZip(zipFile file);
BUEXPORT int     bu_zipCloseFileInZip64(zipFile file);

BUEXPORT int     bu_zipClose(zipFile file, const char *global_comment);
BUEXPORT int     bu_zipClose_64(zipFile file, const char *global_comment);
BUEXPORT int     bu_zipClose2_64(zipFile file, const char *global_comment, uint16_t version_madeby);
        int     bu_zipClose_MZ(zipFile file, const char *global_comment);
        int     bu_zipClose2_MZ(zipFile file, const char *global_comment, uint16_t version_madeby);
BUEXPORT void*   bu_zipGetStream(zipFile file);

/***************************************************************************/

#if defined(STRICTUNZIP) || defined(STRICTZIPUNZIP)
/* like the STRICT of WIN32, we define a pointer that cannot be converted
    from (void*) without cast */
typedef struct TagunzFile__ { int unused; } unz_file__;
typedef unz_file__ *unzFile;
#else
typedef void *unzFile;
#endif

/***************************************************************************/

#define bu_UNZ_OK                          (0)
#define bu_UNZ_END_OF_LIST_OF_FILE         (-100)
#define bu_UNZ_ERRNO                       (-1)
#define bu_UNZ_EOF                         (0)
#define bu_UNZ_PARAMERROR                  (-102)
#define bu_UNZ_BADZIPFILE                  (-103)
#define bu_UNZ_INTERNALERROR               (-104)
#define bu_UNZ_CRCERROR                    (-105)
#define bu_UNZ_BADPASSWORD                 (-106)

/***************************************************************************/

typedef int (*bu_unzFileNameComparer)(unzFile file, const char *filename1, const char *filename2);
typedef int (*bu_unzIteratorFunction)(unzFile file);
typedef int (*bu_unzIteratorFunction2)(unzFile file, bu_unz_file_info64 *pfile_info, char *filename,
    uint16_t filename_size, void *extrafield, uint16_t extrafield_size, char *comment,
    uint16_t comment_size);

/***************************************************************************/
/* Reading a zip file */

BUEXPORT unzFile bu_unzOpen(const char *path);
BUEXPORT unzFile bu_unzOpen64(const void *path);
BUEXPORT unzFile bu_unzOpen2(const char *path, zlib_filefunc_def *pzlib_filefunc_def);
BUEXPORT unzFile bu_unzOpen2_64(const void *path, zlib_filefunc64_def *pzlib_filefunc_def);
        unzFile bu_unzOpen_MZ(void *stream);

BUEXPORT int     bu_unzClose(unzFile file);
        int     bu_unzClose_MZ(unzFile file);

BUEXPORT int     bu_unzGetGlobalInfo(unzFile file, bu_unz_global_info* pglobal_info32);
BUEXPORT int     bu_unzGetGlobalInfo64(unzFile file, bu_unz_global_info64 *pglobal_info);
BUEXPORT int     bu_unzGetGlobalComment(unzFile file, char *comment, uint16_t comment_size);

BUEXPORT int     bu_unzOpenCurrentFile(unzFile file);
BUEXPORT int     bu_unzOpenCurrentFilePassword(unzFile file, const char *password);
BUEXPORT int     bu_unzOpenCurrentFile2(unzFile file, int *method, int *level, int raw);
BUEXPORT int     bu_unzOpenCurrentFile3(unzFile file, int *method, int *level, int raw, const char *password);
BUEXPORT int     bu_unzReadCurrentFile(unzFile file, void *buf, uint32_t len);
BUEXPORT int     bu_unzCloseCurrentFile(unzFile file);


BUEXPORT int     bu_unzGetCurrentFileInfo(unzFile file, bu_unz_file_info *pfile_info, char *filename,
    uint16_t filename_size, void *extrafield, uint16_t extrafield_size, char *comment,
    uint16_t comment_size);
BUEXPORT int     bu_unzGetCurrentFileInfo64(unzFile file, bu_unz_file_info64 * pfile_info, char *filename,
    uint16_t filename_size, void *extrafield, uint16_t extrafield_size, char *comment,
    uint16_t comment_size);

BUEXPORT int     bu_unzGoToFirstFile(unzFile file);
BUEXPORT int     bu_unzGoToNextFile(unzFile file);
BUEXPORT int     bu_unzLocateFile(unzFile file, const char *filename, bu_unzFileNameComparer filename_compare_func);

BUEXPORT int     bu_unzGetLocalExtrafield(unzFile file, void *buf, unsigned int len);

/***************************************************************************/
/* Raw access to zip file */

typedef struct bu_unz_file_pos_s
{
    uint32_t pos_in_zip_directory;  /* offset in zip file directory */
    uint32_t num_of_file;           /* # of file */
} bu_unz_file_pos;

BUEXPORT int     bu_unzGetFilePos(unzFile file, bu_unz_file_pos *file_pos);
BUEXPORT int     bu_unzGoToFilePos(unzFile file, bu_unz_file_pos *file_pos);

typedef struct bu_unz64_file_pos_s
{
    int64_t  pos_in_zip_directory;   /* offset in zip file directory  */
    uint64_t num_of_file;            /* # of file */
} bu_unz64_file_pos;

BUEXPORT int     bu_unzGetFilePos64(unzFile file, bu_unz64_file_pos *file_pos);
BUEXPORT int     bu_unzGoToFilePos64(unzFile file, const bu_unz64_file_pos *file_pos);

BUEXPORT int64_t bu_unzGetOffset64(unzFile file);
BUEXPORT int32_t bu_unzGetOffset(unzFile file);
BUEXPORT int     bu_unzSetOffset64(unzFile file, int64_t pos);
BUEXPORT int     bu_unzSetOffset(unzFile file, uint32_t pos);
BUEXPORT int64_t bu_unztell(unzFile file);
BUEXPORT int32_t bu_unzTell(unzFile file);
BUEXPORT int64_t bu_unzTell64(unzFile file);
BUEXPORT int     bu_unzSeek(unzFile file, int32_t offset, int origin);
BUEXPORT int     bu_unzSeek64(unzFile file, int64_t offset, int origin);
BUEXPORT int     bu_unzEndOfFile(unzFile file);
BUEXPORT void*   bu_unzGetStream(unzFile file);

/***************************************************************************/

BUEXPORT void bu_fill_fopen_filefunc(zlib_filefunc_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_fopen64_filefunc(zlib_filefunc64_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_win32_filefunc(zlib_filefunc_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_win32_filefunc64(zlib_filefunc64_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_win32_filefunc64A(zlib_filefunc64_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_win32_filefunc64W(zlib_filefunc64_def *pzlib_filefunc_def);
BUEXPORT void bu_fill_memory_filefunc(zlib_filefunc_def *pzlib_filefunc_def);

/***************************************************************************/

#ifdef __cplusplus
}
#endif

#endif
