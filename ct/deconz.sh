#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/nmolenaar/Proxmox/remz/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
       __     __________  _   _______
  ____/ /__  / ____/ __ \/ | / /__  /
 / __  / _ \/ /   / / / /  |/ /  / / 
/ /_/ /  __/ /___/ /_/ / /|  /  / /__
\__,_/\___/\____/\____/_/ |_/  /____/
 
EOF
}
header_info
echo -e "Loading..."
APP="deCONZ"
var_disk="4"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="0"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  FW=1
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/apt/sources.list.d/deconz.list ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating $APP LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated $APP LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
             ${BL}http://${IP}${CL}\n"
