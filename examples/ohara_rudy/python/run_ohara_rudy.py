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

