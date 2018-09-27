% Copyright (c) 2011-2015 by Thomas O'Hara, Yoram Rudy, 
%                            Washington University in St. Louis.
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright 
% notice, this list of conditions and the following disclaimer in the 
% documentation and/or other materials provided with the distribution.
% 
% 3. Neither the names of the copyright holders nor the names of its
% contributors may be used to endorse or promote products derived from 
% this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
% IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED 
% TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
% PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
% HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF 
% USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND 
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
% THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
% DAMAGE.

% MATLAB Implementation of the O'Hara-Rudy dynamic (ORd) model for the
% undiseased human ventricular action potential and calcium transient
%
% The ORd model is described in the article "Simulation of the Undiseased
% Human Cardiac Ventricular Action Potential: Model Formulation and
% Experimental Validation"
% by Thomas O'Hara, Laszlo Virag, Andras Varro, and Yoram Rudy
%
% The article and supplemental materails are freely available in the
% Open Access jounal PLoS Computational Biology
% Link to Article:
% http://www.ploscompbiol.org/article/info:doi/10.1371/journal.pcbi.1002061
% 
% Email: tom.ohara@gmail.com / rudy@wustl.edu
% Web: http://rudylab.wustl.edu
% 
function results = main(initial_conditions_file)

%initial conditions for state variables
ic = load(initial_conditions_file);
%X0 is the vector for initial sconditions for state variables
X0=[double(ic.v) double(ic.nai) double(ic.nass) double(ic.ki) ...
    double(ic.kss) double(ic.cai) double(ic.cass) double(ic.cansr) ...
    double(ic.cajsr) double(ic.m) double(ic.hf) double(ic.hs) double(ic.j) ...
    double(ic.hsp) double(ic.jp) double(ic.mL) double(ic.hL) double(ic.hLp) ...
    double(ic.a) double(ic.iF) double(ic.iS) double(ic.ap) double(ic.iFp) ...
    double(ic.iSp) double(ic.d) double(ic.ff) double(ic.fs) double(ic.fcaf) ...
    double(ic.fcas) double(ic.jca) double(ic.nca) double(ic.ffp) double(ic.fcafp) ...
    double(ic.xrf) double(ic.xrs) double(ic.xs1) double(ic.xs2) double(ic.xk1) ...
    double(ic.Jrelnp) double(ic.Jrelp) double(ic.CaMKt)]'; 

CL=1000;%pacing cycle length in ms
beats=100;%number of beats in the simulation

options=[];%options for ode solver


for n=[1:beats]
    [time X]=ode15s(@model,[0 CL],X0,options,1);
    X0=X(size(X,1),:);
    n %output beat number to the screen to monitor runtime progress
end

%rename values in the state variables vector
v=X(:,1);
nai=X(:,2);
nass=X(:,3);
ki=X(:,4);
kss=X(:,5);
cai=X(:,6);
cass=X(:,7);
cansr=X(:,8);
cajsr=X(:,9);
m=X(:,10);
hf=X(:,11);
hs=X(:,12);
j=X(:,13);
hsp=X(:,14);
jp=X(:,15);
mL=X(:,16);
hL=X(:,17);
hLp=X(:,18);
a=X(:,19);
iF=X(:,20);
iS=X(:,21);
ap=X(:,22);
iFp=X(:,23);
iSp=X(:,24);
d=X(:,25);
ff=X(:,26);
fs=X(:,27);
fcaf=X(:,28);
fcas=X(:,29);
jca=X(:,30);
nca=X(:,31);
ffp=X(:,32);
fcafp=X(:,33);
xrf=X(:,34);
xrs=X(:,35);
xs1=X(:,36);
xs2=X(:,37);
xk1=X(:,38);
Jrelnp=X(:,39);
Jrelp=X(:,40);
CaMKt=X(:,41);

