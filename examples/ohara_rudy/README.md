# O'Hara Rudy model


The Matlab code for the `ORd orginal human ventricular model, 2011`
used in this example is downloaded from
[http://rudylab.wustl.edu/research/cell/code/AllCodes.html](http://rudylab.wustl.edu/research/cell/code/AllCodes.html).

The code found here is slightly modified. The `main.m` file is here a
function that takes as input a path to a file containing the initial
conditions. 


## Compile the Matlab code

Make sure to have Matlab with the Library compiler toolbox installed.
Then type 
```
make
```
which will do the following
```
mkdir -p ohara_rudy
mcc -W python:ohara_rudy -d ohara_rudy -T link:lib "O'Hara_ORd_MATLAB_2011/main" -a "O'Hara_ORd_MATLAB_2011"
```


## Install the compiled code

First create a virtual environment and install the requirements. 

```
pip install virtualenv           # install virtualenv
virtualenv venv                  # create virtual environment
source venv/bin/activate         # activate virtual environment
pip install -r requirements.txt  # install requirements
```
Now install the matlab code
```
cd ohara_rudy
python setup.py install
``` 

## Run the python code
Check out the exmple in the [python](python) folder called
[run_ohara_rudy.py](run_ohara_rudy.py) 

```python
import ohara_rudy
import scipy.io as sio
import matplotlib.pyplot as plt
import numpy as np


initial_conditions= dict(v=-87,
                         nai=7,
                         nass=7,
                         ki=145,
                         kss=145,
                         cai=1.0e-4,
                         cass=1.0e-4,
                         cansr=1.2,
                         cajsr=1.2,
                         m=0,
                         hf=1,
                         hs=1,
                         j=1,
                         hsp=1,
                         jp=1,
                         mL=0,
                         hL=1,
                         hLp=1,
                         a=0,
                         iF=1,
                         iS=1,
                         ap=0,
                         iFp=1,
                         iSp=1,
                         d=0,
                         ff=1,
                         fs=1,
                         fcaf=1,
                         fcas=1,
                         jca=1,
                         nca=0,
                         ffp=1,
                         fcafp=1,
                         xrf=0,
                         xrs=0,
                         xs1=0,
                         xs2=0,
                         xk1=1,
                         Jrelnp=0,
                         Jrelp=0,
                         CaMKt=0)

# File with initial_conditions
ic_file = 'initial_conditions.mat'

# Save file with initial_conditions
sio.savemat(ic_file, initial_conditions)

# Start matlab engine
engine = ohara_rudy.initialize()

# Compute the results
res = engine.main(ic_file)

# Plot some results
time = np.array(res['time']).squeeze()
ICaL = np.array(res['ICaL']).squeeze()

fig, ax = plt.subplots()
ax.plot(time, ICaL)
ax.set_title('ICaL')
ax.set_xlabel('Time (ms)')
plt.show()

# Terminate engine
engine.terminate()

```
