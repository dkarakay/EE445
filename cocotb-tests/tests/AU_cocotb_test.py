# ==============================================================================
# Authors:              Doğu Erkan Arkadaş - Utkucan Doğan
#
# Cocotb Testbench:     For Signed Magnitude Adder/Subtractor
#
# Description:
# ------------------------------------
# Several test-benches as example for EE446
#
# License:
# ==============================================================================


import random
import warnings

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
#from cocotb.triggers import RisingEdge
from cocotb.triggers import Edge
from cocotb.binary import BinaryValue
#from cocotb.regression import TestFactory


# @cocotb.test()
# async def au_fail_test(dut):
#     #Generate the clock
#     await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
#
#     clkedge = FallingEdge(dut.clk)
#     A=10
#     B=5
#     dut.A.value=A
#     dut.B.value=B
#     dut.add.value=1
#     dut.sub.value=0
#     await clkedge
#     #check if the module subtracted the values to get a fail
#     assert dut.Q.value == A - B

@cocotb.test()
async def au_basic_test(dut):
    """Setup testbench and run a test."""
    #Generate the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))

    #set clkedge as the falling edge for triggers
    clkedge = FallingEdge(dut.clk)
    #wait until the falling edge
    await clkedge
    #change input values of the module
    A=10
    B=5
    dut.A.value=A
    dut.B.value=B
    dut.add.value=1
    dut.sub.value=0      
    await clkedge
    #check if the module added the values correctly
    assert dut.Q.value == A + B
    A=15
    B=10
    dut.A.value=A
    dut.B.value=B
    await clkedge
    assert dut.Q.value == A + B
    A=15
    B=10
    dut.A.value=A
    dut.B.value=B
    dut.add.value=0
    dut.sub.value=1 
    await clkedge
    #check if the module subtracted the values correctly
    assert dut.Q.value == A - B
    
    #Make the sign bit of A 1
    A=10 + 2**(len(dut.A.value.binstr)-1)
    B=5
    dut.A.value=A
    dut.B.value=B
    dut.add.value=1
    dut.sub.value=0
    await clkedge
    #It should have done -10 + 5
    assert dut.Q.value == 5 +  2**(len(dut.A.value.binstr)-1)
    
    #Make the sign bit of B 1
    A=10 
    B=5 + 2**(len(dut.A.value.binstr)-1)
    dut.A.value=A
    dut.B.value=B
    dut.add.value=1
    dut.sub.value=0
    await clkedge
    #It should have done 10 + (-5)
    assert dut.Q.value == 5
    #Make the sign bit of B 1
    A=10 
    B=5 + 2**(len(dut.A.value.binstr)-1)
    dut.A.value=A
    dut.B.value=B
    #This time subtract
    dut.add.value=0
    dut.sub.value=1
    await clkedge
    #It should have done 10 - (-5)
    assert dut.Q.value == 15
    
    #You can print individuals bits with the below syntax
    #print(dut.Q[0].value,dut.Q[1].value,dut.Q[2].value)
    #print(dut.Q.value)


class TB:
    def __init__(self, dut):
        self.dut = dut
        #Get the index of most significant bit as it's useful
        self.msb=(len(self.dut.A.value.binstr)-1)
        
        #A model of the verilog code to confirm operation
    def performance_model(self, A, B, add, sub):
        #answer to return
        self.Q=0;
        
        #First convert signed magnitude to regular integers for python
        if(A>(2**(self.msb))):
            A = A - (2**self.msb)
            A= -A
        if(B>(2**(self.msb))):
            B = B - (2**self.msb)
            B = -B    

        #Add or subract depending on the signals    
        if(add):
            self.Q=A+B
            
        elif(sub):
            self.Q=A-B
        
        #If the result is negative format it correctly for signed magnitude
        if(self.Q<0):
            self.Q = -self.Q
            self.Q = self.Q + (2**self.msb)
        return self.Q
    
    #function run random tests selected number of times
    async def run_random_test(self, total_test_no):
        
        #Currently overflow detection is not tested
        for x in range(total_test_no):            
            self.A=random.randint(0, 100)
            self.B=random.randint(0, 100)
            
            #2 coin tosses for the sign bits and 1 for add or sub
            self.coin_toss_1=random.randint(0,1)
            self.coin_toss_2=random.randint(0,1)
            self.coin_toss_3=random.randint(0,1)
            
            #Check for negative 0 as that cannot happen with signed magnitude
            if(self.coin_toss_1==1 and self.A != 0):
                self.A = self.A +  (2**self.msb)
            if(self.coin_toss_2==1 and self.B != 0):
                self.B = self.B +  (2**self.msb)    
            if(self.coin_toss_3==1):
                self.add=1
                self.sub=0
            else:
                self.add=0;
                self.sub=1;
                
            self.dut.A.value=self.A
            self.dut.B.value=self.B
            self.dut.add.value=self.add
            self.dut.sub.value=self.sub    
            await FallingEdge(self.dut.clk)
            #print(self.dut.A.value.integer)
            #print(self.dut.B.value.integer)
            #print(self.dut.Q.value.integer)
            #print(self.add, self.sub)
            assert self.dut.Q.value.integer == self.performance_model(self.A,self.B,self.add,self.sub)
            
            
        
@cocotb.test()
async def au_advanced_test(dut):
    #Generate the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
    #create test-bench object and call it's tests
    tb = TB(dut)
    await tb.run_random_test(100)
# Register the test.
#factory = TestFactory(run_test)
#factory.generate_tests()
