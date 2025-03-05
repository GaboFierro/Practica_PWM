# Practica_PWM
📌 Descripción

Este proyecto implementa un sistema en Verilog que combina un debouncer y un controlador PWM. El debouncer estabiliza las señales de entrada provenientes de botones físicos, y el controlador PWM genera una señal modulada en ancho de pulso para controlar un servo. Se utilizan registros y lógica secuencial para manejar el duty cycle de la señal PWM en respuesta a entradas de usuario.

⚙️ Requisitos

Tarjeta FPGA DE10-Lit

Software Intel Quartus Prime Lite

Servomotor compatible con señal PWM (ejemplo: SG90, MG995)

Fuente de alimentación externa para el servomotor (5V)

Conexiones de cables jumper

📂 Estructura del Proyecto

│── Debouncer.v
│── dff.v
│── pwm.v
│── clk_divider.v
│── counter_debouncer.v
│── README.md
