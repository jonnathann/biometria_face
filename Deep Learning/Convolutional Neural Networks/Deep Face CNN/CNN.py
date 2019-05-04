 #!/usr/bin/env python2
# -*- coding: utf-8 -*-

"""
Created on Fri Aug 31 15:44:59 2018

@author: gria
"""

from keras.models import Sequential
from keras.layers.core import Dense, Dropout, Activation, Flatten
from keras.layers.convolutional import Convolution2D, MaxPooling2D
from keras.utils import np_utils
from sklearn.model_selection import KFold
import pre_processing_cnn as dt
import pylab as plt
import numpy as np
import os as drt
import shutil as sh


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

def accuracy_class(classes, output_cnn):
    
    classes_accuracy = []
    classes_asserts = []
    classes = list(classes)
    classes_unique = np.unique(classes)
    for i in range(len(classes_unique)):
        accumulator = 0
        for j in range(len(output_cnn)):
            if classes_unique[i] == output_cnn[j][2] and output_cnn[j][1] == output_cnn[j][2]:
                
                accumulator += 1
        
        classes_accuracy.append((accumulator*100)/classes.count(0))
        classes_asserts.append(accumulator)
    
    return classes_accuracy, classes_asserts
                
                
def graph_bar(values):
    
    position = np.arange(len(values)) + 0.5
    
    enumeratex = np.arange(len(values)) + 1

    plt.bar(position, values, align="center", color="blue")
    
    plt.xticks(position, enumeratex)
    plt.xlabel("Individuals")
    plt.ylabel("Accuracy %")
    plt.show()               
    

def CNN(x_train, y_train, x_test, y_test, bath_size, nb_classes, nb_epoch, img_rows, img_cols, neurons, nb_conv, nb_pool):

    #number of filters per convolution layer
    nb_filters_conv1 = 32
    nb_filters_conv2 = 32
    nb_filters_conv3 = 16
    nb_filters_conv4 = 16
    nb_filters_conv5 = 16
    nb_filters_conv6 = 16
    
    
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    
    x_train = x_train.astype('float32')
    x_test = x_test.astype('float32')
    
    y_train = np_utils.to_categorical(y_train, nb_classes)
    y_test = np_utils.to_categorical(y_test, nb_classes)
    
    model = Sequential()
    
    model.add(Convolution2D(nb_filters_conv1, nb_conv, nb_conv, border_mode='valid', 
                            input_shape=(img_rows, img_cols, 1)))
    
    #Conv Layer 1
    convout1 = Activation('relu')
    model.add(convout1)

    #Maxpooling Conv Layer 3
    model.add(MaxPooling2D(pool_size=(nb_pool, nb_pool)))    
    
    #Conv Layer 2
    convout2 = Activation('relu')
    model.add(convout2)
    model.add(Convolution2D(nb_filters_conv2, nb_conv, nb_conv))
    
    
    #Conv Layer 3
    convout3 = Activation('relu')
    model.add(convout3)
    model.add(Convolution2D(nb_filters_conv3, nb_conv, nb_conv))
    
    
    #Conv Layer 4
    convout4 = Activation('relu')
    model.add(convout4)
    model.add(Convolution2D(nb_filters_conv4, nb_conv, nb_conv))
    
    
    #Conv Layer 5
    convout5 = Activation('relu')
    model.add(convout5)
    model.add(Convolution2D(nb_filters_conv5, nb_conv, nb_conv))
    
    
     #Conv Layer 6
    convout6 = Activation('relu')
    model.add(convout6)
    model.add(Convolution2D(nb_filters_conv6, nb_conv, nb_conv))
    
    
    #Maxpooling Conv Layer 6
    model.add(MaxPooling2D(pool_size=(nb_pool, nb_pool)))
    
    
    model.add(Dropout(0.25))
    model.add(Flatten())
    
    #Full Connection Layer
    
    #Layer 1 quantidade de Neurônios na camada escondida
    model.add(Dense(neurons))
    model.add(Activation('relu'))
    

    model.add(Dropout(0.5))
    
    #Output Layer
    model.add(Dense(nb_classes))
    model.add(Activation('softmax'))
    ###############################
    
    model.compile(loss='categorical_crossentropy', optimizer='adadelta')
    
    model.fit(x_train, y_train, batch_size=bath_size, nb_epoch=nb_epoch, verbose=1, validation_data=(x_test, y_test))
    
    #model.fit(x_train, y_train, batch_size=bath_size, nb_epoch=nb_epoch, verbose=1, validation_split=0.2)

    predicts = model.predict_classes(x_test)
    predicts_prob = model.predict_proba(x_test)
    predicts_classes = model.predict_classes(x_test)
    return  float(accuracy(predicts, y_test)), predicts, predicts_prob, predicts_classes


