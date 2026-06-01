# UART-Transmitter-and-Receiver-Devices-in-Verilog
Design of UART protocol Transmitter and Receiver, testing their functioning separately and together.


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
1) Device shall be reset first to avoid anomaly, so "reset" is driven HIGH
2) After reset, device is found transmitting HIGH in "tx" until "req" is driven HIGH
3) When "req" is driven HIGH, the data in "data" is transferred to "shift_reg"
4) Transmission starts, with the order 0 (start) - data - 1 (stop)
5) The data transmitted is such that LSB is transmitted first and MSB last
6) 
