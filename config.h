/*-
 * Copyright (c) 2016 Marcel Kaiser. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define CFGVERSION 1003

enum {
	CFG_MNTDIR, CFG_CD9660_MNTCMD, CFG_MSDOSFS_MNTCMD, CFG_NTFS_MNTCMD,
	CFG_UFS_MNTCMD, CFG_EXT_MNTCMD, CFG_EXFAT_MNTCMD, CFG_MTPFS_MNTCMD,
	CFG_PTPFS_MNTCMD, CFG_EXT4_MNTCMD, CFG_HFSP_MNTCMD, CFG_XFS_MNTCMD,

	CFG_CD9660_MNTCMD_U, CFG_MSDOSFS_MNTCMD_U, CFG_NTFS_MNTCMD_U,
	CFG_UFS_MNTCMD_U, CFG_EXT_MNTCMD_U, CFG_EXFAT_MNTCMD_U,
	CFG_MTPFS_MNTCMD_U, CFG_PTPFS_MNTCMD_U, CFG_EXT4_MNTCMD_U,
	CFG_HFSP_MNTCMD_U, CFG_XFS_MNTCMD_U,

	CFG_CD9660_OPTS, CFG_MSDOSFS_OPTS, CFG_NTFS_OPTS, CFG_UFS_OPTS,
	CFG_EXT_OPTS, CFG_EXFAT_OPTS, CFG_MSDOSFS_LOCALE, CFG_EXT4_OPTS,
	CFG_MTPFS_OPTS, CFG_PTPFS_OPTS, CFG_HFSP_OPTS, CFG_XFS_OPTS,

	CFG_CDRSPEED, CFG_MAX_CLIENTS, CFG_POLL_INTERVAL, CFG_POLL_EXCEPTIONS,
	CFG_ALLOW_USERS, CFG_ALLOW_GROUPS, CFG_USERMOUNT, CFG_PRELOAD_KMODS,
	CFG_PROCMAXWAIT, CFG_MNTCHK_INTERVAL, CFG_UNMOUNT_ON_EXIT,
	CFG_CFG_VERSION, CFG_NVARS
};

extern dsbcfg_vardef_t vardefs[];
extern const int nvardefs;
extern void check_cfg_version(dsbcfg_t *);

