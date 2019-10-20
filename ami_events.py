#!/usr/bin/env python
import time
import serial
from socket import *

server_name = '127.0.0.1'
server_port = 5038
client_socket = socket(AF_INET, SOCK_STREAM)
client_socket.connect(server_name,server_port)
sentence = "Action: Login\r\nUsername: arduino\r\nSecret: 1234\r\n\r\|n"
client_socket.send(sentence.encode())

arduino = serial.Serial("dev/ttyUSB0", 9600)
time.sllep(2)
while True:
  valor = client_socket.recv(2048).capitalize()
  print(valor)
  if valor.find("digit: 1") > 0:
    print("Orden recibida: (1) APAGAR CAFETERA")
    arduino.write("01")
    
  if valor.find("digit: 2") > 0:
    print("Orden recibida: (2) ENCENDER CAFETERA")
    arduino.write("02")
    
    if valor.find("digit: 3") > 0:
    print("Orden recibida: (3) HACER LO QUE SEA...")
    ejecuta_lo_que_quieras()
    
  
