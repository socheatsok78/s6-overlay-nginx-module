OUTPUT := output
OUTPUT := $(abspath $(OUTPUT))

all: clean s6-overlay-nginx-module

clean:
	rm -rf $(OUTPUT); true

s6-overlay-nginx-module: $(OUTPUT)/s6-overlay-nginx-module.tar.zx

$(OUTPUT)/s6-overlay-nginx-module.tar.zx:
	exec mkdir -p $(OUTPUT)
	exec rm -rf $@.tmp
	cd rootfs && tar -Jcvf $@.tmp --owner=0 --group=0 --numeric-owner .
	exec mv -f $@.tmp $@
