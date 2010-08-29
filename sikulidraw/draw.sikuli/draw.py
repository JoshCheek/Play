import time

file = open("/Users/josh/code/play/sikulidraw/pixels.txt")
click(Location(500,500))

while 1:
    line = file.readline()
    if not line:
        break
    xy = line.split()
    click( Location(  280+int(xy[0])  ,  125+int(xy[1]) ) )
    time.sleep(0.1)
    click( Location(  280+int(xy[0])  ,  125+int(xy[1]) ) )
    time.sleep(0.1)