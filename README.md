# Sunkenland-Dedicated-Server Docker image
Sunkenland Dedicated Server is a Docker Container.
This project is forked from [adrianhowchin/sunkenland](https://github.com/adrianhowchin/sunkenland).

# Table of Contents
* [Basic Docker Usage](#basic-docker-usage)
   *[World setup](#world-setup)
   *[Docker run command](#docker-run-command)
* [Environment Variables](#environment-variables)
   *[Docker Environment Variables](#docker-environment-variables)
   *[Region Code Table](#region-code-table)
* [Misc Notes](misc-notes)
   *[User Manual](#user-manual)
  
# Basic Docker Usage

### World setup
**must be done before docker run**
Currently, there is no way to generate a world on server start, so we need to generate a world in the game itself and mount to container.
1. Move/Copy the world file and make a note of it
    >The world file is located in `C:\Users\<USER_NAME>\AppData\LocalLow\Vector3 Studio\Sunkenland\Worlds`
2. Keep a note of the World GUID from the folder of the world. This will be passed into the `WORLD_GUID` environment variable
    >GUID is the string after the world name and the ~. (some world name~<WORLD_GUID>)
   
    an example format of WORLD_GUID ls `03d40a99-1234-4460-ac27-ca466a676e85`
3.  Volume mount the server World directory to `/opt/sunkenland/` in the Docker container.

### Docker run command
Here is an example of the docker run command
```bash
$ docker run -d \
	--name sunkenland-server \
	-p 29000:27015 \
	-e "PASSWORD=<password>" \
	-e "WORLD_GUID=<world_guid>" \
	-e "REGION=usw" \
	-e "MAX_PLAYER_CAPACITY=15" \
	-v /external/world/folder/location:/opt/sunkenland/ \
	mykevin81/sunkenland-dedicated-server:latest
```

# Environment Variable

**All variable names and values are case-sensitive!**

### Docker Environment Variables

| Name | Default | Purpose | Required |
|----------|----------|-------| ------- |
| `WORLD_GUID` | | World GUID string from the world folder | Yes |
| `PASSWORD` | | Password for logging into the server. Password length limit is 8 | No |
| `REGION` | `USW` | Region for the server location. Check Region Code Table below for more detail. | No |
| `MAKE_SESSION_INVISIBLE` | `false` | Set the session to Invisible so it would not appear in other players' session list and can only be joined by manually entering the ServerID or via Steam Friend Invite. | No |
| `MAX_PLAYER_CAPACITY` | `10` | Set the Max Player Count. The minimum value is 3 and the maximum value is 15 | Yes |


### Region Code Table
| Region | Code |
| --- | --- |
| Asia | asia |
| Chinese Mainland | cn |
| Japan | jp |
| Europe | eu |
| South America | sa |
| South Korea | kr |
| USA, East | us |
| USA, West | usw |

# Misc Notes
 ### User Manual
Official User manual can be downloaded [here](https://download-files.wixmp.com/ugd/36e0da_671cc93711c54abb91a25823df0aa548.pdf?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YXBwOmU2NjYzMGU3MTRmMDQ5MGFhZWExZjE0OWIzYjY5ZTMyIiwic3ViIjoidXJuOmFwcDplNjY2MzBlNzE0ZjA0OTBhYWVhMWYxNDliM2I2OWUzMiIsImF1ZCI6WyJ1cm46c2VydmljZTpmaWxlLmRvd25sb2FkIl0sImlhdCI6MTcwOTE4MTk4NCwiZXhwIjoxNzA5MjE3OTk0LCJqdGkiOiI2ZmY3YWZjNi0yYTA2LTRiMDEtODE1MC1mMGNhY2IxOTQwM2UiLCJvYmoiOltbeyJwYXRoIjoiL3VnZC8zNmUwZGFfNjcxY2M5MzcxMWM1NGFiYjkxYTI1ODIzZGYwYWE1NDgucGRmIn1dXSwiZGlzIjp7ImZpbGVuYW1lIjoiU3Vua2VubGFuZCBEZWRpY2F0ZWQgU2VydmVyIE1hbnVhbCAoU3RlYW0pIDIwMjQwMjAyLnBkZiIsInR5cGUiOiJhdHRhY2htZW50In19.0iRcV48NaO9cDFj7d6Sl2Ip1XuX6nvqTSYA3vSMbV8s)