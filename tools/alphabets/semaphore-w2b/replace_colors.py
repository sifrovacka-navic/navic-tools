#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 30 09:56:59 2020

@author: podolnik
"""

letters = list('abcdefghijklmnopqrstuvwxyz')
letters.extend(['hand0', 'hand1', 'hand2', 'hand3', 'hand4', 'hand5', 'hand6', 'hand7'])

for l in letters:
    f_name = '{}.svg'.format(l)
    svg_str = ''
    with open(f_name, 'r') as f:
        svg_str = f.read()
    
    svg_str = svg_str.replace('fill:#ffffff;', 'fill:#cccccc;')
    svg_str = svg_str.replace('stroke:#000000;', 'stroke:#ffffff;')
    svg_str = svg_str.replace('fill:#ff0000;', 'fill:#fb3333;')
    
    with open(f_name, 'w+') as f:
        f.write(svg_str)