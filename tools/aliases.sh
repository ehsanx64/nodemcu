NODEMCU_PORT=/dev/ttyUSB0
ESPTOOL=esptool.py
alias nt-help='nodemcu-tool'
alias nt="nodemcu-tool -p ${NODEMCU_PORT} "
alias esp-flash="${ESPTOOL} -p ${NODEMCU_PORT} write_flash -fm qio 0x0 bin/nodemcu-release-20-modules-2025-01-03-21-00-16-float.bin"
alias ntput="nodemcu-tool -p ${NODEMCU_PORT} upload "
alias ntget="nodemcu-tool -p ${NODEMCU_PORT} download "