import numpy as np
# from scipy import signal #findpeaks not set up
from detect_peaks import detect_peaks
import matplotlib.pyplot as plt
import biosig

### Prueba en Matlab-Biosig
# Data load
dataset = biosig.data("Data01.hl7")

# Counting number of channels.
## NOT useful at the moment
channels = np.prod(dataset.shape)/len(dataset)

# Taking the data for every channel
#dataset_ch1 = dataset[0:len(dataset),0]
#dataset_ch2 = dataset[0:len(dataset),1]
#dataset_ch3 = dataset[0:len(dataset),2]
dataset_ch4 = dataset[10000:11000,0]

#dataRange = dataSource[180:240]

fs = 250
N = len(dataset_ch4)/fs # seconds
t = np.linspace(0, N, len(dataset_ch4))

fig = plt.figure()  # an empty figure with no axes
plt.plot(t, dataset_ch4, label='Channel 1')
plt.xlim((0,max(t)))
plt.ylim((min(dataset_ch4), max(dataset_ch4)))
plt.show()

# Find R peaks
m = max(dataset_ch4)
#peakind = signal.find_peaks_cwt(dataset_ch1, m/2)
indexes = detect_peaks(dataset_ch4, mph=m/2, mpd=fs/2)


#fs = hd.SampleRate;  # fs = 250
#N = length(ecg1);
##t=(1:N)'/fs;
#plot(t, -ecg1(:,1))  # Derivación 1 (ver hd.Label)
#plot(t, -ecg1(:,3))  # Derivación 3, parece ser V1 (ver hd.Label)
# Encontar los picos de la onda R con función findpeaks de matlab
# Busacamos picos a partir del máximo del ECG /2
#m=max(-ecg1(:,1))
#[pic,pos] = findpeaks(-ecg1(:,1), 'MinPeakHeight',m/2);
#plot(t, -ecg1(:,1),pos/fs,pic,'or')
# Vamos remuestrear a 1000 samp/sec con splines
#fs2 =1000;
#t1000 = (1/fs2:1/fs2:t(end));
#ecg1000 = spline(t',ecg1',t1000);
#[pic2,pos2] = findpeaks(-ecg1000(1,:),'MINPEAKHEIGHT',m/2);
#plot(t, -ecg1(:,1),t1000,-ecg1000(1,:),pos/fs,pic,'or',pos2/f2,pic2,'+g')
# Observa un pico de R de un latido y verás la mejora al interpolar
#####
