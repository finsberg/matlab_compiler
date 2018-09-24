# Installation
There are two types of user to consider here. One is the Matlab
developer who want to turn his / her Matlab code into a python
library, and we have the python developer which only need to be able
to run the compiled matlab code. 

## For the matlab developer
The Matlab developer need a toolbox called the [Library Compiler
Toolbox](https://se.mathworks.com/help/compiler_sdk/ml_code/librarycompiler-app.html). 
If you click on that link you will see that the library compiler also
supports other languages such as C, C++, .NET, Generic COM, and Java,
but we will focus on python.
Note that if you are using any other toolbox (such as the `parallel
toolbox`) it is still possible to compile that without the user
needing to buy any licenses. The list of [supported
toolboxes](https://se.mathworks.com/products/compiler/supported/compiler_support.html)
shows that many for many toolboxes you can appreciate all command line
functionality.

## For the python developer

To simply run the compiled code you only need a [MATLAB
runtime](https://se.mathworks.com/products/compiler/matlab-runtime.html). 
Make sure to install the same version of Matlab runtime as the version
used to compile the library you want to run. I will be unsing R2018b,
and then even R2018a don't work. 
Also MATLAB runtime currently only support 
python 3.6 and below so if you are using python 3.7 then you need to
install a previous version. 

When you have downloaded the zipfile, you need to extract it and then
install MATLAB runtime. For info about how to install it see the page
[Install and Configure MATLAB
Runtime](https://se.mathworks.com/help/compiler/install-the-matlab-runtime.html).

I use the linux version, and will now guide you through the steps
needed to install it on linux.

Run
```shell
./install -mode silent -agreeToLicense yes -destinationFolder /home/henriknf/local
```
Here you should change `/home/henriknf/local` to where you want to
install it, but if you don't provide this flag, then you will need
root access to install install it (i.e you need to use sudo).
Once the installation is complete it gives you as message to put
something in your `LD_LIBRARY_PATH`. In my case it sais
```shell
On the target computer, append the following to your LD_LIBRARY_PATH environment variable:

/home/henriknf/local/v95/runtime/glnxa64:/home/henriknf/local/v95/bin/glnxa64:/home/henriknf/local/v95/sys/os/glnxa64:/home/henriknf/local/v95/extern/bin/glnxa64

``` 
Since editing the `LD_LIBRARY_PATH` might potentially corrupt other
software I will only set this path if I am using MATLAB Runtime. I
create a file called `~/.matlab_runtime` and put the following line in
there
```
# Update LD_LIBRARY_PATH for MATLAB runtime
export LD_LIBRARY_PATH="/home/henriknf/local/v95/runtime/glnxa64:/home/henriknf/local/v95/bin/glnxa64:/home/henriknf/local/v95/sys/os/glnxa64:/home/henriknf/local/v95/extern/bin/glnxa64:$LD_LIBRARY_PATH"
```
Now, if I want to use MATLAB Runtime I just need to source that file
first, i.e `source ~/.matlab_runtime`



### Note to Linux users
When I tried to run the compile code the first time, I got this
strange error

```shell
ImportError: /usr/lib/x86_64-linux-gnu/libpython3.6m.so.1.0: undefined symbol: XML_SetHashSalt
```
It you are encountering the same problem, there is a fix at
[Stackoverflow](https://stackoverflow.com/questions/50452278/matlab-python-compiler-sdk-fails-with-undefined-symbol-xml-sethashsalt) 

In short, you need to go the the Matlab root directory and rename a
file

```shell
cd /home/henriknf/local/v95/bin/glnxa64
mv libexpat.so.1 libexpat.so.1.NOFIND
```


### Note to Mac users
It turns out that it is not straight forward to make this work on
Mac, maily because Matlab only support specific version of python and
and also python has to be compiled in a specific way. This is why e.g
python installed using Anaconda will not work. So you need to install
python using brew or from [python.org](https://www.python.org). And
note again that python3.7 does not work. 

Once you have installed a correct version of python you also cannot
use the regular python interpreter to import the matlab code. Instead
MATLAB provides you with its own interpreter called `mwpython` which
you need to use in order to import compiled matlab code. This makes it
more challenging to integrate compiled matlab code into your python
program. 


### Note to Windows user
I haven't tried to install it on windows yet.


## Alternatives to installation
I can be time consuming an complicated to install the software on your
local machince, in particular if you are not running on a linux
machine. In this case, a very good alternative to installing the
software is to use pre-built [Dokcer](https://www.docker.com)
containers. In this repoistory there is a so called
[`Dockerfile`](../Dockerfile) which contains instructions for how to
build a linux container with Matlab2018b Runtime installed.
To build this container you first need to change directory so that the
Dockerfile is in you current directory then run the command
```shell
docker build -t matlab2018b_runtime .
```
This will create a docker container which is called
`matlab2018b_runtime`. To run the container you can do
the following
```shell
docker run -ti -p 127.0.0.1:8000:8000 -v $(pwd):/home/shared -w /home/shared matlab2018b_runtime
```
This will open a new terminal where you are inside the container but
also access to the files in the current directory. For more info about
how to run the container you can run the following command `docker run
--help`. In each example in this directory there is also a
`Dockerfile` which can be used to run the example in a docker
container. 

