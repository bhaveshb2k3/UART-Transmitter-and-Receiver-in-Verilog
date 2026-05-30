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


### Working
- "req" should be driven HIGH to start transmitting data from "data" register.
- "data" should be ready with the data before driving "req"
- 
