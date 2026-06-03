# UART-Transmitter-and-Receiver-Devices-in-Verilog
Design of UART protocol Transmitter and Receiver, and verifying their functioning separately and together.
Designed fully from scratch with the general idea of the UART protocol.

## UART Protocol

- It is a Serial Communication protocol, which is Full Duplex, meaning transmission and receiving can happen at the same time in between two devices, and both devices can transmit as well as receive with this protocol.
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
10) It is assumed to be given a clock of 11.0592 MHz , so for 5 clocks per bit the baud rate is 2.2 MHz. (Irrelevant for the working, just a baud rate calculation based on a widely used clock frequency in microcontrollers)

### Limitations
- No parity bit transmitted
- Fixed baud rate
- Fixed frame size (frame is the unit of data sent per continous transmission, which is 1 byte for this transmitter)

## UART Receiver

Receives data of 1 byte frame of the structure -> 
Start bit (0/LOW) - 8 Data bits - Stop bit (1/HIGH)

### Inputs
- rx (1 bit)
- reset (1 bit)
- clk (1 bit)

### Outputs
- data (8 bits)

### Internal Registers
- clkcnt (3 bits)
- cnt (4 bits)
- idle (1 bit)
- shift_reg (8 bits)

### Working
1) The device shall be reset first to avoid anomaly
2) After reset, the receiver stays in idle state with "idle" being LOW. The input "rx" is HIGH in idle state.
3) After receiving start bit, "idle" becomes LOW, and clocks are started to getting counted and stored in "clkcnt". This is to identify the center of the data bits with respect to the specific baud rate.
4) It identifies the center of each data bit and samples it into MSB of "shift_reg". It is sampled at center because it has the least probability of being in a metasatble state.
5) "cnt" helps keep track the number of bits passed.
6) "shift_reg" is undergone logical right shift after each sample to make space for the next sample.
7) After all data bits have been sampled, contents of "shift_reg" is moved to "data" for the external device access the data.
8) Device returns to idle state and "idle" goes HIGH until the next start bit is received.

## Simulation instructions

The working of this machine is verified using testbenches and waveforms. 


To simulate testbenches and get waveforms - 
Download all files and store them in a single folder. The simulation must be done in a Linux system, with Icarus verilog and GTKwave installed.

To simulate transmitter working - in terminal, go to the folder containing the files using cd command and execute
```bash
iverilog -o utx uart_transmitter.v Testbenches/uart_transmitter_tb.v
vvp utx
gtkwave uart_tx.vcd
```

To simulate receiver working - 
```bash
iverilog -o urx uart_receiver.v Testbenches/uart_receiver_tb.v
vvp urx
gtkwave uart_rx.vcd
```

To simulate the combined working, transmitter and receiver connected together (to test whether transmitted data is received correctly) -
```bash
iverilog -o utxrx uart_transmitter.v uart_receiver.v Testbenches/combined_tb.v
vvp utxrx
```
