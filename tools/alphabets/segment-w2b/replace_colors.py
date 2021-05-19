#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 30 09:56:59 2020

@author: podolnik
"""

letters = list('abcdefghijklmnopqrstuvwxyz')


for l in letters:    
    f_name = '{}.svg'.format(l)
    print(f_name)
    svg_str = ''
    with open(f_name, 'r') as f:
        svg_str = f.read()
    
    svg_str = svg_str.replace('fill:#000000;', 'fill:#ffffff;')

    
    with open(f_name, 'w+') as f:
        f.write(svg_str)