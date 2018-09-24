# The Library Compiler
There are two ways you can run the Library compiler, from the Matlab
desktop or from the command line. I mainly be using the commandline
interface but I will briefly mention how this can be done from the
Matlab desktop.

## Using the Matlab desktop
Please check out [this
link](https://se.mathworks.com/help/compiler_sdk/gs/create-a-python-application-with-matlab-code.html)
for detailed instructions for how to use the Library compiler for the
[magic square example](../examples/magic_square/README)

Note that in this case you will generate a lot more files that you
need to install the package. You only need the files in the folder
`for_redistribution_files_only`.


## Using the command line 
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
