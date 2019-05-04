#!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Created on Fri Aug 31 15:41:22 2018

@author: gria
"""

import glob
from scipy.misc import imresize

from scipy import stats as sts
from sklearn.preprocessing import MinMaxScaler

import matplotlib.image as mt
import scipy.io as sio
#import matplotlib.pyplot as plt
import numpy as np
import os
#from keras.preprocessing.image import img_to_array


def min_max(x,inf,sup):
    minimo = float(np.min(x))
    maximo = float(np.max(x))
    max_min = float(maximo - minimo)
    
    x = np.subtract(x, float(minimo))
    x = np.divide(x, float(max_min))
    x = np.multiply(x, float(sup  - inf))
    x = np.add(x, float(inf))
    
    return x

def normm_std(x):

    return np.divide(np.subtract(x, float(np.mean(x))), float(np.std(x)))
        
def data_load(base,extensao,rotulos,dim):
    os.chdir(base)
    
    images = glob.glob("*."+str(extensao))
    
    rotulo = sio.loadmat(rotulos+str('.mat'))
    rotulo = rotulo['rotulos']
    vet_rotulos = []
    for i in range(len(rotulo)):
        vet_rotulos.append(rotulo[i][0])
   
    list_images = np.zeros((len(images),dim,dim),dtype=np.float64)
    
    images = np.sort(images)
    
    cont = 0;
    for name in images:
        read = mt.imread(name)
        testdata = imresize(read,(dim,dim))
        testdata = testdata.tolist()
        testdata = min_max(testdata, 0, 1)
        list_images[cont] = testdata
        cont = cont+1
    
    return list_images, vet_rotulos


def permut_data(i,list_images, vet_rotulos):
    
    np.random.seed(i)
    permut = np.random.permutation(len(list_images))
    
    list_images = list_images[permut]
    vet_rotulos = np.array(vet_rotulos)
    vet_rotulos = vet_rotulos[permut]
    
    
    t_70 = int(np.round(len(list_images)*0.7))
    
    x_train = list_images[1:t_70]
    x_test = list_images[t_70 +1:len(list_images)-1]
    
    y_train = vet_rotulos[1:t_70]
    y_test = vet_rotulos[t_70 +1:len(list_images)-1]
    
    
    return x_train,y_train,x_test,y_test
    
    

