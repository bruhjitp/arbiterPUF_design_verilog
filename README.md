Description:
Arbiter PUFs are one of the widely used Physically Unclonable Functions based on symmetric circuit.
An input edge is split to two multiplexors (muxes). Depending on the input 
challenge bits, this path will vary. Although the layout is identical (propagation 
time should be the same for each edge no matter what challenge bits are chosen), manufacturing 
variability in the gate delay of each mux will result in one edge arriving at the latch first, and the 
latch acts as the ‘‘arbiter.’’ The output will, therefore, depend on the challenge bits.
In Fig. Arbiter PUF, there are 128 challenge bits and one response bit. Of course, one typically 
operates multiple identical circuits in parallel to achieve 128 response bits. In this way, the 
arbiter PUF can be scaled to an almost arbitrary number of CRPs.

RTL:
-our design has 8 bit challenge but the width can be easily modified by changing the genvar g and size parameter values
-the design has no lint issues, tested on vivado linter
-design is synthesisable
