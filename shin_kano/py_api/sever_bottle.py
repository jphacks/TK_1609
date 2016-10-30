#!/usr/bin/env python
# -*- coding: utf-8 -*-

from bottle import route, run, post, request
import predict_haraodori

@post("predict")
def predict():
  return request.json
  #return str(model.predict(request.('data')))

if __name__ == '__main__':
  model = predict_haraodori.Predict_Haraodori("model/prediction_model0.10")
  run(host='localhost', port=8080, debug=True)
