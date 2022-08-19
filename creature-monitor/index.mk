ifeq ($(HOST_SDL2),1)
# host build
all: creature-monitor/creature-monitor
rel: creature-monitor/creature-monitor
INTERMEDIATES += creature-monitor/creature-monitor

creature-monitor/creature-monitor: creature-monitor/main.c creature-monitor/page-elf64.o
	$(CC) creature-monitor/main.c creature-monitor/page-elf64.o -lSDL2 -lSDL2_net -o $@

endif

ifeq ($(W32_SDL2),1)
# w32 build
all: creature-monitor/creature-monitor.exe creature-monitor/SDL2.dll creature-monitor/SDL2_net.dll
rel: creature-monitor/creature-monitor.exe creature-monitor/SDL2.dll creature-monitor/SDL2_net.dll
INTERMEDIATES += creature-monitor/creature-monitor.exe creature-monitor/SDL2.dll creature-monitor/SDL2_net.dll

creature-monitor/creature-monitor.exe: creature-monitor/main.c creature-monitor/page-coff.o
	$(W32_CC) $(W32_CFLAGS_SDL) creature-monitor/main.c creature-monitor/page-coff.o -o $@ -lSDL2 -lSDL2_net

creature-monitor/SDL2.dll:
	cp /usr/local/i686-w64-mingw32/bin/SDL2.dll $@ || cp /usr/i686-w64-mingw32/bin/SDL2.dll $@ || cp /mingw32/bin/SDL2.dll $@

creature-monitor/SDL2_net.dll:
	cp /usr/local/i686-w64-mingw32/bin/SDL2_net.dll $@ || cp /usr/i686-w64-mingw32/bin/SDL2_net.dll $@ || cp /mingw32/bin/SDL2_net.dll $@

endif

INTERMEDIATES += creature-monitor/page-elf64.o creature-monitor/page-coff.o
creature-monitor/page-elf64.o: creature-monitor/page.asm creature-monitor/page.bmp
	$(NASM) -felf64 $< -o $@
creature-monitor/page-coff.o: creature-monitor/page.asm creature-monitor/page.bmp
	$(NASM) -fwin32 $< -o $@
