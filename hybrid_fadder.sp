* 1bit_Full_adder

.lib "32nm_LP.pm" CMOS_models

.subckt Inv_sch in VDD Out gnd  
MNMOS_1 Out in gnd gnd NMOS W=65n L=32n 
MPMOS_1 Out in vdd VDD PMOS W=128n L=32n 
.ends

* nmos_Module_1_XOR/XNOR cell
MNMOS_1 H A Bbar Gnd NMOS W=62n L=32n 
MNMOS_2 Hbar A B Gnd NMOS W=62n L=32n 
MNMOS_3 Hbar B A Gnd NMOS W=62n L=32n 
MNMOS_4 H Hbar Gnd Gnd NMOS W=62n L=32n 

* nmos_Module_2_XOR_ckt
MNMOS_5 SUM C Hbar Gnd NMOS W=62n L=32n 
MNMOS_6 SUM Hbar C Gnd NMOS W=62n L=32n 

* nmos_Module_3_MUX_ckt
MNMOS_7 COUT H A Gnd NMOS W=62n L=32n 
MNMOS_8 COUT Hbar C Gnd NMOS W=62n L=32n 

* pmos_Module_1_XOR/XNOR cell
MPMOS_1 H A B VDD PMOS W=128n L=32n
MPMOS_2 Hbar A Bbar VDD PMOS W=128n L=32n
MPMOS_3 H B A VDD PMOS W=128n L=32n
MPMOS_4 Hbar H VDD VDD PMOS W=128n L=32n

* pmos_Module_2_XOR_ckt
MPMOS_5 SUM C H VDD PMOS W=128n L=32n
MPMOS_6 SUM H C VDD PMOS W=128n L=32n

* pmos_Module_3_MUX_ckt
MPMOS_7 COUT H C VDD PMOS W=128n L=32n
MPMOS_8 COUT Hbar A VDD PMOS W=128n L=32n

XInv_sch_1 B VDD Bbar gnd Inv_sch  

CCapacitor_1 SUM Gnd 0.01f  
CCapacitor_2 COUT Gnd 0.01f  

VVDD VDD Gnd 1 
VVA A Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)  
VVB B Gnd  PULSE(1 0 0 10p 10p 0.99n 2n)  
VVC C Gnd  PULSE(1 0 0 10p 10p 1.99n 4n)

.tran 1n 8n
.op

.MEASURE avgpow AVG power FROM=1n TO=8n

.measure tran current avg i(out) from=0n to=8n

.measure tran delay TRIG v(C) VAL=0.5 rise=1 TARG v(COUT)VAL=0.5 rise=1 
.measure tran delay1 TRIG v(B) VAL=0.5 fall=2 TARG v(SUM)VAL=0.5 fall=2 


.MEASURE TRAN tpd PARAM='(delay+delay1)/2'
.measure PDP PARAM =  'tpd*avgpow'
.end

