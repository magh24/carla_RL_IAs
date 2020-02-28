import numpy as np
import torch
import torchvision.transforms as transforms

import carla


class Agent(object):
    def __init__(self, model=None, **kwargs):
        print("we are testing agent marin")
        self.debug = dict()


    def postprocess(self, steer, throttle, brake):
        control = carla.VehicleControl()
        control.steer = np.clip(steer, -1.0, 1.0)
        control.throttle = np.clip(throttle, 0.0, 1.0)
        control.brake = np.clip(brake, 0.0, 1.0)
        control.manual_gear_shift = False

        return control
