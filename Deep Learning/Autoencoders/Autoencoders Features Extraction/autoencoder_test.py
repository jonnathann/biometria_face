from keras.layers import Input, Dense
from keras.models import Model
import numpy as np
import keras as k

# use Matplotlib (don't ask)
import matplotlib.pyplot as plt
import pre_processing_cnn as dt

# this is the size of our encoded representations
encoding_dim = 700  # 32 floats -> compression of factor 24.5, assuming the input is 784 floats

# this is our input placeholder
input_img = Input(shape=(16384,))
# "encoded" is the encoded representation of the input
encoded = Dense(1000, activation='relu')(input_img)
encoded = Dense(encoding_dim, activation='relu')(encoded)
# "decoded" is the lossy reconstruction of the input
decoded = Dense(1000, activation='relu')(encoded)
decoded = Dense(16384, activation='sigmoid')(decoded)

# this model maps an input to its reconstruction
autoencoder = Model(input_img, decoded)

# this model maps an input to its encoded representation
encoder = Model(input_img, encoded)

# create a placeholder for an encoded (32-dimensional) input
encoded_input = Input(shape=(encoding_dim,))
# retrieve the last layer of the autoencoder model
decoder_layer = autoencoder.layers[-1]
decoder_layer = autoencoder.layers[-2]
# create the decoder model
decoder = Model(encoded_input, decoder_layer(encoded_input))


autoencoder.compile(optimizer='adadelta', loss='binary_crossentropy')


database =['SDUMLA', 'bmp', 'labels_multiclass']
data, _ = dt.data_load(database[0], database[1], database[2], 128)

#permutando dados
data = np.array(data)
data = data[np.random.permutation(len(data))]

#holdout
tam_70 = int(round(len(data) * 0.7))
print int(tam_70)

x_train = data[0:tam_70]
x_test = data[tam_70 + 1:len(data)] 

#x_train = sts.zscore(x_train)
#x_test = sts.zscore(x_test)

x_train = x_train.astype('float32')/255
x_test = x_test.astype('float32')/255
x_train = x_train.reshape((len(x_train), np.prod(x_train.shape[1:])))
x_test = x_test.reshape((len(x_test), np.prod(x_test.shape[1:])))
print x_train.shape
print x_test.shape

early_stopping = k.callbacks.EarlyStopping(monitor='val_loss', min_delta=0, patience=0, verbose=0, mode='min')
history = autoencoder.fit(x_train, x_train,
                epochs=2000,
                batch_size=128,
                shuffle=True,
                validation_data=(x_test, x_test), callbacks=[early_stopping])


# encode and decode some digits
# note that we take them from the *test* set
encoded_imgs = encoder.predict(x_test)
decoded_imgs = decoder.predict(encoded_imgs)


print history.history.keys()


# "Loss"
plt.plot(history.history['loss'])
plt.plot(history.history['val_loss'])
plt.title('Database '+str(database[0])+' - Dimension - '+str(encoding_dim))
plt.ylabel('loss')
plt.xlabel('epoch')
plt.legend(['train', 'validation'], loc='upper left')

plt.savefig("fig_"+str(database[0])+"_dimension_"+str(encoding_dim)+".png")


arq = open("samples_training_validation"+str(database[0])+"_dimension_"+str(encoding_dim), 'w')
for i in range(len(history.history['val_loss'])):
    arq.write(str(history.history['loss'][i])+" "+str(history.history['val_loss'][i])+"\n")
arq.close()