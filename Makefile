PROGRAM	       	     = dsbmd
CFGFILE	       	     = ${PROGRAM}.conf
RCSCRIPT       	     = rc.d/${PROGRAM}
LOGFILE	       	     = /var/log/${PROGRAM}.log
PIDFILE	      	     = /var/run/${PROGRAM}.pid
SOCKETPATH     	     = /var/run/dsbmd.socket
PREFIX	      	    ?= /usr/local
BINDIR	       	     = ${PREFIX}/libexec
RCDIR	       	     = ${PREFIX}/etc/rc.d
CFGDIR	       	     = ${PREFIX}/etc
DOCSDIR		    ?= ${PREFIX}/share/doc/${PROGRAM}
DOCS		     = README
SOURCES		     = ${PROGRAM}.c config.c dsbcfg/dsbcfg.c fs.c common.c
PROGRAM_FLAGS	     = -Wall ${CFLAGS} ${CPPFLAGS} -DPROGRAM=\"${PROGRAM}\"
PROGRAM_FLAGS	    += -DPATH_DSBMD_LOG=\"${LOGFILE}\"
PROGRAM_FLAGS	    += -DPATH_PID_FILE=\"${PIDFILE}\"
PROGRAM_FLAGS	    += -DPATH_DSBMD_SOCKET=\"${SOCKETPATH}\"
PROGRAM_FLAGS	    += -DPATH_CONFIG=\"${CFGDIR}/${CFGFILE}\"
PROGRAM_LIBS	     = -lgeom -lcam -lutil -lkiconv -lpthread -lusb
BSD_INSTALL_DATA    ?= install -m 0644
BSD_INSTALL_SCRIPT  ?= install -m 555
BSD_INSTALL_PROGRAM ?= install -s -m 555

all: ${PROGRAM} ${RCSCRIPT} ${CFGFILE}

${PROGRAM}: ${SOURCES}
	${CC} -o ${PROGRAM} ${PROGRAM_FLAGS} ${SOURCES} ${PROGRAM_LIBS}

${RCSCRIPT}: ${RCSCRIPT}.tmpl
	sed -e 's|@PATH_PROGRAM@|${BINDIR}/${PROGRAM}|g' \
	    -e 's|@PATH_PIDFILE@|${PIDFILE}|g' \
	< ${.ALLSRC} > ${RCSCRIPT}

${CFGFILE}: ${CFGFILE}.tmpl
	# Remove "large" mount option from config file on FreeBSD >= 12
	version=`freebsd-version -u | awk -F"[.-]" '{ print $$1 }'`; \
	if [ $${version} -ge 12 ]; then \
		sed 's|large,||g' ${CFGFILE}.tmpl > ${CFGFILE}; \
	else cp ${CFGFILE}.tmpl ${CFGFILE}; fi

install: ${PROGRAM} ${RCSCRIPT} ${CFGFILE}
	${BSD_INSTALL_PROGRAM} ${PROGRAM} ${DESTDIR}${BINDIR}
	${BSD_INSTALL_SCRIPT} ${RCSCRIPT} ${DESTDIR}${RCDIR}
	${BSD_INSTALL_DATA} ${CFGFILE} ${DESTDIR}${CFGDIR}/${CFGFILE}.sample
	if [ ! -f ${DESTDIR}${CFGDIR}/${CFGFILE} ]; then \
		${BSD_INSTALL_DATA} ${CFGFILE} ${DESTDIR}${CFGDIR}; \
	fi
	if [ ! -d ${DESTDIR}${DOCSDIR} ]; then \
		mkdir ${DESTDIR}${DOCSDIR}; \
	fi
	${BSD_INSTALL_DATA} ${DOCS} ${DESTDIR}${DOCSDIR}

readme: readme.mdoc
	mandoc -mdoc readme.mdoc | perl -e '  \
	binmode STDIN,  qq(:encoding(UTF-8)); \
	binmode STDOUT, qq(:encoding(UTF-8)); \
	foreach (<STDIN>) { \
		$$_ =~ s/(.)\x08\1/$$1/g; $$_ =~ s/_\x08(.)/$$1/g; print $$_ \
	}' | sed '1,1d' > README

clean:
	-rm -f ${PROGRAM}
	-rm -f ${RCSCRIPT}
	-rm -f ${CFGFILE}

