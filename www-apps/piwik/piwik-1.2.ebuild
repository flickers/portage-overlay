# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ampache/ampache-3.5.3.ebuild,v 1.2 2009/12/20 22:54:56 marineam Exp $

inherit webapp depend.php

DESCRIPTION="Piwik is a downloadable, open source (GPL licensed) real time web analytics software program."
HOMEPAGE="http://www.piwik.org/"
# Seems like they don't provide a versionated download
SRC_URI="http://www.piwik.org/latest.zip"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup
	require_php_with_use pdo ctype xml
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	dodir "${MY_HTDOCSDIR}/"{tmp,config}
	doins -r piwik/*

	webapp_serverowned -R "${MY_HTDOCSDIR}/"{tmp,config}
	webapp_postinst_txt en "${FILESDIR}"/installdoc.txt
	webapp_configfile "${MY_HTDOCSDIR}/config/"{global.ini.php,manifest.inc.php}
	webapp_src_install
	fperms -R 0660 "${MY_HTDOCSDIR}/"{tmp,config}
}

pkg_postinst() {
	elog "Install and upgrade instructions can be found here:"
	elog "  http://piwik.org/docs/installation-optimization/"
	webapp_pkg_postinst
}
