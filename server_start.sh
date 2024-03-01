#!/bin/bash

# Include default file
source /opt/sunkenland/common.sh

# Pre start check
preStartCheck

# Clean up wine and init
# The server fails to start if we try to do it in our Dockerfile, so need to do it here in the server start script
debug "Initializing wine."
rm -rf ~/.wine
wineboot --init
sleep 15 # Need to sleep to give wineboot init time to complete

# Setup the world
# The server fails to start if we try to do it in our Dockerfile, so need to do it here in the server start script
debug "Mounting Server files."
mkdir -p /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/
cd /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/
ln -s /opt/sunkenland/Worlds /root/.wine/drive_c/users/root/AppData/LocalLow/Vector3\ Studio/Sunkenland/Worlds
cd /opt/sunkenland

# Start Xvfb so the headless graphics works
debug "Start Xvfb server."
Xvfb :1 &
export DISPLAY=:1
echo "Xfvb server start at :1"

# Start the Sunkenland server
cd "/root/Steam/steamapps/common/Sunkenland Dedicated Server"
info "Starting Sunkenland dedicated server. World GUID: ${WORLD_GUID}, Password: ${PASSWORD}, Region: ${REGION}, Session Invisible: ${MAKE_SESSION_INVISIBLE}, Max player: ${MAX_PLAYER_CAPACITY}"
wine Sunkenland-DedicatedServer.exe -nographics -batchmode  -logFile /opt/sunkenland/Worlds/sunkenland.log -maxPlayerCapacity ${MAX_PLAYER_CAPACITY} -password ${PASSWORD} -worldGuid ${GUID} -region ${REGION} -port 27015