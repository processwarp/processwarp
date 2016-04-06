#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import util

ROOT_PATH = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
util.execute(['electron',
              os.path.join(ROOT_PATH, 'src', 'electron')])