%calculate and name dependent variables for the final beat in the
%simulation (i.e. currents and fluxes)
for i=[1:size(X,1)];
    IsJs=model(time(i),X(i,:),0);
    results.INa(i)=IsJs(1);
    results.INaL(i)=IsJs(2);
    results.Ito(i)=IsJs(3);
    results.ICaL(i)=IsJs(4);
    results.IKr(i)=IsJs(5);
    results.IKs(i)=IsJs(6);
    results.IK1(i)=IsJs(7);
    results.INaCa_i(i)=IsJs(8);
    results.INaCa_ss(i)=IsJs(9);
    results.INaK(i)=IsJs(10);
    results.IKb(i)=IsJs(11);
    results.INab(i)=IsJs(12);
    results.ICab(i)=IsJs(13);
    results.IpCa(i)=IsJs(14);
    results.Jdiff(i)=IsJs(15);
    results.JdiffNa(i)=IsJs(16);
    results.JdiffK(i)=IsJs(17);
    results.Jup(i)=IsJs(18);
    results.Jleak(i)=IsJs(19);
    results.Jtr(i)=IsJs(20);
    results.Jrel(i)=IsJs(21);
    results.CaMKa(i)=IsJs(22);
    results.Istim(i)=IsJs(23);
end
results.time = time
%create plots showing results for the final paced beat

% figure
% subplot(2,3,1),plot(time,INa),title('INa')
% subplot(2,3,2),plot(time,INaL),title('INaL')
% subplot(2,3,3),plot(time,INaK),title('INaK')
% subplot(2,3,4),plot(time,INaCa_i,time,INaCa_ss),title('INaCa_i,INaCa_ss')
% subplot(2,3,5),plot(time,JdiffNa),title('JdiffNa')
% subplot(2,3,6),plot(time,nai,time,nass),title('nai,nass')

% figure
% subplot(2,3,1),plot(time,Ito),title('Ito')
% subplot(2,3,2),plot(time,IKr),title('IKr')
% subplot(2,3,3),plot(time,IKs),title('IKs')
% subplot(2,3,4),plot(time,IK1),title('IK1')
% subplot(2,3,5),plot(time,INaK),title('INaK')
% subplot(2,3,6),plot(time,ki),title('ki')

% figure
% subplot(2,3,1),plot(time,ICaL),title('ICaL')
% subplot(2,3,2),plot(time,INaCa_i,time,INaCa_ss),title('INaCa_i,INaCa_ss')
% subplot(2,3,3),plot(time,cai),title('cai')
% subplot(2,3,4),plot(time,cass),title('cass')
% subplot(2,3,5),plot(time,cansr,time,cajsr),title('cansr,cajsr')
% subplot(2,3,6),plot(time,Jrel),title('Jrel')

% figure
% subplot(2,2,1),plot(time,ICaL),title('ICaL')
% subplot(2,2,2),plot(time,cass),title('cass')
% subplot(2,2,3),plot(time,cai),title('cai')
% subplot(2,2,4),plot(time,Jrel),title('Jrel')

% figure
% subplot(3,3,1),plot(time,INa),title('INa')
% subplot(3,3,2),plot(time,INaL),title('INaL')
% subplot(3,3,3),plot(time,Ito),title('Ito')
% subplot(3,3,5),plot(time,ICaL),title('ICaL')
% subplot(3,3,6),plot(time,IKr),title('IKr')
% subplot(3,3,7),plot(time,IKs),title('IKs')
% subplot(3,3,8),plot(time,INaCa_i,time,INaCa_ss),title('INaCai,INaCass')
% subplot(3,3,9),plot(time,INaK),title('INaK')

% figure
% subplot(2,3,1),plot(time,INab),title('INab')
% subplot(2,3,2),plot(time,INaL),title('INaL')
% subplot(2,3,3),plot(time,IKb),title('IKb')
% subplot(2,3,4),plot(time,IpCa),title('IpCa')
% subplot(2,3,5),plot(time,ICab),title('ICab')

% figure
% subplot(2,2,1),plot(time,Jrel),title('Jrel')
% subplot(2,2,2),plot(time,Jup),title('Jup')
% subplot(2,2,3),plot(time,Jleak),title('Jleak')
% subplot(2,2,4),plot(time,Jtr),title('Jtr')

% figure
% subplot(2,2,1),plot(time,JdiffNa),title('JdiffNa')
% subplot(2,2,2),plot(time,JdiffK),title('JdiffK')
% subplot(2,2,3),plot(time,Jdiff),title('Jdiff')

% figure
% subplot(2,3,1),plot(time,nai,time,nass),title('nai,nass')
% subplot(2,3,2),plot(time,cai),title('cai')
% subplot(2,3,3),plot(time,cass),title('cass')
% subplot(2,3,4),plot(time,cansr,time,cajsr),title('cansr,cajsr')
% subplot(2,3,5),plot(time,ki),title('ki')

% figure
% plot(time,v,time,Istim),title('v,Istim')

end