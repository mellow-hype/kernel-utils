#!/bin/bash
cd build && make -j$((`nproc`/2))
