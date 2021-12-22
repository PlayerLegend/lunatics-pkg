LD = $(CC)
PREFIX ?= /usr/local
DESTDIR ?= $(PREFIX)
CFLAGS += -std=c99
PATH := $(CURDIR)/bin/:$(CURDIR)/sbin/:$(PATH)
BUILD_ENV ?= release

export PATH

all: utils

.PHONY: test bin install

include env/$(BUILD_ENV).makefile

SUB_MAKEFILES != find src -type f -name '*.makefile'
include $(SUB_MAKEFILES)

#debug tests test: CFLAGS += -ggdb -Wall -Werror
#utils benchmarks: CFLAGS += -DNDEBUG -O2
#benchmarks: CFLAGS += -O2

#utils debug: $(UTILS_C) $(UTILS_SH)
#debug: $(TESTS_C) $(TESTS_SH)
#benchmarks: $(BENCHMARKS_C)

#$(UTILS_C) $(TESTS_C): LDLIBS += $(CFLAGS)

$(C_PROGRAMS):
	@mkdir -p $(@D)
	$(LD) -o $@ $^ $> $(LDLIBS)

$(SH_PROGRAMS):
	@mkdir -p $(@D)
	cp $< $@
	chmod +x $@

submodules-init:
	git submodule init

utils:
tests:
run-tests:
	make depend
	make clean
	make BUILD_ENV=debug tests utils
	sh run-tests.sh $(RUN_TESTS)
	make clean

clean-fast:
	rm -rf test bin sbin init `find src -name '*.o'`

clean: clean-fast
	rm -rf external boot

depend: clean
	makedepend -Y `find src -name '*.c*' -or -name '*.h*'`

install:
	cp -v bin/* $(DESTDIR)/bin/
#	printf '%s\n' $(UTILS_C) $(UTILS_SH) | cpio -pudm $(DESTDIR)/

install-user:
	make install DESTDIR=$(HOME)/.local

# DO NOT DELETE

src/log/log.o: src/log/log.h
src/log/test/log.test.o: src/log/log.h
src/window/printf.o: ../range/def.h src/window/def.h src/window/printf.h
src/window/printf.o: src/window/alloc.h src/window/vprintf.h
src/window/vprintf.o: ../range/def.h src/window/def.h
src/window/test/window.test.o: src/range/def.h src/window/def.h
src/window/test/window.test.o: src/window/alloc.h src/log/log.h
src/window/test/printf.test.o: src/range/def.h src/window/def.h
src/window/test/printf.test.o: src/window/printf.h
src/window/string.o: ../range/def.h src/window/def.h src/window/alloc.h
src/window/string.o: src/window/string.h
src/window/alloc.o: ../range/def.h src/window/def.h
src/window/printf.o: ../range/def.h src/window/def.h
src/window/vprintf.o: ../range/def.h src/window/def.h src/window/vprintf.h
src/window/vprintf.o: src/window/alloc.h
src/window/printf_append.o: ../range/def.h src/window/def.h
src/window/printf_append.o: src/window/printf.h src/window/alloc.h
src/window/printf_append.o: src/window/vprintf.h
src/window/def.o: ../range/def.h
src/window/vprintf_append.o: ../range/def.h src/window/def.h
src/window/vprintf_append.o: src/window/vprintf.h src/window/alloc.h
src/window/alloc.o: src/window/string.h ../range/def.h src/window/def.h
src/window/alloc.o: src/window/alloc.h src/log/log.h
src/window/string.o: ../range/def.h src/window/def.h
src/range/path.o: src/window/def.h
src/range/range_strdup.o: src/window/string.h src/window/def.h
src/range/streq.o: src/window/def.h src/window/string.h
src/range/test/range.test.o: src/window/string.h src/window/def.h
src/range/test/range.test.o: src/range/string.h
src/range/strstr.o: src/window/def.h src/window/string.h
src/range/range_atozd.o: src/window/def.h src/window/string.h
src/range/range_strstr_string.o: src/window/string.h src/window/def.h
src/range/range_streq_string.o: src/window/string.h src/window/def.h
src/range/strchr.o: src/window/def.h src/window/string.h
src/range/string.o: src/window/def.h
src/range/path.o: src/window/def.h src/range/path.h
src/convert/fd-bifurcated.o: src/window/def.h src/window/def.h
src/convert/def.o: ../range/def.h src/window/def.h src/window/alloc.h
src/convert/def.o: src/window/def.h src/log/log.h
src/convert/getline.o: ../range/def.h src/window/def.h src/window/def.h
src/convert/fd.o: ../range/def.h src/window/def.h src/window/def.h
src/convert/fd.o: ../keyargs/keyargs.h
src/convert/fd.o: ../range/def.h src/window/def.h src/window/alloc.h
src/convert/fd.o: ../keyargs/keyargs.h src/window/def.h src/convert/fd.h
src/convert/fd.o: src/log/log.h
src/convert/getline.o: src/window/string.h ../range/def.h ../range/string.h
src/convert/getline.o: src/window/def.h src/window/alloc.h
src/convert/getline.o: ../keyargs/keyargs.h src/window/def.h
src/convert/getline.o: src/convert/getline.h src/log/log.h
src/convert/test/cat.test.o: src/range/def.h src/window/def.h
src/convert/test/cat.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/convert/test/cat.test.o: src/window/def.h src/convert/fd.h src/log/log.h
src/convert/test/cat-load-all.test.o: src/range/def.h src/window/def.h
src/convert/test/cat-load-all.test.o: src/window/alloc.h
src/convert/test/cat-load-all.test.o: src/keyargs/keyargs.h src/window/def.h
src/convert/test/cat-load-all.test.o: src/convert/fd.h src/log/log.h
src/convert/test/getline.test.o: src/range/def.h src/window/def.h
src/convert/test/getline.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/convert/test/getline.test.o: src/window/def.h src/convert/fd.h
src/convert/test/getline.test.o: src/convert/getline.h src/log/log.h
src/convert/def.o: ../range/def.h src/window/def.h
src/convert/fd-bifurcated.o: src/window/def.h src/window/alloc.h
src/convert/fd-bifurcated.o: src/window/def.h src/convert/fd-bifurcated.h
src/convert/fd-bifurcated.o: src/log/log.h
