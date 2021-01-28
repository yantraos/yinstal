
PREFIX="/usr"
DESTDIR=
PKGNAME="yinstal"
PROGRAM="yaps"
HELPER="finddepends"
HELPERCODE="main.cpp"
FUNCTIONS="yapi"
MANPAGE="${PROGRAM}.1"
RCFILE="ypkg.rc"
SETUP="ypkgsetup"

all:
	g++ -o $(HELPER) $(HELPERCODE)

clean:
	rm $(HELPER)||true

install:
	mkdir -vp $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(PREFIX)/share/$(PKGNAME) $(DESTDIR)$(PREFIX)/share/man/man1 $(DESTDIR)/etc||true
	g++ -o $(HELPER) $(HELPERCODE)
	cp $(HELPER) $(PROGRAM) $(DESTDIR)$(PREFIX)/bin
	cp $(MANPAGE) $(DESTDIR)$(PREFIX)/share/man/man1
	cp $(FUNCTIONS) $(SETUP) $(DESTDIR)$(PREFIX)/share/$(PKGNAME)
	cp -n $(RCFILE) $(DESTDIR)/etc/$(RCFILE)

	@echo "**************************************************************"
	@echo "Now set your package options in the file /etc/ypkg.rc"
	@echo "Either manually or by using 'lfspkg --setup'"
	@echo "An example rc file is included in $(PREFIX)/share/$(PKGNAME)"
	@echo 
	@echo "See the manpage for details, but you should set at least:"
	@echo "OUTPUT and SOURCEARCHIVES"
	@echo
	@echo "You should also download the buildscripts from here:"
	@echo "https://github.com/KeithDHedger/yinstalBuilds"
	@echo "Place yinstalBuildScripts and yinscripts in / ."
	@echo "If you place them elsewhere set BUILDSCRIPTS in /etc/ypkg.rc"
	@echo
	@echo "After downloading the build scripts build the database like so:"
	@echo "SIMPLEUPDATE=0 yaps -U"
	@echo
	@echo "**************************************************************"

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/$(HELPER)
	rm $(DESTDIR)$(PREFIX)/bin/$(PROGRAM)
	rm $(DESTDIR)$(PREFIX)/share/man/man1/$(MANPAGE)
	rm -r $(DESTDIR)$(PREFIX)/share/$(PKGNAME)
