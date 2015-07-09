import os,sys,shutil
import pyotherside
import subprocess
from basedir import *

cachePath=XDG_CACHE_HOME+"/harbour-yiyaoba/yiyao/"
savePath=HOME+"/Pictures/save/Yiyao/"

def saveImg(md5name,savename):
    try:
        realpath=cachePath+md5name+".jpg"
        isExis()
        shutil.copy(realpath,savePath+savename)
        pyotherside.send("1")
    except:
        pyotherside.send("-1")

def isExis():
    if os.path.exists(savePath):
        pass
    else:
        os.makedirs(savePath)

"""
    缓存图片
"""
def cacheImg(url,md5name):
    cachedFile = cachePath+md5name
    if os.path.exists(cachedFile):
        pass
    else:
        if os.path.exists(cachePath):
            pass
        else:
            os.makedirs(cachePath)
        downloadImg(cachedFile,url)
    return cachedFile

"""
    下载文件

"""
def downloadImg(downname,downurl):
    p = subprocess.Popen("curl -o "+downname+" "+downurl,shell=True)
    #0则安装成功
    retval = p.wait()

def clearImg():
    shutil.rmtree(cachePath)
    pyotherside.send("2")