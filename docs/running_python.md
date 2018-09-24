# Running Matlab in python

## <a href=install_compiled>Installing the compiled python library</a>
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


## Running the compiled code
In order to run the matlab code you need to first [install the
compiled python library](#install_compiled)
See the [magic square exmaple](../example/magic_square/README) for a
practical example on how to compile a matlab code and running it in python.
