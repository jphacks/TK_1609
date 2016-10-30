#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict
import numpy as np
import chainer
import chainer.functions as F
import pickle

class Predict_Haraodori:
  def __init__(self, model_path):
    self.model = pickle.load(open(model_path, 'rb'))

  def forword(self, log_list, model, train=False, result=False):
    #dataをvarへ変換
    log_list_np = np.array([log_list], np.float32)
    log_list_var = chainer.Variable(log_list_np, volatile=not train)
    #NN
    h1 = F.tanh(model.w1(log_list_var))
    y = F.tanh(model.w2(h1))
    return y.data.argmax(1)[0]

  def preprocess(self, data):
    """
    入力データの形式
    {accelX:127,accelY:127,accelZ:127,gyroX:187,gyroY:106,gyroZ:101,pressure:101,bendThumb:130,bendIndex:99,bendMiddle:1,bendRing:66,bendPinkie:144}{accelX:127,accelY:127,accelZ:127,gyroX:187,gyroY:106,gyroZ:101,pressure:101,bendThumb:130,bendIndex:99,bendMiddle:1,bendRing:66,bendPinkie:144}{accelX:127,accelY:127,accelZ:127,gyroX:187,gyroY:106,gyroZ:101,pressure:101,bendThumb:130,bendIndex:99,bendMiddle:1,bendRing:66,bendPinkie:144}
    """
    logs = defaultdict(lambda: [])
    log_lists = []
    for line in data.strip()[1:-1].split("}{"):
      items = line.strip().split(",")
      for item in items:
        k, v = item.split(":")
        logs[k].append(v)
  
      #if logs["BPM"] and len(logs["BPM"]) == 1 * int(logs["BPM"]): #ここの数字はBPMとビートの関係から計算 ここは前処理がいらない分岐
      if "accelX" in logs and len(logs["accelX"]) == 3:
        log_list = list(map(int, logs["accelX"] + logs["accelY"] + logs["accelZ"] + logs["gyroX"] + logs["gyroY"] + logs["gyroZ"] \
                   + logs["pressure"] + logs["bendThumb"] + logs["bendIndex"] + logs["bendMiddle"] + logs["bendRing"] + logs["bendPinkie"]))
      else: #ビートのBPMがデフォルト設定以外の時
        pass #後で
    return log_list


  def predict(self, data):
    log_data = self.preprocess(data)
    pred = self.forword(log_data, self.model, train=False)
    return pred


if __name__ == '__main__':
  pass
