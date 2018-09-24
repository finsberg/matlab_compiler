# Magic Square example
In this tutorial we will create a simple matlab program that simply
takes in an integer as input and output the [magic
square](https://se.mathworks.com/help/matlab/ref/magic.html)
The exact same example using the Library compiler app can be found
[here](https://se.mathworks.com/help/compiler_sdk/gs/create-a-python-application-with-matlab-code.html).

## The code
The code used in this exmaple has only one function called `makesqr`, 

```matlab
function y = makesqr(x)

y = magic(x);
```
This function simply takes an integer as input and output the magic
square. 
```matlab

```

## Compile the code
To compile the code we first create a folder called `magic` were we
will put the compiled code (`mkdir -p magic`) run the following command
```shell
mcc -W python:magic -d magic -T link:lib makesqr
```
The part `-W python:magic` tells the compiler that we want to compile
a python package and that we want to call that package `magic`. The
part `-d magic` tells the compiler that it should put the results in
the folder called `magic` (note that this folder has to exist), and
the final part (`link:lib makesqr?`) tells the compiler that the code
we want to compile is found in the file `makesqr.m`. 

## Install the compiled code
When the compilation is done you will see some files and folders
appearing in the newly created `magic` folder. 

```shell
$ ls magic
magic			mccExcludedFiles.log	readme.txt		requiredMCRProducts.txt	setup.py
```
It is always a good idea to install it in a virtual environment.
```
pip install virtualenv # install virtual env
virtualenv venv # create a virtual environment
source venv/bin/activate # activate the virtual environment
cd magic && python setup.py install # install the matlab code
```

## Running python
If you go to the directory called [python](python) there is a file
called [test.py](python/test.py).
The code there explains how to run the matlab code.
```python
# test.py
import sys
import magic

def main(n=5):
    
    # Start a matlab engine
    eng = magic.initialize()
    # Compute the magic square
    square = eng.makesqr(n)
    # Print it with each row on a separate line
    print("\n".join([str(s) for s in square]))
    # Shut down the matlab engine
    eng.terminate()

if __name__ == "__main__":

    print(sys.argv)
    if len(sys.argv) > 1:
        main(int(sys.argv[1]))
    else:
        main()

```

## Running the code in docker

In order to run the code in docker, you need to first make sure that
you have docker installed. Then you need to build the docker container

```shell
$ docker build -t magic_docker .
Sending build context to Docker daemon  6.526MB
Step 1/5 : FROM finsberg/matlab_runtime:2018b
 ---> 4c9a6ba0d870
Step 2/5 : RUN mkdir -p /usr/local/magic
 ---> Running in 19425380d29a
Removing intermediate container 19425380d29a
 ---> f909de98d501
Step 3/5 : COPY . /usr/local/magic/.
 ---> 4ee7eb65a554
Step 4/5 : RUN  cd /usr/local/magic/magic      && python setup.py install
 ---> Running in 22028000bbe8
running install
running build
running build_py
creating build
creating build/lib
creating build/lib/magic
copying magic/__init__.py -> build/lib/magic
copying magic/magic.ctf -> build/lib/magic
running install_lib
creating /usr/local/lib/python3.6/site-packages/magic
copying build/lib/magic/__init__.py -> /usr/local/lib/python3.6/site-packages/magic
copying build/lib/magic/magic.ctf -> /usr/local/lib/python3.6/site-packages/magic
byte-compiling /usr/local/lib/python3.6/site-packages/magic/__init__.py to __init__.cpython-36.pyc
running install_egg_info
Writing /usr/local/lib/python3.6/site-packages/matlabruntimeforpython-R2018b-py3.6.egg-info
removing 'build/lib' (and everything under it)
removing 'build'
'build/bdist.linux-x86_64' does not exist -- can't clean it
'build/scripts-3.6' does not exist -- can't clean it
Removing intermediate container 22028000bbe8
 ---> 69ecf015910b
Step 5/5 : ENTRYPOINT ["python", "/usr/local/magic/python/test.py"]
 ---> Running in 6e764977cd3f
Removing intermediate container 6e764977cd3f
 ---> 8db46e23dc4b
Successfully built 8db46e23dc4b
Successfully tagged magic_docker:latest
```

Now you can execute the docker container as a regular script
```shell
$ docker run magic_docker 3
['/usr/local/magic/python/test.py', '3']
[8.0,1.0,6.0]
[3.0,5.0,7.0]
[4.0,9.0,2.0]
```

If you don't want to build the image you can also run the container
interatively by pulling from my remote container (`finsberg/matlab_runtime:2018b`),
```shell
docker run -ti -p 127.0.0.1:8000:8000 -v $(pwd):/home/shared -w /home/shared finsberg/matlab_runtime:2018b
root@73134135b5ef:/home/shared#
```
Now install the software
```shell
root@73134135b5ef:/home/shared# cd magic && python setup.py install && cd ..
running install
running build
running build_py
creating build
creating build/lib
creating build/lib/magic
copying magic/__init__.py -> build/lib/magic
copying magic/magic.ctf -> build/lib/magic
running install_lib
creating /usr/local/lib/python3.6/site-packages/magic
copying build/lib/magic/__init__.py -> /usr/local/lib/python3.6/site-packages/magic
copying build/lib/magic/magic.ctf -> /usr/local/lib/python3.6/site-packages/magic
byte-compiling /usr/local/lib/python3.6/site-packages/magic/__init__.py to __init__.cpython-36.pyc
running install_egg_info
Writing /usr/local/lib/python3.6/site-packages/matlabruntimeforpython-R2018b-py3.6.egg-info
removing 'build/lib' (and everything under it)
'build/bdist.linux-x86_64' does not exist -- can't clean it
'build/scripts-3.6' does not exist -- can't clean it
removing 'build'
```
and run the code
```shell
root@73134135b5ef:/home/shared# python python/test.py 3
['python/test.py', '3']
[8.0,1.0,6.0]
[3.0,5.0,7.0]
[4.0,9.0,2.0]
```

To exit the container type `exit` and then enter. 

## Troubleshooting

* If you see the following error message
```shell
Traceback (most recent call last):
  File "test.py", line 4, in <module>
    import magic
ModuleNotFoundError: No module named 'magic'
```
then make sure you have installed the compiled code correctly and that
python can see the code. If you run the command `python -c "import
sys; print(sys.path)"` then this will print all the paths that python
can see

* If you see the following error message
```shell
RuntimeError: On Linux, you must set the environment variable "LD_LIBRARY_PATH" to a non-empty string. For more details, see the package documentation.
```
then make sure to update you `LD_LIBRARY_PATH`, see [installation instructions](../../docs/install.md).
