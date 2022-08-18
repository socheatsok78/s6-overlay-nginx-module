OUTPUT := output
OUTPUT := $(abspath $(OUTPUT))

all: clean s6-overlay-nginx-module docker-image docker-run

clean:
	rm -rf $(OUTPUT); true

s6-overlay-nginx-module: $(OUTPUT)/s6-overlay-nginx-module.tar.zx

$(OUTPUT)/s6-overlay-nginx-module.tar.zx:
	exec mkdir -p $(OUTPUT)
	exec rm -rf $@.tmp
	cd rootfs && tar -Jcvf $@.tmp --numeric-owner .
	exec mv -f $@.tmp $@

docker-image:
	exec docker build --pull --rm -f "Dockerfile" -t example:latest .

docker-run:
	exec docker run -it --rm -p 8080:80 example:latest

docker-sh:
	exec docker run -it --rm example:latest sh
