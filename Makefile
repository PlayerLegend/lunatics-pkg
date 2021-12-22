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
src/table/test/table-string-benchmark.test.o: src/table/table.h
src/table/test/table-string-benchmark.test.o: src/table/table-string.h
src/table/test/table-string-benchmark.test.o: src/keyargs/keyargs.h
src/table/test/table-string-benchmark.test.o: src/log/log.h
src/table/test/table-string-map.test.o: src/range/def.h src/window/def.h
src/table/test/table-string-map.test.o: src/window/string.h
src/table/test/table-string-map.test.o: src/keyargs/keyargs.h
src/table/test/table-string-map.test.o: src/convert/def.h src/convert/fd.h
src/table/test/table-string-map.test.o: src/convert/getline.h
src/table/test/table-string-map.test.o: src/table/table.h
src/table/test/table-string-map.test.o: src/table/table-string.h
src/table/test/table-string-map.test.o: src/log/log.h
src/table/table.o: ../range/def.h
src/table/table-int.o: ../range/def.h src/table/table.h
src/table/table-string.o: ../range/def.h src/table/table.h
src/table/table.o: ../range/def.h src/table/table.h src/table/table-string.h
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
src/tar/read.o: src/window/string.h ../range/def.h src/window/def.h
src/tar/read.o: src/window/alloc.h src/window/printf.h src/convert/def.h
src/tar/read.o: ../keyargs/keyargs.h src/tar/common.h src/tar/read.h
src/tar/read.o: src/log/log.h src/tar/internal/spec.h
src/tar/write.o: src/window/string.h ../range/def.h src/window/def.h
src/tar/write.o: src/window/alloc.h ../keyargs/keyargs.h src/convert/def.h
src/tar/write.o: src/tar/common.h src/tar/write.h src/tar/internal/spec.h
src/tar/write.o: src/log/log.h
src/tar/test/tar-dump-posix-header.test.o: src/keyargs/keyargs.h
src/tar/test/tar-dump-posix-header.test.o: src/range/def.h src/window/def.h
src/tar/test/tar-dump-posix-header.test.o: src/convert/def.h src/convert/fd.h
src/tar/test/tar-dump-posix-header.test.o: src/tar/internal/spec.h
src/tar/test/tar-dump-posix-header.test.o: src/log/log.h
src/tar/test/list-tar.test.o: src/range/def.h src/window/def.h
src/tar/test/list-tar.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/tar/test/list-tar.test.o: src/convert/def.h src/convert/fd.h
src/tar/test/list-tar.test.o: src/tar/internal/spec.h src/log/log.h
src/tar/test/list-tar.test.o: src/tar/common.h src/tar/read.h
src/tar/write.o: ../range/def.h src/window/def.h ../keyargs/keyargs.h
src/tar/write.o: src/tar/common.h
src/tar/read.o: ../keyargs/keyargs.h ../range/def.h src/window/def.h
src/tar/read.o: src/convert/def.h src/tar/common.h
src/pkg/install.util.o: ../keyargs/keyargs.h src/log/log.h
src/pkg/root.o: src/window/string.h ../keyargs/keyargs.h src/pkg/root.h
src/pkg/root.o: ../range/def.h src/window/def.h src/pkg/internal.h
src/pkg/root.o: src/table/table.h src/table/table-string.h src/convert/def.h
src/pkg/root.o: src/log/log.h
src/pkg/install.o: ../range/def.h src/window/def.h src/convert/def.h
src/pkg/install.o: ../keyargs/keyargs.h src/pkg/root.h
src/pkg/internal.o: src/window/string.h ../keyargs/keyargs.h src/pkg/root.h
src/pkg/internal.o: ../range/def.h src/window/def.h src/table/table.h
src/pkg/internal.o: src/table/table-string.h
src/pkg/pack.util.o: src/window/string.h ../keyargs/keyargs.h src/log/log.h
src/pkg/update.o: ../keyargs/keyargs.h
src/pkg/manifest.o: src/window/string.h ../keyargs/keyargs.h
src/pkg/pack.o: src/window/string.h ../keyargs/keyargs.h ../range/def.h
src/pkg/pack.o: src/window/def.h src/tar/common.h src/tar/write.h
src/pkg/pack.o: src/log/log.h src/convert/def.h
src/pkg/root.o: ../keyargs/keyargs.h
src/pkg/install.o: src/window/string.h ../range/def.h src/window/def.h
src/pkg/install.o: src/convert/def.h ../keyargs/keyargs.h src/pkg/root.h
src/pkg/install.o: src/pkg/install.h ../range/string.h src/window/alloc.h
src/pkg/install.o: src/window/string.h src/pkg/internal.h src/table/table.h
src/pkg/install.o: src/table/table-string.h src/tar/common.h src/tar/read.h
src/pkg/install.o: src/log/log.h src/convert/fd.h
src/pkg/manifest.o: src/window/string.h ../keyargs/keyargs.h
