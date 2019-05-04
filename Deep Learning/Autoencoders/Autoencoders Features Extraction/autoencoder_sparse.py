
# -*- coding: utf-8 -*-

from keras.layers import Input, Dense
from keras.models import Model
from keras import regularizers as rg

import numpy as np
import os as drt
import shutil as sh
import pre_processing_cnn as dt




def autoencoder_sparse(input_dim, data, neurons_layer, neurons_hidden_layer, epoch, batch):
    
    input_img = Input(shape=(input_dim,))
    #encoded layer 1
    encoded = Dense(neurons_layer, activation='relu')(input_img)
    #encoded layer 2
    encoded = Dense(neurons_hidden_layer, activation='relu', activity_regularizer=rg.l1(10e-9))(encoded)#Features
    #decoded layer 3
    decoded = Dense(neurons_layer, activation='relu')(encoded)
    #decoded layer 4
    decoded = Dense(input_dim, activation='sigmoid', )(decoded)
    
    #build autoencoder
    autoencoder = Model(input_img, decoded)
    encoder = Model(input_img, encoded)

    encoded_input = Input(shape=(neurons_hidden_layer,))
    decoder_layer = autoencoder.layers[-1]
    decoder_layer = autoencoder.layers[-2]
    decoder = Model(encoded_input, decoder_layer(encoded_input))

    autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')
    
    data = data.astype('float32')/255
    data = data.reshape((len(data), np.prod(data.shape[1:])))
    print data.shape

    autoencoder.fit(data, data, epochs=epoch, batch_size=batch, shuffle=True)
    training_data = np.array(encoder.predict(data))
     
    
    #features
    return training_data, decoder
    

def feature_extraction():
    
    database = ['SDUMLA', 'bmp', 'labels_multiclass']
    data, _ = dt.data_load(database[0], database[1], database[2], 128)

    #parameters autoencoder
    input_dim = 16384
    neurons_layer = 1000
    neurons_hidden_layer = [300, 500, 700]
    epochs = 2000

    batch_size = 128
    
    for nhl in range(len(neurons_hidden_layer)):

            
        #display execution
        print "\nDatabase:", database[0],"-Dimension-Features:", neurons_hidden_layer[nhl], "\n" 
            
        encoded_images, _ = autoencoder_sparse(input_dim, data, neurons_layer, neurons_hidden_layer[nhl], epochs, batch_size)
    
    
        #New directory
        str_name_directory ='/media/clodoaldo/Dados/Jonnathann/Experimentos Novos/Deep Learning/Autoencoders/Autoencoders Features Extraction/Autoencoder-Sparse-'+str(database[0])
        #str_name_directory = "/media/clodoaldo/Dados/Jonnathann/Experimentos Novos/Autoencoder/Autoencoders Features Extraction/Autoencoder-Sparse-"+str(database[0])
        if drt.path.exists(str_name_directory) == False:
                
            drt.mkdir(str_name_directory)
        
        #File name
        str_name_file = 'AUTOENCODER-SPARSE-'+str(database[0])+'-NEURONS-HIDDEN-LAYER:'+str(neurons_hidden_layer[nhl])+'.txt'

        #Open file
        arq = open(str_name_file, 'w')
            
        #Move file 
        sh.move(str_name_file, str_name_directory)
    
        #Save features
        for i in range(len(encoded_images)):
    
            for j in range(len(encoded_images[0])):
        
                arq.write(str(encoded_images[i][j])+" ")
            arq.write("\n")
        arq.close()
   
#Execute
feature_extraction()