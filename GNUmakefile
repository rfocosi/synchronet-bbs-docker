# $Id: GNUmakefile,v 1.75 2019/07/03 20:59:41 rswindell Exp $
# Global GNU makefile for Synchronet
#
# Usage:
# ------
# [g]make install [variable=value]...
#
# variables:
# ----------
# DEBUG = Set to force a debug build
# RELEASE = Set to force a release build
# SYMLINK = Don't copy binaries, rather create symlinks in $(SBBSDIR)/exec
# SBBSDIR = Directory to do CLASSIC install to
# PREFIX = Set to the UNIX base directory to install to
# bcc = Set to use Borland compiler
# os = Set to the OS name (Not required)
# SBBSUSER = Owner for the installed files
# SBBSGROUP = Group for the installed files
# NOCVS	= do not do CVS update
# JSLIB = Library name of JavaScript library.
# JSLIBDIR = Full path to JavaScript library
# CRYPTLIBINCLUDE = Path to cryptlib header file(s)
# CRYPTLIBDIR = Path to libcl.*
# NSPRDIR = Path to nspr4 library
# NSPRINCLUDE = Path to NSPR header files
# SDL_CONFIG = Path to sdl-config program
# CVSTAG = CVS tag to pull
# NO_X = Don't include build conio library (ciolib) for X
# NO_GTK = Don't build GTK-based sysop tools
# X_PATH = /path/to/X (if not /usr/X11R6)

# the magic bit:
MKFLAGS += MAKEFLAGS=
ifndef DEBUG
 ifndef RELEASE
  RELEASE	:=	1
 endif
endif

ifdef SYMLINK
 INSBIN	:=	ln -sf
else
 INSBIN	:=	cp
endif

ifdef bcc
 CCPRE	:=	bcc
 MKFLAGS	+=	bcc=1
else
 CC		?= gcc
 CCPRE	?= ${shell if [ `echo __clang__ | $(CC) -E - | grep -v '^\#'` != __clang__ ] ; then echo clang ; elif [ `echo __INTEL_COMPILER | $(CC) -E - | grep -v '^\#'` != __INTEL_COMPILER ] ; then echo icc ; else echo gcc ; fi}
 CCPRE := $(lastword $(subst /, ,$(CCPRE)))
endif

CVSTAG	?=	HEAD		# CVS tag to pull... HEAD means current.

SBBSUSER	?= $(USER)
SBBSGROUP	?= $(GROUP)
SBBSCHOWN	:= $(SBBSUSER):$(SBBSGROUP)

SBBSDIR	?=	$(shell pwd)
export SBBSDIR

# Get OS
ifndef os
 os       =      $(shell uname)
endif
os      :=      $(shell echo $(os) | tr '[A-Z]' '[a-z]' | tr ' ' '_')

machine   :=  $(shell if uname -m | egrep -v "(i[3456789]|x)86" > /dev/null; then uname -m | tr "[A-Z]" "[a-z]" | tr " " "_" ; fi)
machine		:=	$(shell if uname -m | egrep "64" > /dev/null; then uname -m | tr "[A-Z]" "[a-z]" | tr " " "_" ; else echo $(machine) ; fi)
ifeq ($(machine),x86_64)
 machine        := 	x64
endif
ifeq ($(machine),)
 machine        :=      $(os)
else
 machine        :=      $(os).$(machine)
endif

MKFLAGS	+=	os=$(os)

ifdef DEBUG
 BUILD  :=  debug
 MKFLAGS	+=	DEBUG=1
else
 BUILD  :=  release
 MKFLAGS	+=	RELEASE=1
endif
BUILDPATH	?=	$(BUILD)

ifdef JSLIB
 MKFLAGS	+=	JSLIB=$(JSLIB)
endif

ifdef JSLIBDIR
 MKFLAGS	+=	JSLIBDIR=$(JSLIBDIR)
endif

ifdef CRYPTLIBINCLUDE
 MKFLAGS	+=	CRYPTLIBINCLUDE=$(CRYPTLIBINCLUDE)
endif

ifdef CRYPTLIBDIR
 MKFLAGS	+=	CRYPTLIBDIR=$(CRYPTLIBDIR)
endif

ifdef NSPRDIR
 MKFLAGS	+=	NSPRDIR=$(NSPRDIR)
endif

ifdef NSPRINCLUDE
 MKFLAGS	+=	NSPRINCLUDE=$(NSPRINCLUDE)
endif

ifdef SDL_CONFIG
 MKFLAGS	+=	SDL_CONFIG=$(SDL_CONFIG)
endif

ifdef NO_X
 MKFLAGS	+=	NO_X=$(NO_X)
endif

ifdef X_PATH
 MKFLAGS	+=	X_PATH=$(X_PATH)
endif

all: minimal externals

minimal: sbbs3 syncview sexpots baja

externals: sbj dpoker tbd

