.PHONY: dbuild-cryptos-syslinux-x8664
dbuild-cryptos-syslinux-x8664:
	docker run \
		-v ${PWD}:/home/builder/cryptos/src \
		-v ${KEY_DIR}:/home/builder/.abuild \
		-v ${PACKAGES_DIR}:/home/builder/packages \
		registry.gitlab.engr.atlas:443/cryptos/docker-build:x8664 \
		sh -c "cd cryptos/src && abuild checksum && abuild -R -c"
