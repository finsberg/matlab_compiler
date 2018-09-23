# The Library Compiler
There are two ways you can run the Library compiler, from the Matlab
desktop or from the command line. I mainly be using the commandline
interface but I will briefly mention how this can be done from the
Matlab desktop.

## Using the Matlab desktop
Please check out [this
link](https://se.mathworks.com/help/compiler_sdk/gs/create-a-python-application-with-matlab-code.html)
for detailed instructions for how to use the Library compiler for the
[hello world problem](hello_world.md). 

Note that in this case you will generate a lot more files that you
need to install the package. You only need the files in the folder
`for_redistribution_files_only?`.


## <a name=mcc_cli></a> Using the command line 
In order to use the command line you need to be able the execute the
`mcc` command. This is binary script that is located in the `bin`
directory. Make sure the you `PATH` environment variable sees this
directory, i.e on my linux computer I had to do
```shell
export PATH=/home/henriknf/local/MATLAB/R2018b/bin:$PATH
```
The command you need to run to compile the package is
```
mcc -W python:package_name -d output_directory -T link:lib module_1 -T link:lib module_2 -a folder_1 -a folder_2
```
Here

* `package_name` is the name of the pacakge

* `output_directory` is the folder where the output is saved

* `module_1` and `module_2` are the modules that will be available
  from the python interface

* `folder_1` and `folder_2` are folders with additional matlab files
  needed to run `module_1` and `module_2`. Note that `folder_i` can
  also be matlab files (i.e not folders).


# Installing the compiled python library
Once you have compiled the Matlab code using the command described in
[Using the command line](#mcc_cli) you will have a new directory
called `output_directory` and inside that folder you will some files
```shell
$ ls output_directory
package_name      readme.txt               setup.py
mccExcludedFiles.log  requiredMCRProducts.txt
```
and inside the package there is a `__init__.py` file containing
instruction to python for how to import the matlab code and there is a
binary file containing the compiled code. Note that reading the
`__init__.py` can be useful if you want to understand how the package
is imported in python-

To install the package you need to make sure to update your
`LD_LIBRARY_PATH` according to the [installation
instructions](#install_python) and then install the package as by
calling

```shell
python setup.py install
```
Now you should be able to run 
```
python -c "import package_name"
```
without any errors. 
