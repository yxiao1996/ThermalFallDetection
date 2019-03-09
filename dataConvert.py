import re
import cv2
import scipy.io
import numpy as np

def parseString(text): return re.findall(r'\w+.\w+',text)

def stringToDouble(stringData):
    doubleData = []
    for s in stringData:
        doubleData.append(float(s))
    return doubleData

data_fn = "data_stand"
data = stringToDouble(parseString(open("./data/"+data_fn+".txt").read()))
view = False

frames = []
numFrames = int(len(data)/(24*32))
for i in range(numFrames):
    frame = []
    for j in range(24):
        row = []
        for k in range(32):
            idx = i*(24*32) + j*32 + k
            row.append(data[idx])
        frame.append(row)
    frames.append(frame)

if (view):
    for i in range(numFrames):
        demo_frame = np.array(frames[i])/30
        demo_frame = cv2.resize(demo_frame,(320,240))
        cv2.imshow('frame',demo_frame)
        cv2.waitKey(100)
else:
    scipy.io.savemat(data_fn+'.mat',mdict={'data':frames})