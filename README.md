# UART-Transmitter-and-Receiver-Devices-in-Verilog
Design of UART protocol Transmitter and Receiver, testing their functioning separately and together.
Designed fully from scratch with the general idea of the UART protocol. No references used.

## UART Protocol

- It is a Serial Communication protocol, which is Full Duplex, meaning transmission and recieving can happen at the same time in between two devices, and both devices can transmit as well as receive with this protocol.
- For one device, there is a transmit line (generally named tx) and a receive line (generally named rx).
- For interconnection, tx of both devices is connected to rx of the other device. 
- The transmission is controlled by the external device, but receiving does not require external control.

## UART Transmitter

Transmits data with the structure -> 
Start bit (0/LOW) - 8 Data bits - Stop bit (1/HIGH)

### Inputs
- req (1 bit) 
- data (8 bits)
- reset (1 bit)
- clk (1 bit)

### Outputs
- busy (1 bit)
- tx (1 bit)

### Internal Registers
- cnt (4 bits)
- baudcnt (11 bits)
- shift_reg (8 bits)

### Working
1) Device shall be reset first to avoid anomaly, so "reset" is driven HIGH.
2) After reset, device is found transmitting HIGH in "tx" until "req" is driven HIGH.
3) When "req" is driven HIGH, the data in "data" is transferred to "shift_reg". This is to ensure transmission is not interrupted even if "data" is changed between transmission.
4) Transmission starts, with the order 0 (start) - data - 1 (stop). "busy" is set HIGH and remains until the stop bit transmission is completed.
5) "shift_reg" is used to store data to be transmitted. Its LSB is the bit that is under transmission. "shift_reg" undergoes a logical right shift after each bit transmission.
6) The data transmitted is such that LSB is transmitted first and MSB last.
7) "cnt" counts number of bits transmitted.
8) "baudcnt" counts number of clock cycles passed from the start of a bit transmission. It is used to terminate the current bit and start transmitting next bit after a certain number of clock cycles, to maintain baud rate.
9) For this transmitter, the clocks per bit is 5.
10) It is assumed to be given a clock of 11.0592 MHz , so for 5 clocks per bit the baud rate is 2.2 MHz.
11) 
