#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jan 30 09:56:59 2020

@author: podolnik
"""

letters = list('abcdefghijklmnopqrstuvwxyz0123459789')
letters.extend([f'{i}-nato' for i in range(0, 10)])

for l in letters:
    f_name = '{}.svg'.format(l)
    svg_str = ''
    with open(f_name, 'r') as f:
        svg_str = f.read()
    
    svg_str = svg_str.replace('stroke:#000000;', 'stroke:#ffffff;')
    svg_str = svg_str.replace('fill:#0000ff;', 'fill:#0088aa;')
    svg_str = svg_str.replace('fill:#ff0000;', 'fill:#fb3333;')
    svg_str = svg_str.replace('fill:#ffff00;', 'fill:#ffcc00;')
    
    with open(f_name, 'w+') as f:
        f.write(svg_str)
