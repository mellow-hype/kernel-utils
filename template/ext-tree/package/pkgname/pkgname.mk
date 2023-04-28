PKGNAME_VERSION = 1.0
PKGNAME_SITE = "$(BR2_EXTERNAL_PKGNAME_PATH)/../src/pkgname_kmod"
PKGNAME_SITE_METHOD = local
$(eval $(kernel-module))
$(eval $(generic-package))
