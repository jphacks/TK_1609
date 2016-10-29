#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from collections import defaultdict
import numpy as np
import time
from argparse import ArgumentParser
import chainer
import chainer.functions as F
from chainer import optimizers
#from chainer import Chain, Variable, functions, links, optimizer, optimizers, serializers
import pickle

def parse_args():
  #def_vocab = 30000
  def_embed = 256
  def_hidden = 5
  def_epoch = 20
  def_minibatch = 2

  p = ArgumentParser(
    description=' neural prediction model',
    usage=
      '\n  %(prog)s train [options] source model'
      '\n  %(prog)s test source'
      '\n  %(prog)s -h',
  )

  p.add_argument('--mode', default="train", type=str, help='\'train\' or \'test\'')
  p.add_argument('--data', default="data/sample.txt", type=str, help='[in] source data')
  p.add_argument('--model', default="model/prediction_model0", type=str, help='[in/out] model file')
  p.add_argument('--minibatch', default=def_minibatch, metavar='INT', type=int, help='minibatch size')

  p.add_argument('--embed', default=def_embed, metavar='INT', type=int,
    help='embedding layer size (default: %(default)d)')
  p.add_argument('--hidden', default=def_hidden, metavar='INT', type=int,
    help='hidden layer size (default: %(default)d)')
  p.add_argument('--epoch', default=def_epoch, metavar='INT', type=int,
    help='number of training epoch (default: %(default)d)')
  args = p.parse_args()

  # check args
  try:
    if args.mode not in ['train', 'test']: raise ValueError('you must set mode = \'train\' or \'test\'')
    if args.embed < 1: raise ValueError('you must set --embed >= 1')
    if args.hidden < 1: raise ValueError('you must set --hidden >= 1')
    if args.epoch < 1: raise ValueError('you must set --epoch >= 1')
  except Exception as ex:
    p.print_usage(file=sys.stderr)
    print(ex, file=sys.stderr)
    sys.exit()
  return args



def forword(log_train, model, train=True, result=False):
  """
  ソフトマックスクロスエントロピーを使い，正解の技id（技数次元のどこか一つは１で残りは０)との誤差を計算して返す
  """
  log_list, ans = log_train

  #dataをvarへ変換
  log_list_np = np.array([log_list], np.float32)
  log_list_var = chainer.Variable(log_list_np, volatile=not train)

  #NN
  h1 = F.tanh(model.w1(log_list_var))
  y = F.tanh(model.w2(h1))

  #正解のラベルをvarへ変換
  label = np.array([ans], np.int32)
  t = chainer.Variable(label, volatile=not train)

  #loss計算
  loss = F.softmax_cross_entropy(y, t)
  if train == False:
    predict = y.data.argmax(1)[0]
    if predict == ans:
      result['correct_node'] += 1
      result['correct_'+str(ans)] += 1
    result['total'] += 1
    result['total_'+str(ans)] += 1
    result['pred_'+str(predict)] += 1
  return loss, result

def evaluate(log_tests, model, result):
  for log_test in log_tests:
    _, result = forword(log_test, model, train=False, result=result)


def init_model(args):
    input_layer = 10
    ans_num = 4
    model = chainer.FunctionSet(
        w1=F.Linear(input_layer, args.hidden), #source input
        w2=F.Linear(args.hidden, args.hidden), #hidden
        w3=F.Linear(args.hidden, ans_num), #target output
    )
    optimizer = optimizers.SGD(lr=0.01)  # (lr=opt_score)  # lr=0.01
    #optimizer = optimizers.AdaGrad(lr=0.001)
    #optimizer = optimizers.AdaDelta(rho=0.9)
    #optimizer = optimizers.Adam(alpha=0.0001)
    optimizer.setup(model)  # .collect_parameters()
    return model, optimizer


def pre_process(data):
  """
  入力データを以下と仮定
  数値,数値,数値...,数値|||技id
  4,4,4,3,4,5,6,4,14,17,19,18,7,4,2,2,3|||1(腹踊り)
  """
  log_lists = []
  for line in open(data):
    log_str, hara_str = line.strip().split("|||")
    log_list = list(map(int, log_str.split(",")))
    log_lists.append([log_list, int(hara_str)])

  return log_lists


def train(args):
  #データの前処理
  log_lists = pre_process(args.data)
  np.random.shuffle(log_lists)
  len_data = len(log_lists)
  log_trains = log_lists[:int(0.9*len_data)]
  log_tests = log_lists[int(0.9*len_data):]  

  len_corpus = len(log_trains)

  #NNモデル初期化
  model, optimizer = init_model(args)
  start_at = time.time()
  accum_loss, count = 0, 0

  for epoch in range(args.epoch):
    result = defaultdict(lambda: 0)
    cur_at = time.time()
    np.random.shuffle(log_trains)
    total_loss = 0

    for log_train in log_trains:
      #forword
      loss, _ = forword(log_train, model, train=True)
      accum_loss += loss
      count += 1

      #backword
      if count >= args.minibatch:
          optimizer.zero_grads()
          accum_loss.backward()
          optimizer.weight_decay(0.0001)
          optimizer.update()
          total_loss += float(accum_loss.data)
          accum_loss, count = 0, 0

    now = time.time()
    throuput = float(len(log_trains)) / (now - cur_at)
    print('------------- Epoch: {0:d} -------------'.format(epoch))
    print('{:.2f} iters/sec, {:.2f} sec'.format(throuput, now - cur_at))
    print('Train data evaluation:')
    print('all loss: {:.4f}'.format(total_loss/len_corpus))
    #f.write('all loss: {:.4f}\nrec loss: {:.4f}\nreo loss: {:.4f}\n'.format(
    #  total_loss/len_corpus, total_rec_loss/len_corpus, total_reo_loss/len_corpus))
    evaluate(log_tests, model, result)

    #保存
    pickle.dump(model, open('%s.%d' % (args.model, epoch+1), 'wb'), -1)

#デモ側に渡すclass．modelをもっていて，.predict()で予測
class Predict_Haraodori:
  def __init__(self, model_path):
    self.model = pickle.load(open(model_path, 'rb'))

  def predict(self, data):
    log_data = self.test_preprocess(data)
    result = defaultdict(lambda: 0)
    _, result = forword(log_data, self.model, train=False, result=result)
    return result
    
  def test_preprocess(self, data):
    log_lists = pre_process(data)
    return log_lists[0]


def test(args):
  model = pickle.load(open(args.model, 'rb'))
  result = defaultdict(lambda: 0)
  log_lists = pre_process(args.data)
  log_data = log_lists[0] #本番は1個のみなので削除 
  _, result = forword(log_data, model, train=False, result=result)
  return result


def load_model():
  return 2

def main():
  args = parse_args()
  if args.mode == 'train': train(args)
  elif args.mode == 'test': 
    print (test(args))

if __name__ == '__main__':
  #main()
  pass
