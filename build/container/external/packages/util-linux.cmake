#
# Config
#

# See http://www.zlib.net
set(UtilLinux_VERSION 2.29)
set(UtilLinux_URL https://www.kernel.org/pub/linux/utils/util-linux/v${UtilLinux_VERSION}/util-linux-${UtilLinux_VERSION}.tar.gz)
set(UtilLinux_URL_SHA256 36d2fe6fcc962b6b4354ecd427ad766bc4ad29581f83afe67c3eadbdc5245a1f)

message(STATUS "External: Building util-linux ${UtilLinux_VERSION}")

#
# Build
#

set(UtilLinux_CFLAGS "-fPIC -O2")

set(UtilLinux_Config_Args
  --disable-all-programs
  --disable-bash-completion
  --disable-colors-default
  --disable-shared
  --enable-libblkid
  --enable-libuuid
  --without-cap-ng
  --without-libz
  --without-ncurses
  --without-ncursesw
  --without-python
  --without-tinfo
  --without-user
  )

ExternalProject_Add(util-linux
  PREFIX ${EXTERNAL_ROOT}

  URL ${UtilLinux_URL}
  URL_HASH SHA256=${UtilLinux_URL_SHA256}

  DOWNLOAD_DIR ${EXTERNAL_DOWNLOAD_DIR}
  BUILD_IN_SOURCE 1

  PATCH_COMMAND true
  CONFIGURE_COMMAND ./configure CFLAGS=${UtilLinux_CFLAGS} --prefix=<INSTALL_DIR> --host=${EXTERNAL_CROSS_TRIPLE} --libdir=<INSTALL_DIR>/lib/${EXTERNAL_CROSS_TRIPLE} ${UtilLinux_Config_Args}
  BUILD_COMMAND $(MAKE) libblkid.la libuuid.la
  INSTALL_COMMAND $(MAKE) install

  LOG_DOWNLOAD ${EXTERNAL_LOGGING}
  LOG_PATCH ${EXTERNAL_LOGGING}
  LOG_CONFIGURE ${EXTERNAL_LOGGING}
  LOG_BUILD ${EXTERNAL_LOGGING}
  LOG_INSTALL ${EXTERNAL_LOGGING})
