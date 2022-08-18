OUTPUT := output
OUTPUT := $(abspath $(OUTPUT))

all: clean s6-overlay-nginx-module

clean:
	rm -rf $(OUTPUT); true

s6-overlay-nginx-module: $(OUTPUT)/s6-overlay-nginx-module.tar.zx

$(OUTPUT)/s6-overlay-nginx-module.tar.zx:
	exec mkdir -p $(OUTPUT)
	cd rootfs && tar -Jcvf $@ --owner=0 --group=0 --numeric-owner .