def cross_validation():
    
    database = ['ORL', 'jpg', 'labels_multiclass']
    list_images, labels = dt.data_load(database[0], database[1], database[2], 128)

    #Parameters adjusts
    nb_epochs = 60
    nb_neurons = [50, 100, 150]
    nb_conv_pool = [[3, 2], [4, 3]]
    
    ###################
    
    bath_size = 128
    nb_classes = len(np.unique(labels))
    img_rows =128
    img_cols = 128
    list_images = np.array(list_images)
    labels = np.array(labels) 
    
    accuracies = []
    
    for conv_pool in range(len(nb_conv_pool)):
        for nh in range(len(nb_neurons)):
            
            
            #Yp predicts individual
            Yp = np.zeros([len(labels), 1])
    
            folds = list(KFold(n_splits=10, shuffle=True, random_state=1).split(list_images, labels))
            
            str_name_directory = '/media/clodoaldo/Dados/Jonnathann/Experimentos Novos/Deep Learning/Convolutional Neural Networks/Deep Face CNN/RESULT-CNN-DATASET:'+str(database[0])
            #Create directory
                        
            if not drt.path.exists(str_name_directory):
                
                drt.mkdir(str_name_directory)
            
            #Name file
            str_name_file = 'RESULT-CNN-DEEP-FACE-CONV-DIMENSION:'+str(nb_conv_pool[conv_pool][0])+'-POOL DIMENSION:'+str(nb_conv_pool[conv_pool][1])+'-NEURONS-HIDDEN-LAYER:'+str(nb_neurons[nh])+'.txt'

            #Open file
            arq = open(str_name_file, 'w')
            
            #Move file 
            sh.move(str_name_file, str_name_directory)
                                    
            arq.writelines("Folds 1-10: ")
            for i, (id_train, id_test) in enumerate(folds):
        
                print "\nFold:", i+1, " | CNN DEEP FACE| conv dimension:(", nb_conv_pool[conv_pool][0],'x',nb_conv_pool[conv_pool][0] ,")-pool dimension:(", nb_conv_pool[conv_pool][1],'x',nb_conv_pool[conv_pool][1],")-Neurons hidden layer:", nb_neurons[nh], "\n\n"
         
                Xtrain = list_images[id_train]
                Ytrain = labels[id_train]
        
                Xtest = list_images[id_test]
                Ytest = labels[id_test]
    
                accuracy, predicts, _, _ = CNN(Xtrain, Ytrain, Xtest, Ytest, bath_size, nb_classes, nb_epochs, img_rows, img_cols, nb_neurons[nh], nb_conv_pool[conv_pool][0], nb_conv_pool[conv_pool][1])
    
                accuracies.append(accuracy)
    
                #predicts
                predicts = np.reshape(predicts, (len(predicts), 1))
                Yp[id_test] = predicts
                Yp = np.reshape(Yp, (len(Yp), 1))
                Y = np.reshape(labels, (len(labels), 1))
                ########################
        
                arq.writelines(str(round(np.mean(accuracy), 3))+" ")
                
    
            indexs = np.arange(len(labels))
    
            indexs = np.arange(len(labels))
            indexs = np.reshape(indexs, (len(indexs), 1))
            predicts_labels = np.concatenate((indexs, Yp, Y), axis = 1)
    
            classes_accuracy, classes_asserts = accuracy_class(labels, predicts_labels)
    
            arq.writelines("\n\nMean Accuracy: "+str(round(np.mean(accuracies), 3))+"\n")
            arq.writelines("Standard: "+str(round(np.std(accuracies), 3))+"\n\n")
            arq.writelines("Accuracy individual: "+str(classes_accuracy)+"\n\n")
            arq.writelines("Asserts individual: "+str(classes_asserts))
    
            arq.writelines("\n\nIdv\tPred\tLabel")
            for i in range(len(predicts_labels)):
                arq.writelines("\n\n"+str(predicts_labels[i][0])+"\t"+str(predicts_labels[i][1])+"\t"+str(predicts_labels[i][2]))
                #arq.writelines("\n\n"+str(predicts_labels))
            arq.close()
    
        #graph_bar(classes_accuracy)

#execução
cross_validation()


