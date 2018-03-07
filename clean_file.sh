#!/bin/bash

tr -d "\"" <$1 > temp | mv temp $1
tr "," '\t' <$1 > temp | mv temp $1