baja: run
	$(MAKE) -C $(SBBSDIR)/exec $(MKFLAGS) BAJAPATH=$(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/baja

sbbs3: src
	$(MAKE) -C $(SBBSDIR)/src/sbbs3 $(MKFLAGS)

sexpots: src
	$(MAKE) -C $(SBBSDIR)/src/sexpots $(MKFLAGS)

sbj: xtrn
	$(MAKE) -C $(SBBSDIR)/xtrn/sbj $(MKFLAGS)

dpoker: xtrn
	$(MAKE) -C $(SBBSDIR)/xtrn/dpoker $(MKFLAGS) SBBS_SRC=$(SBBSDIR)/src/sbbs3/ XPDEV=$(SBBSDIR)/src/xpdev/

tbd: xtrn
	$(MAKE) -C $(SBBSDIR)/xtrn/tbd $(MKFLAGS) SBBS_SRC=$(SBBSDIR)/src/sbbs3/ XPDEV=$(SBBSDIR)/src/xpdev/

syncview:
	$(MAKE) -C $(SBBSDIR)/src/sbbs3/syncview $(MKFLAGS) SBBS_SRC=$(SBBSDIR)/src/sbbs3/ XPDEV=$(SBBSDIR)/src/xpdev/

install:
	@echo Installing to $(SBBSDIR)
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/showstat $(SBBSDIR)/exec/showstat
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/readsauce $(SBBSDIR)/exec/readsauce
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/dstsedit $(SBBSDIR)/exec/dstsedit
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/smbactiv $(SBBSDIR)/exec/smbactiv
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/dupefind $(SBBSDIR)/exec/dupefind
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/delfiles $(SBBSDIR)/exec/delfiles
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/allusers $(SBBSDIR)/exec/allusers
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/qwknodes $(SBBSDIR)/exec/qwknodes
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/asc2ans $(SBBSDIR)/exec/asc2ans
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/ans2asc $(SBBSDIR)/exec/ans2asc
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/jsexec $(SBBSDIR)/exec/jsexec
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/baja $(SBBSDIR)/exec/baja
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/unbaja $(SBBSDIR)/exec/unbaja
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/slog $(SBBSDIR)/exec/slog
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/node $(SBBSDIR)/exec/node
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/chksmb $(SBBSDIR)/exec/chksmb
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/fixsmb $(SBBSDIR)/exec/fixsmb
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/addfiles $(SBBSDIR)/exec/addfiles
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/makeuser $(SBBSDIR)/exec/makeuser
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/smbutil $(SBBSDIR)/exec/smbutil
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/sbbs $(SBBSDIR)/exec/sbbs
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/sbbsecho $(SBBSDIR)/exec/sbbsecho
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/sexyz $(SBBSDIR)/exec/sexyz
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/echocfg $(SBBSDIR)/exec/echocfg
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).exe.$(BUILDPATH)/filelist $(SBBSDIR)/exec/filelist
	$(INSBIN) $(SBBSDIR)/src/sbbs3/scfg/$(CCPRE).$(machine).exe.$(BUILDPATH)/scfg $(SBBSDIR)/exec/scfg
	$(INSBIN) $(SBBSDIR)/src/sbbs3/umonitor/$(CCPRE).$(machine).exe.$(BUILDPATH)/umonitor $(SBBSDIR)/exec/umonitor
	$(INSBIN) $(SBBSDIR)/src/sbbs3/uedit/$(CCPRE).$(machine).exe.$(BUILDPATH)/uedit $(SBBSDIR)/exec/uedit
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).lib.$(BUILDPATH)/libsbbs.so $(SBBSDIR)/exec/libsbbs.so
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).lib.$(BUILDPATH)/libftpsrvr.so $(SBBSDIR)/exec/libftpsrvr.so
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).lib.$(BUILDPATH)/libmailsrvr.so $(SBBSDIR)/exec/libmailsrvr.so
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).lib.$(BUILDPATH)/libservices.so $(SBBSDIR)/exec/libservices.so
	$(INSBIN) $(SBBSDIR)/src/sbbs3/$(CCPRE).$(machine).lib.$(BUILDPATH)/libwebsrvr.so $(SBBSDIR)/exec/libwebsrvr.so
	$(INSBIN) $(SBBSDIR)/src/sbbs3/syncview/$(CCPRE).$(machine).exe.$(BUILDPATH)/syncview $(SBBSDIR)/exec/syncview
	$(INSBIN) $(SBBSDIR)/src/sexpots/$(CCPRE).$(machine).exe.$(BUILDPATH)/sexpots $(SBBSDIR)/exec/sexpots
	-chown -R $(SBBSCHOWN) $(SBBSDIR)
	-chown -h $(SBBSCHOWN) $(SBBSDIR)/exec/*

# CVS checkout command-line
CVS_CO = @cd $(SBBSDIR); cvs -d :pserver:anonymous@cvs.synchro.net:/cvsroot/sbbs co -r $(CVSTAG)

src: lib
ifndef NOCVS
	$(CVS_CO) src-sbbs3
endif

run:
ifndef NOCVS
	$(CVS_CO) ctrl exec node1 node2 node3 node4 text web
endif

xtrn: run
ifndef NOCVS
	$(CVS_CO) xtrn
endif

lib:
ifndef NOCVS
	$(CVS_CO) lib
endif

cvslogin: $(SBBSDIR)
ifndef NOCVS
	@echo Press \<ENTER\> when prompted for password
	@cvs -d :pserver:anonymous@cvs.synchro.net:/cvsroot/sbbs login
endif

$(SBBSDIR):
	@[ ! -e $(SBBSDIR) ] && mkdir $(SBBSDIR);
