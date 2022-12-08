
import random
import warnings

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge



@cocotb.test()
async def sq_basic_test(dut):
    """Setup testbench and run a test."""
    #Generate the clock
    await cocotb.start(Clock(dut.CLK, 10, 'us').start(start_high=False))

    #set clkedge as the falling edge for triggers
    clkedge = FallingEdge(dut.CLK)
    #wait until the falling edge
    await clkedge

    # Check SQ
    INC=0
    dut.INC.value=INC
    dut.RESET.value=1
    await clkedge
    print(f'ENABLE: {dut.INC.value}')
    print(f'RESET: {dut.RESET.value}')
    print(f'OUT: {dut.count.value}')
    assert dut.count.value == 0
    print('------')


  # Check SQ
    INC=1
    dut.INC.value=INC
    dut.RESET.value=0
    await clkedge
    print(f'ENABLE: {dut.INC.value}')
    print(f'RESET: {dut.RESET.value}')
    print(f'OUT: {dut.count.value}')
    assert dut.count.value == 1
    print('------')
    out = dut.count.value

    # Check SQ
    INC = 1
    dut.INC.value = INC
    dut.RESET.value = 0
    await clkedge
    print(f'ENABLE: {dut.INC.value}')
    print(f'RESET: {dut.RESET.value}')
    print(f'OUT: {dut.count.value}')
    assert dut.count.value == out+1
    print('------')



