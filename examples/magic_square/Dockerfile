FROM finsberg/matlab_runtime:2018b

RUN mkdir -p /usr/local/magic
COPY . /usr/local/magic/.

RUN  cd /usr/local/magic/magic \
     && python setup.py install


ENTRYPOINT ["python", "/usr/local/magic/python/test.py"]
