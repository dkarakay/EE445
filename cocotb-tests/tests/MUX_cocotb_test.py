
import random
import warnings

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge



@cocotb.test()
async def mux_basic_test(dut):
    """Setup testbench and run a test."""
    #Generate the clock
    await cocotb.start(Clock(dut.CLK, 10, 'us').start(start_high=False))

    #set clkedge as the falling edge for triggers
    clkedge = FallingEdge(dut.CLK)
    #wait until the falling edge
    await clkedge

    # Check MUX
    INP=8
    SEL=2
    dut.INP.value=INP
    dut.SEL.value=SEL
    await clkedge
    print('INP 1000 SEL 2')
    print(f'INP: {dut.INP.value}')
    print(f'SEL: {dut.SEL.value}')
    print(f'OUT: {dut.OUT.value}')
    assert dut.OUT.value == 0
    print('------')

    # Check MUX
    INP = 8
    SEL = 3
    dut.INP.value = INP
    dut.SEL.value = SEL
    await clkedge
    print('INP 1000 SEL 3')
    print(f'INP: {dut.INP.value}')
    print(f'SEL: {dut.SEL.value}')
    print(f'OUT: {dut.OUT.value}')
    assert dut.OUT.value == 1
    print('------')

