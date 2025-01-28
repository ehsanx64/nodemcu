PORT=/dev/ttyUSB0

show-fsinfo:
	nodemcu-tool -p ${PORT} fsinfo

dev-deps:
	npm install nodemcu-tool -g

dev-tools:
	@echo " source ./tools/aliases.sh"