install:
	install -m755 -d /usr/bin
	install -m755 sysinfo /usr/bin

uninstall:
	rm -f /usr/bin/sysinfo
