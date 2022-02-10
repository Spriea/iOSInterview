/* bu_sstrm_os.h -- Stream for filesystem access
   Version 2.9.2, February 12, 2020
   part of the MiniZip project

   Copyright (C) 2010-2020 Nathan Moinvaziri
     https://github.com/nmoinvaz/minizip

   This program is distributed under the terms of the same license as zlib.
   See the accompanying LICENSE file for the full text of the license.
*/

#ifndef bu_STREAM_OS_H
#define bu_STREAM_OS_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************************************************************/

int32_t bu_stream_os_open(void *stream, const char *path, int32_t mode);
int32_t bu_stream_os_is_open(void *stream);
int32_t bu_stream_os_read(void *stream, void *buf, int32_t size);
int32_t bu_stream_os_write(void *stream, const void *buf, int32_t size);
int64_t bu_stream_os_tell(void *stream);
int32_t bu_stream_os_seek(void *stream, int64_t offset, int32_t origin);
int32_t bu_stream_os_close(void *stream);
int32_t bu_stream_os_error(void *stream);

void*   bu_stream_os_create(void **stream);
void    bu_stream_os_delete(void **stream);

void*   bu_stream_os_get_interface(void);

/***************************************************************************/

#ifdef __cplusplus
}
#endif

#endif
