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
src/table/test/table-string-map.test.o: src/convert/source.h
src/table/test/table-string-map.test.o: src/convert/fd/source.h
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
src/window/path.o: ../range/def.h src/window/def.h
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
src/window/path.o: ../range/def.h src/window/def.h src/window/path.h
src/window/path.o: src/window/string.h src/window/alloc.h
src/window/string.o: ../range/def.h src/window/def.h
src/range/path.o: src/window/def.h
src/range/range_strdup.o: src/window/string.h src/window/def.h
src/range/streq.o: src/window/def.h src/window/string.h
src/range/test/range.test.o: src/window/string.h src/window/def.h
src/range/test/range.test.o: src/range/string.h
src/range/strstr.o: src/window/def.h src/window/string.h
src/range/range_atozd.o: src/window/def.h src/window/string.h
src/range/string_init.o: src/window/string.h src/window/def.h
src/range/range_strstr_string.o: src/window/string.h src/window/def.h
src/range/range_streq_string.o: src/window/string.h src/window/def.h
src/range/strchr.o: src/window/def.h src/window/string.h
src/range/string.o: src/window/def.h
src/range/path.o: src/window/def.h src/window/path.h
src/convert/source.o: ../range/def.h src/window/def.h
src/convert/duplex.o: ../range/def.h src/window/def.h src/window/alloc.h
src/convert/duplex.o: src/convert/sink.h src/convert/source.h
src/convert/duplex.o: src/convert/duplex.h
src/convert/fd-bifurcated.o: src/window/def.h src/window/def.h
src/convert/sink.o: ../range/def.h src/window/def.h src/window/alloc.h
src/convert/sink.o: src/convert/sink.h src/log/log.h
src/convert/getline.o: ../range/def.h src/window/def.h src/convert/source.h
src/convert/duplex.o: ../range/def.h src/window/def.h src/convert/sink.h
src/convert/duplex.o: src/convert/source.h
src/convert/source.o: ../range/def.h src/window/def.h src/window/alloc.h
src/convert/source.o: src/convert/source.h src/log/log.h
src/convert/fd/sink.o: src/range/def.h src/window/def.h src/window/alloc.h
src/convert/fd/sink.o: src/keyargs/keyargs.h src/convert/source.h
src/convert/fd/sink.o: src/convert/sink.h src/convert/sink.h src/log/log.h
src/convert/fd/source.o: src/range/def.h src/window/def.h src/window/alloc.h
src/convert/fd/source.o: src/keyargs/keyargs.h src/convert/source.h
src/convert/fd/source.o: src/convert/sink.h src/convert/source.h
src/convert/fd/source.o: src/convert/sink.h src/log/log.h
src/convert/fd/sink.o: src/range/def.h src/window/def.h src/convert/source.h
src/convert/fd/sink.o: src/convert/sink.h src/keyargs/keyargs.h
src/convert/fd/source.o: src/range/def.h src/window/def.h
src/convert/fd/source.o: src/convert/source.h src/convert/sink.h
src/convert/fd/source.o: src/keyargs/keyargs.h
src/convert/sink.o: ../range/def.h src/window/def.h
src/convert/getline.o: src/window/string.h ../range/def.h ../range/string.h
src/convert/getline.o: src/window/def.h src/window/alloc.h
src/convert/getline.o: ../keyargs/keyargs.h src/convert/source.h
src/convert/getline.o: src/convert/getline.h src/log/log.h
src/convert/test/cat.test.o: src/range/def.h src/window/def.h
src/convert/test/cat.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/convert/test/cat.test.o: src/convert/source.h src/convert/fd/source.h
src/convert/test/cat.test.o: src/convert/sink.h src/convert/fd/sink.h
src/convert/test/cat.test.o: src/log/log.h
src/convert/test/cat-load-all.test.o: src/range/def.h src/window/def.h
src/convert/test/cat-load-all.test.o: src/window/alloc.h
src/convert/test/cat-load-all.test.o: src/keyargs/keyargs.h
src/convert/test/cat-load-all.test.o: src/convert/source.h
src/convert/test/cat-load-all.test.o: src/convert/fd/source.h
src/convert/test/cat-load-all.test.o: src/convert/sink.h
src/convert/test/cat-load-all.test.o: src/convert/fd/sink.h src/log/log.h
src/convert/test/getline.test.o: src/range/def.h src/window/def.h
src/convert/test/getline.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/convert/test/getline.test.o: src/convert/source.h src/convert/fd/source.h
src/convert/test/getline.test.o: src/convert/sink.h src/convert/fd/sink.h
src/convert/test/getline.test.o: src/convert/getline.h src/log/log.h
src/convert/fd-bifurcated.o: src/window/def.h src/window/alloc.h
src/convert/fd-bifurcated.o: src/window/def.h src/convert/fd-bifurcated.h
src/convert/fd-bifurcated.o: src/log/log.h
src/http/client.o: ../range/def.h src/window/def.h ../keyargs/keyargs.h
src/http/client.o: src/convert/source.h
src/http/http-cat.util.o: ../range/def.h src/window/def.h src/window/alloc.h
src/http/http-cat.util.o: ../keyargs/keyargs.h src/convert/source.h
src/http/http-cat.util.o: src/convert/fd/source.h src/convert/sink.h
src/http/http-cat.util.o: src/convert/duplex.h src/convert/fd/sink.h
src/http/http-cat.util.o: src/http/client.h src/log/log.h
src/http/client.o: src/window/string.h ../range/def.h ../range/string.h
src/http/client.o: src/window/def.h src/window/alloc.h ../keyargs/keyargs.h
src/http/client.o: src/convert/source.h src/convert/fd/source.h src/log/log.h
src/http/client.o: src/network/network.h src/convert/getline.h
src/network/network.o: ../keyargs/keyargs.h
src/network/test/tcp/server.test.o: src/keyargs/keyargs.h src/range/def.h
src/network/test/tcp/server.test.o: src/window/def.h src/window/alloc.h
src/network/test/tcp/server.test.o: src/network/network.h
src/network/test/tcp/server.test.o: src/convert/source.h src/convert/sink.h
src/network/test/tcp/server.test.o: src/convert/fd/source.h
src/network/test/tcp/server.test.o: src/convert/fd/sink.h src/log/log.h
src/network/network.o: ../keyargs/keyargs.h ../range/def.h src/window/def.h
src/network/network.o: src/log/log.h src/window/alloc.h src/network/network.h
src/tar/read.o: src/window/string.h ../range/def.h src/window/def.h
src/tar/read.o: src/window/alloc.h src/window/printf.h src/convert/source.h
src/tar/read.o: ../keyargs/keyargs.h src/tar/common.h src/tar/read.h
src/tar/read.o: src/log/log.h src/tar/internal/spec.h
src/tar/write.o: src/window/string.h ../range/def.h src/window/def.h
src/tar/write.o: src/window/alloc.h ../keyargs/keyargs.h src/convert/sink.h
src/tar/write.o: src/convert/source.h src/convert/duplex.h
src/tar/write.o: src/convert/fd/source.h src/tar/common.h src/tar/write.h
src/tar/write.o: src/tar/internal/spec.h src/log/log.h
src/tar/test/tar-dump-posix-header.test.o: src/keyargs/keyargs.h
src/tar/test/tar-dump-posix-header.test.o: src/range/def.h src/window/def.h
src/tar/test/tar-dump-posix-header.test.o: src/convert/source.h
src/tar/test/tar-dump-posix-header.test.o: src/convert/fd/source.h
src/tar/test/tar-dump-posix-header.test.o: src/tar/internal/spec.h
src/tar/test/tar-dump-posix-header.test.o: src/log/log.h
src/tar/test/list-tar.test.o: src/range/def.h src/window/def.h
src/tar/test/list-tar.test.o: src/window/alloc.h src/keyargs/keyargs.h
src/tar/test/list-tar.test.o: src/convert/source.h src/convert/fd/source.h
src/tar/test/list-tar.test.o: src/tar/internal/spec.h src/log/log.h
src/tar/test/list-tar.test.o: src/tar/common.h src/tar/read.h
src/tar/write.o: ../range/def.h src/window/def.h src/convert/sink.h
src/tar/write.o: src/convert/source.h ../keyargs/keyargs.h src/tar/common.h
src/tar/read.o: ../keyargs/keyargs.h ../range/def.h src/window/def.h
src/tar/read.o: src/convert/source.h src/tar/common.h
src/pkg/install.util.o: ../keyargs/keyargs.h ../range/def.h src/window/def.h
src/pkg/install.util.o: src/window/alloc.h src/convert/source.h
src/pkg/install.util.o: src/convert/fd/source.h src/pkg/root.h
src/pkg/install.util.o: src/pkg/install.h src/log/log.h
src/pkg/root.o: src/window/string.h ../keyargs/keyargs.h src/pkg/root.h
src/pkg/root.o: ../range/def.h ../range/string.h src/window/def.h
src/pkg/root.o: src/window/string.h src/window/alloc.h src/window/printf.h
src/pkg/root.o: src/convert/source.h src/convert/fd/source.h
src/pkg/root.o: src/convert/sink.h src/convert/fd/sink.h
src/pkg/root.o: src/convert/getline.h src/immutable/immutable.h
src/pkg/root.o: src/pkg/internal/def.h src/table/table.h
src/pkg/root.o: src/table/table-string.h src/pkg/internal/mkdir.h
src/pkg/root.o: src/log/log.h src/lang/error/error.h src/lang/tree/tree.h
src/pkg/root.o: src/lang/tokenizer/tokenizer.h
src/pkg/install.o: ../range/def.h src/window/def.h src/convert/source.h
src/pkg/install.o: ../keyargs/keyargs.h src/pkg/root.h
src/pkg/pack.util.o: src/window/string.h ../keyargs/keyargs.h ../range/def.h
src/pkg/pack.util.o: src/convert/sink.h src/convert/fd/sink.h src/pkg/pack.h
src/pkg/pack.util.o: src/log/log.h
src/pkg/update.o: src/immutable/immutable.h ../keyargs/keyargs.h
src/pkg/internal/mkdir.o: src/range/def.h
src/pkg/internal/def.o: src/window/string.h src/keyargs/keyargs.h
src/pkg/internal/def.o: src/pkg/root.h src/range/def.h src/window/def.h
src/pkg/internal/def.o: src/window/string.h src/immutable/immutable.h
src/pkg/internal/def.o: src/table/table.h src/table/table-string.h
src/pkg/internal/mkdir.o: src/window/string.h src/range/def.h
src/pkg/internal/mkdir.o: src/window/def.h src/window/printf.h
src/pkg/internal/mkdir.o: src/window/path.h src/log/log.h src/window/string.h
src/pkg/internal/mkdir.o: src/keyargs/keyargs.h src/immutable/immutable.h
src/pkg/internal/mkdir.o: src/pkg/root.h src/window/def.h
src/pkg/internal/mkdir.o: src/pkg/internal/mkdir.h
src/pkg/manifest.o: src/window/string.h ../keyargs/keyargs.h
src/pkg/pack.o: src/window/string.h ../keyargs/keyargs.h src/pkg/root.h
src/pkg/pack.o: ../range/def.h ../range/string.h src/window/def.h
src/pkg/pack.o: src/window/string.h src/window/path.h src/convert/sink.h
src/pkg/pack.o: src/tar/common.h src/window/alloc.h src/tar/write.h
src/pkg/pack.o: src/log/log.h src/pkg/pack.h
src/pkg/root.o: ../keyargs/keyargs.h
src/pkg/install.o: src/window/string.h ../range/def.h src/window/def.h
src/pkg/install.o: src/window/path.h ../keyargs/keyargs.h
src/pkg/install.o: src/convert/source.h src/convert/sink.h
src/pkg/install.o: src/convert/fd/sink.h src/pkg/root.h src/pkg/install.h
src/pkg/install.o: ../range/string.h src/window/alloc.h src/window/string.h
src/pkg/install.o: src/immutable/immutable.h src/pkg/internal/def.h
src/pkg/install.o: src/table/table.h src/table/table-string.h
src/pkg/install.o: src/pkg/internal/mkdir.h src/tar/common.h src/tar/read.h
src/pkg/install.o: src/log/log.h
src/pkg/pack.o: ../keyargs/keyargs.h ../range/def.h src/window/def.h
src/pkg/pack.o: src/convert/source.h src/convert/sink.h
src/pkg/manifest.o: src/window/string.h ../keyargs/keyargs.h
src/immutable/test/immutable.test.o: src/window/string.h src/range/def.h
src/immutable/test/immutable.test.o: src/immutable/immutable.h
src/immutable/immutable.o: src/window/string.h ../range/def.h
src/immutable/immutable.o: src/immutable/immutable.h src/table/table.h
src/immutable/immutable.o: src/table/table-string.h src/window/def.h
src/immutable/immutable.o: src/window/alloc.h src/window/string.h
src/immutable/immutable.o: ../range/def.h
src/lang/error/error.o: src/log/log.h
src/lang/tree/test/tree.test.o: src/range/def.h src/log/log.h
src/lang/tree/test/tree.test.o: src/window/def.h src/window/alloc.h
src/lang/tree/test/tree.test.o: src/keyargs/keyargs.h src/convert/source.h
src/lang/tree/test/tree.test.o: src/convert/fd/source.h
src/lang/tree/test/tree.test.o: src/lang/error/error.h
src/lang/tree/test/tree.test.o: src/immutable/immutable.h
src/lang/tree/test/tree.test.o: src/lang/tree/tree.h
src/lang/tree/test/tree.test.o: src/lang/tokenizer/tokenizer.h
src/lang/tree/tree.o: src/range/def.h src/window/def.h src/window/alloc.h
src/lang/tree/tree.o: src/immutable/immutable.h src/lang/error/error.h
src/lang/tree/tree.o: src/lang/tree/tree.h src/log/log.h
src/lang/tree/tree.o: src/range/def.h src/window/def.h src/lang/error/error.h
src/lang/tree/tree.o: src/immutable/immutable.h
src/lang/preprocessor/preprocessor.o: src/range/def.h src/window/def.h
src/lang/preprocessor/preprocessor.o: src/lang/error/error.h
src/lang/preprocessor/preprocessor.o: src/immutable/immutable.h
src/lang/preprocessor/preprocessor.o: src/lang/tree/tree.h
src/lang/preprocessor/preprocessor.o: src/lang/preprocessor/preprocessor.h
src/lang/preprocessor/preprocessor.o: src/table/table-string.h
src/lang/preprocessor/preprocessor.o: src/range/def.h src/window/def.h
src/lang/preprocessor/preprocessor.o: src/lang/error/error.h
src/lang/preprocessor/preprocessor.o: src/immutable/immutable.h
src/lang/preprocessor/preprocessor.o: src/lang/tree/tree.h
src/lang/tokenizer/tokenizer.o: src/range/def.h src/table/table.h
src/lang/tokenizer/tokenizer.o: src/table/table-string.h src/window/def.h
src/lang/tokenizer/tokenizer.o: src/window/alloc.h src/convert/source.h
src/lang/tokenizer/tokenizer.o: src/log/log.h src/lang/error/error.h
src/lang/tokenizer/tokenizer.o: src/lang/tokenizer/tokenizer.h
src/lang/tokenizer/test/tokenizer.test.o: src/range/def.h src/window/def.h
src/lang/tokenizer/test/tokenizer.test.o: src/window/alloc.h
src/lang/tokenizer/test/tokenizer.test.o: src/convert/source.h
src/lang/tokenizer/test/tokenizer.test.o: src/keyargs/keyargs.h
src/lang/tokenizer/test/tokenizer.test.o: src/convert/fd/source.h
src/lang/tokenizer/test/tokenizer.test.o: src/lang/error/error.h
src/lang/tokenizer/test/tokenizer.test.o: src/lang/tokenizer/tokenizer.h
src/lang/tokenizer/test/tokenizer.test.o: src/log/log.h
src/lang/tokenizer/tokenizer.o: src/range/def.h src/window/def.h
src/lang/tokenizer/tokenizer.o: src/convert/source.h src/lang/error/error.h
