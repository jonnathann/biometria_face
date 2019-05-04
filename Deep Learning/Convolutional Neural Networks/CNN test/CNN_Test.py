#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Nov 12 18:19:12 2018

@author: gria
"""

# -*- coding: utf-8 -*- 
import pre_processing_cnn as dt
#from keras.datasets import mnist
from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
from keras.utils import np_utils

import matplotlib.pyplot as plt
#import numpy as np

import keras as k


def best_predict_propabilistic(predict):
    
    best_predicts = []
    for i in range(len(predict)):
        best_predicts.append(max(predict[i]));
        
    return best_predicts
    


#Calculo da acuracia
def accuracy(y_predict, y_test):
    
    list_labels = []
    accumulate = 0.0
    
    #convert labels binary in labels enumerics
    for line in range(len(y_test)):
        for idnt, value in enumerate(y_test[line]):
            if(value == 1):
                list_labels.append(idnt)
               
    #calc accuracy            
    for line in range(len(list_labels)):
        if(y_predict[line] == list_labels[line]):
            accumulate = accumulate + 1
            
    return float((accumulate*100))/float(len(list_labels))

def Deep_Face(x_train, y_train, x_test, y_test, bath_size, nb_classes, nb_epoch, img_rows, img_cols):

    #número de filtros para cada camada de convolução
    nb_filters_conv1 = 32
    nb_filters_conv2 = 32
    nb_filters_conv3 = 16
    nb_filters_conv4 = 16
    nb_filters_conv5 = 16
    nb_filters_conv6 = 16
    
    # variar neuronios:10, 20, 50, 100 e 150
    #subsampling mask
    #epocas: 200 épocas
    nb_pool = 2
    
    #kernel conv
    nb_conv = 3
    
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    
    x_train = x_train.astype('float32')
    x_test = x_test.astype('float32')
    
    y_train = np_utils.to_categorical(y_train, nb_classes)
    y_test = np_utils.to_categorical(y_test, nb_classes)
    
    
    model = Sequential()
    
    model.add(Convolution2D(nb_filters_conv1, nb_conv, nb_conv, border_mode='valid', 
                            input_shape=(img_rows, img_cols, 1)))
    
    #Conv1
    convout1 = Activation('relu')
    model.add(convout1)
    
    #Subsampling Maxpooling (2 x 2)
    model.add(MaxPooling2D(pool_size=(nb_pool, nb_pool)))
    
    #Conv2
    convout2 = Activation('relu')
    model.add(convout2)
    model.add(Convolution2D(nb_filters_conv2, nb_conv, nb_conv))
    
    #Conv3
    convout3 = Activation('relu')
    model.add(convout3)
    model.add(Convolution2D(nb_filters_conv3, nb_conv, nb_conv))
    
    #Conv4
    convout4 = Activation('relu')
    model.add(convout4)
    model.add(Convolution2D(nb_filters_conv4, nb_conv, nb_conv))
    
    #Conv5
    convout5 = Activation('relu')
    model.add(convout5)
    model.add(Convolution2D(nb_filters_conv5, nb_conv, nb_conv))
    
    #Conv6
    convout6 = Activation('relu')
    model.add(convout6)
    model.add(Convolution2D(nb_filters_conv6, nb_conv, nb_conv))

    #Subsampling Maxpooling (2 x 2)
    model.add(MaxPooling2D(pool_size=(nb_pool, nb_pool)))
    
    model.add(Dropout(0.25))
    model.add(Flatten())
    
    model.add(Dense(150))
    
    model.add(Activation('relu'))
    
    model.add(Dropout(0.5))
    
    model.add(Dense(nb_classes))
    
    model.add(Activation('softmax'))
        
    model.compile(loss='categorical_crossentropy', optimizer='adadelta')
    
    #Critério de parada
    early_stopping = k.callbacks.EarlyStopping(monitor='val_loss', min_delta=0, patience=10, verbose=0, mode='min')

    history = model.fit(x_train, y_train, batch_size=bath_size, nb_epoch=nb_epoch, verbose=1, validation_data=(x_test, y_test), callbacks=[early_stopping])
    #model.fit(x_train, y_train, batch_size=bath_size, nb_epoch=nb_epoch, verbose=1, validation_split=0.2)
    
    predicts = model.predict_classes(x_test)
    predicts_prob = model.predict_proba(x_test)
    predict_classes = model.predict_classes(x_test)
    return  float(accuracy(predicts, y_test)), history, predicts, predicts_prob, predict_classes


def Holdout():
    
    bath_size = 128
    nb_classes = 15 #quantidade de indivíduos
    img_rows = 128
    img_cols = 128
    nb_epoch = 2000
    database =['YALE', 'pgm', 'labels_multiclass']
    data, labels = dt.data_load(database[0], database[1], database[2], 128)

    #Método holdout
    x_train, y_train, x_test, y_test = dt.permut_data(1 , data, labels)

    #Treinando o modelo
    accuracy, history, _, predicts_prob, predict_classes = Deep_Face(x_train, y_train, x_test, y_test, bath_size, nb_classes, nb_epoch, img_rows, img_cols)
    print 'Accuracy: ', accuracy
    print 'Size: ', len(predicts_prob), len(predicts_prob[0])
    print 'Best predicts probabilistic: ', best_predict_propabilistic(predicts_prob)
    print 'Predict classes: ', predict_classes
    print 'Ytest: ', y_test
    
    print history.history.keys()
    
    # "Loss"
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('Database '+str(database[0])+' - Deep Face')
    plt.ylabel('loss')
    plt.xlabel('epoch')
    plt.legend(['train', 'validation'], loc='upper left')
    plt.savefig("fig_4_"+str(database[0])+".png")


Holdout()






