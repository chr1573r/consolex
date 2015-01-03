from mcstatus import MinecraftServer
from sys  import argv

# Crude Minecraft status script

name=argv[1]
host=argv[2]
port=argv[3]

try:
        server = MinecraftServer.lookup(host + ":" + port)
except:
        print "Invalid server"
        exit()
# 'status' is supported by all Minecraft servers that are version 1.7 or higher.
try:
        status = server.status()
        print(name + ":   [ONLINE]   {0} players, {1} ms".format(status.players.online, status.latency))
except:
        print name + ":   [OFFLINE?] Failed to get server status"
