install:
	install -m755 -d $(DESTDIR)/usr/bin
	install -m755 sysinfo $(DESTDIR)/usr/bin

uninstall:
	rm -f $(DESTDIR)/usr/bin/sysinfo
