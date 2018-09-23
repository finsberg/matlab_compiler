SHELL := /bin/bash

default:
	mkdir -p magic
	mcc -W python:magic -d magic -T link:lib makesqr

install:
	pip install virtualenv
	virtualenv venv
	source venv/bin/activate && cd magic && python setup.py install
