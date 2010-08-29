import time
switchApp("Safari.app")

wait("1273532399551.png")
click("1273532399551.png")

file = open("/Users/josh/Desktop/commands.txt")

while 1:
    line = file.readline()
    if not line:
        break
    type( line + Key.ENTER )
    time.sleep(0.2)