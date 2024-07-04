`timescale 1ns / 1ps

//basic mux
module mux_2x1(
    input data0,
    input data1,
    input sel,
    output out
    );
    assign out = sel? data0 : data1 ;
endmodule

//1 bit chsllenge arbiter PUF
module unit_challenge(
    input in0,
    input in1,
    input sel,
    output out0,
    output out1
);
//wire 
mux_2x1 u0 (in0, in1, sel, out0);
mux_2x1 u1 (in1, in0, sel, out1); //input connected in reverse order
endmodule

//D Latch to capture the output
module d_latch(
input d_in, en,
output d_out
);
//design made with continuous assignment only as there were synthesis errors at top module level
assign temp0=1;
assign temp1=en&temp0;
assign d_out = d_in&temp1;
endmodule

//Final top module of the PUF
module arbiter_puf
    #(parameter size=8)
    (
    input data,
    input [size-1:0] challenge,
    output response
    );
    wire [size-1:0]w0;
    wire [size-1:0]w1;
    unit_challenge d0(data, data, challenge[0], w0[0], w1[0]);
    unit_challenge d1(w0[0], w1[0], challenge[1], w0[1], w1[1]);
    
    genvar g;
    generate
        for(g=1; g<size-1;g=g+1)
        begin
            unit_challenge d(w0[g], w1[g], challenge[g+1], w0[g+1], w1[g+1]);
        end
    endgenerate
    
    d_latch (w0[7],w1[7],response);
endmodule