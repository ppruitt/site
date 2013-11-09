# Global configuration settings

# Where should SSH listen?
SSH_PORT=22760

# Where should openvpn listen
OPENVPN_PORT=22761

# OpenVPN config directory
OPENVPN_DEST_DIR=/etc/openvpn

# Location of our easy-rsa installation
EASY_RSA_DIR="${OPENVPN_DEST_DIR}/easy-rsa"

# Source location of easy-rsa (docs recommend making our own copy)
EASY_RSA_SRC_DIR="/usr/share/doc/openvpn/examples/easy-rsa/2.0"
