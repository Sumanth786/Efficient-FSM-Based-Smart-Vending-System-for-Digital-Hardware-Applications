FSM Based Smart Vending Machine Using Verilog HDL
Project Overview

This project implements a Smart Vending Machine using Verilog HDL based on the Finite State Machine (FSM) concept. The machine accepts ₹5 and ₹10 coins, dispenses products based on the inserted amount, returns change when required, supports transaction cancellation, detects out-of-stock conditions, and maintains a sales counter.

Features
Accepts ₹5 and ₹10 coins
Product A (₹15)
Product B (₹20)
Change return functionality
Transaction cancellation and refund
Out-of-stock detection
Sales counter
FSM-based control logic
Simulated using Xilinx Vivado
FSM States
State	Amount
S0	₹0
S5	₹5
S10	₹10
S15	₹15
S20	₹20
Inputs
Signal	Description
clk	System Clock
rst	Reset Signal
coin5	₹5 Coin Input
coin10	₹10 Coin Input
sel_a	Select Product A
sel_b	Select Product B
cancel	Cancel Transaction
stock_a	Product A Availability
stock_b	Product B Availability
Outputs
Signal	Description
product_a	Dispense Product A
product_b	Dispense Product B
change5	Return ₹5 Change
refund5	Refund ₹5
refund10	Refund ₹10
out_of_stock	Out-of-Stock Indication
sale_count	Counts Successful Sales
Project Files
vending_machine.v   -> Main FSM Design
tb.v                -> Testbench
README.md           -> Project Documentation
Simulation Test Cases
Test Case 1

Product A dispensed after ₹15 payment.

Test Case 2

Product A dispensed with ₹5 change after ₹20 payment.

Test Case 3

Product B dispensed after ₹20 payment.

Test Case 4

Refund generated after cancel transaction.

Test Case 5

Out-of-stock condition detected correctly.

Test Case 6

Sales counter incremented after successful transactions.


Tools Used

Verilog HDL
Xilinx Vivado Design Suite
Basys 3 FPGA Board (Target Platform)

Applications

Snack Vending Machines
Beverage Vending Machines
Automated Kiosks
Ticketing Systems
Smart Retail Machines

Future Enhancements

LCD Display Interface
Digital Payment Support
Multiple Product Categories
Inventory Database Management
FPGA Hardware Implementation




