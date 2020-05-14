## pip install librosa
#

import time
import matplotlib.pyplot as plt
import librosa
import librosa.display

# wav 采样率转换
def convert_wav(file, rate=16000):
    signal, sr = librosa.load(file, sr=None)
    new_signal = librosa.resample(signal, sr, rate) #
    out_path = file.split('.wav')[0] + "_new.wav"
    librosa.output.write_wav(out_path, new_signal , rate) #保存为音频文件

    return out_path


def waveplot(file, duration=15):
    y, sr = librosa.load(file, duration=duration)
    plt.figure(figsize=(12, 8))
    plt.subplot(3, 1, 1)
    librosa.display.waveplot(y, sr=sr)
    plt.title('Monophonic')
    print(sr)
    print(y)
    plt.show()

file = "/Users/chenwei/Library/Logs/jj.wav"
s = time.clock()
# print(convert_wav(file))
waveplot(file)
print("usage: ", time.clock()-s)


# import sox

# def upsample_wav(file="/home/em/jj.wav", rate="16000"):
#     tfm = sox.Transformer()
#     tfm.rate(rate)
#     out_path = file.split('.wav')[0] + "_hr.wav"
#     tfm.build(file, out_path)
#     return out_path

# upsample_wav()
