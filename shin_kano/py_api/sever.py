#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cherrypy
from cherrypy._cpdispatch import Dispatcher
import predict_haraodori

class StringGenerator(object):

    def __init__(self, model):
        self.model = model

    @cherrypy.expose
    def generate(self, length=8, length2=8):
        return str(self.model.predict("data/sample.txt"))

class ForceLowerDispatcher(Dispatcher):
    def __call__(self, path_info):
        return Dispatcher.__call__(self, path_info.lower())

if __name__ == '__main__':
    model = predict_haraodori.Predict_Haraodori("model/prediction_model0.10")
    conf = {
        '/': {
            'request.dispatch': ForceLowerDispatcher(),
        }
    }
    cherrypy.quickstart(StringGenerator(model), '/', conf)
