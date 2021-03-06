EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 7
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 2050 1650 0    50   Input ~ 0
V_MCU_3.3
$Comp
L JLCPCB_smt:ADT7467 U10
U 1 1 5EF6331D
P 4850 2050
F 0 "U10" H 4825 2175 50  0000 C CNN
F 1 "ADT7467" H 4825 2084 50  0000 C CNN
F 2 "Package_SO:QSOP-16_3.9x4.9mm_P0.635mm" H 4800 2050 50  0001 C CNN
F 3 "" H 4800 2050 50  0001 C CNN
	1    4850 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 2350 2200 1650
Wire Wire Line
	2200 1650 2050 1650
$Comp
L power:GND #PWR0127
U 1 1 5EF64E8F
P 4450 2250
F 0 "#PWR0127" H 4450 2000 50  0001 C CNN
F 1 "GND" V 4455 2122 50  0000 R CNN
F 2 "" H 4450 2250 50  0001 C CNN
F 3 "" H 4450 2250 50  0001 C CNN
	1    4450 2250
	0    1    1    0   
$EndComp
Text HLabel 4050 2150 0    50   Input ~ 0
SMBUS_SCL
Text HLabel 5650 2150 2    50   BiDi ~ 0
SMBUS_SDA
Wire Wire Line
	5200 2150 5650 2150
Wire Wire Line
	4450 2150 4050 2150
Text HLabel 5650 2250 2    50   Output ~ 0
PWM_MAINFAN
Wire Wire Line
	5200 2250 5650 2250
Text HLabel 4150 2550 0    50   Output ~ 0
PWM_PUMP
Wire Wire Line
	4450 2550 4150 2550
Wire Wire Line
	4450 2750 3950 2750
Text HLabel 800  2350 1    50   Input ~ 0
V_MAINFAN_12
Wire Wire Line
	800  2450 800  2350
$Comp
L Device:R R?
U 1 1 5F01361F
P 800 2600
AR Path="/5EEB0B83/5F01361F" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F01361F" Ref="R20"  Part="1" 
F 0 "R20" H 870 2646 50  0000 L CNN
F 1 "10K" H 870 2555 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 730 2600 50  0001 C CNN
F 3 "~" H 800 2600 50  0001 C CNN
	1    800  2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  3100 800  2750
$Comp
L power:GND #PWR0128
U 1 1 5F018582
P 1250 3450
F 0 "#PWR0128" H 1250 3200 50  0001 C CNN
F 1 "GND" H 1255 3277 50  0000 C CNN
F 2 "" H 1250 3450 50  0001 C CNN
F 3 "" H 1250 3450 50  0001 C CNN
	1    1250 3450
	1    0    0    -1  
$EndComp
Text HLabel 1150 3000 1    50   Input ~ 0
SENSE_MAINFAN
Wire Wire Line
	1250 3100 1150 3100
Wire Wire Line
	1150 3000 1150 3100
Connection ~ 1150 3100
Wire Wire Line
	1150 3100 800  3100
$Comp
L JLCPCB_smt:EL357N(B)(TA)-G U?
U 1 1 5F00BA9B
P 1700 3050
AR Path="/5EEB0B83/5F00BA9B" Ref="U?"  Part="1" 
AR Path="/5EEC1828/5F00BA9B" Ref="U8"  Part="1" 
F 0 "U8" H 1700 3225 50  0000 C CNN
F 1 "EL357N(B)(TA)-G" H 1700 3134 50  0000 C CNN
F 2 "Package_SO:SO-4_4.4x4.3mm_P2.54mm" H 1650 3250 50  0001 C CNN
F 3 "" H 1650 3250 50  0001 C CNN
	1    1700 3050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0129
U 1 1 5F034628
P 1250 4800
F 0 "#PWR0129" H 1250 4550 50  0001 C CNN
F 1 "GND" H 1255 4627 50  0000 C CNN
F 2 "" H 1250 4800 50  0001 C CNN
F 3 "" H 1250 4800 50  0001 C CNN
	1    1250 4800
	1    0    0    -1  
$EndComp
$Comp
L JLCPCB_smt:EL357N(B)(TA)-G U?
U 1 1 5F03462E
P 1700 4400
AR Path="/5EEB0B83/5F03462E" Ref="U?"  Part="1" 
AR Path="/5EEC1828/5F03462E" Ref="U9"  Part="1" 
F 0 "U9" H 1700 4575 50  0000 C CNN
F 1 "EL357N(B)(TA)-G" H 1700 4484 50  0000 C CNN
F 2 "Package_SO:SO-4_4.4x4.3mm_P2.54mm" H 1650 4600 50  0001 C CNN
F 3 "" H 1650 4600 50  0001 C CNN
	1    1700 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F036B25
P 800 4150
AR Path="/5EEB0B83/5F036B25" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F036B25" Ref="R21"  Part="1" 
F 0 "R21" H 870 4196 50  0000 L CNN
F 1 "10K" H 870 4105 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 730 4150 50  0001 C CNN
F 3 "~" H 800 4150 50  0001 C CNN
	1    800  4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 4450 1150 4450
Wire Wire Line
	800  4450 800  4300
Wire Wire Line
	800  4000 800  3200
Wire Wire Line
	800  3200 650  3200
Wire Wire Line
	650  3200 650  2450
Wire Wire Line
	650  2450 800  2450
Connection ~ 800  2450
Text HLabel 1150 4300 1    50   Input ~ 0
SENSE_PUMP
Wire Wire Line
	1150 4300 1150 4450
Connection ~ 1150 4450
Wire Wire Line
	1150 4450 800  4450
$Comp
L Device:R R?
U 1 1 5F052BBD
P 2900 2950
AR Path="/5EEB0B83/5F052BBD" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F052BBD" Ref="R29"  Part="1" 
F 0 "R29" H 2970 2996 50  0000 L CNN
F 1 "10K" H 2970 2905 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2830 2950 50  0001 C CNN
F 3 "~" H 2900 2950 50  0001 C CNN
	1    2900 2950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F052BC9
P 2150 3600
AR Path="/5EEB0B83/5F052BC9" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F052BC9" Ref="R23"  Part="1" 
F 0 "R23" H 2220 3646 50  0000 L CNN
F 1 "10K" H 2220 3555 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2080 3600 50  0001 C CNN
F 3 "~" H 2150 3600 50  0001 C CNN
	1    2150 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0130
U 1 1 5F09C9C1
P 2250 3900
F 0 "#PWR0130" H 2250 3650 50  0001 C CNN
F 1 "GND" H 2255 3727 50  0000 C CNN
F 2 "" H 2250 3900 50  0001 C CNN
F 3 "" H 2250 3900 50  0001 C CNN
	1    2250 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 3200 3600 2650
Wire Wire Line
	3600 2650 4450 2650
$Comp
L Device:R R?
U 1 1 5F0CFDD7
P 2900 4250
AR Path="/5EEB0B83/5F0CFDD7" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F0CFDD7" Ref="R30"  Part="1" 
F 0 "R30" H 2970 4296 50  0000 L CNN
F 1 "10K" H 2970 4205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2830 4250 50  0001 C CNN
F 3 "~" H 2900 4250 50  0001 C CNN
	1    2900 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F0CFDDD
P 2150 4950
AR Path="/5EEB0B83/5F0CFDDD" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F0CFDDD" Ref="R24"  Part="1" 
F 0 "R24" H 2220 4996 50  0000 L CNN
F 1 "10K" H 2220 4905 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2080 4950 50  0001 C CNN
F 3 "~" H 2150 4950 50  0001 C CNN
	1    2150 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0131
U 1 1 5F0CFDF2
P 2900 5200
F 0 "#PWR0131" H 2900 4950 50  0001 C CNN
F 1 "GND" H 2905 5027 50  0000 C CNN
F 2 "" H 2900 5200 50  0001 C CNN
F 3 "" H 2900 5200 50  0001 C CNN
	1    2900 5200
	1    0    0    -1  
$EndComp
$Comp
L Device:Q_NMOS_DGS Q?
U 1 1 5F0CFDE4
P 2800 4800
AR Path="/5EEB0B83/5F0CFDE4" Ref="Q?"  Part="1" 
AR Path="/5EEC1828/5F0CFDE4" Ref="Q6"  Part="1" 
F 0 "Q6" H 3005 4846 50  0000 L CNN
F 1 "AO3400A" H 3005 4755 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3000 4900 50  0001 C CNN
F 3 "~" H 2800 4800 50  0001 C CNN
	1    2800 4800
	1    0    0    -1  
$EndComp
Connection ~ 3050 2350
$Comp
L power:GND #PWR0132
U 1 1 5F1181F1
P 1200 6550
F 0 "#PWR0132" H 1200 6300 50  0001 C CNN
F 1 "GND" H 1205 6377 50  0000 C CNN
F 2 "" H 1200 6550 50  0001 C CNN
F 3 "" H 1200 6550 50  0001 C CNN
	1    1200 6550
	1    0    0    -1  
$EndComp
$Comp
L JLCPCB_smt:EL357N(B)(TA)-G U?
U 1 1 5F1181F7
P 1650 6150
AR Path="/5EEB0B83/5F1181F7" Ref="U?"  Part="1" 
AR Path="/5EEC1828/5F1181F7" Ref="U7"  Part="1" 
F 0 "U7" H 1650 6325 50  0000 C CNN
F 1 "EL357N(B)(TA)-G" H 1650 6234 50  0000 C CNN
F 2 "Package_SO:SO-4_4.4x4.3mm_P2.54mm" H 1600 6350 50  0001 C CNN
F 3 "" H 1600 6350 50  0001 C CNN
	1    1650 6150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F1181FD
P 750 5900
AR Path="/5EEB0B83/5F1181FD" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F1181FD" Ref="R19"  Part="1" 
F 0 "R19" H 820 5946 50  0000 L CNN
F 1 "10K" H 820 5855 50  0000 L CNN
F 2 "Resistor_SMD:R_1206_3216Metric" V 680 5900 50  0001 C CNN
F 3 "~" H 750 5900 50  0001 C CNN
	1    750  5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 6200 1100 6200
Wire Wire Line
	750  6200 750  6050
Wire Wire Line
	750  5750 750  4950
Text HLabel 1100 6050 1    50   Input ~ 0
SENSE_AUXFAN
Wire Wire Line
	1100 6050 1100 6200
Connection ~ 1100 6200
Wire Wire Line
	1100 6200 750  6200
$Comp
L Device:R R?
U 1 1 5F118211
P 2850 6050
AR Path="/5EEB0B83/5F118211" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F118211" Ref="R28"  Part="1" 
F 0 "R28" H 2920 6096 50  0000 L CNN
F 1 "10K" H 2920 6005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2780 6050 50  0001 C CNN
F 3 "~" H 2850 6050 50  0001 C CNN
	1    2850 6050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F118217
P 2100 6700
AR Path="/5EEB0B83/5F118217" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F118217" Ref="R22"  Part="1" 
F 0 "R22" H 2170 6746 50  0000 L CNN
F 1 "10K" H 2170 6655 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 2030 6700 50  0001 C CNN
F 3 "~" H 2100 6700 50  0001 C CNN
	1    2100 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0133
U 1 1 5F118221
P 2850 7000
F 0 "#PWR0133" H 2850 6750 50  0001 C CNN
F 1 "GND" H 2855 6827 50  0000 C CNN
F 2 "" H 2850 7000 50  0001 C CNN
F 3 "" H 2850 7000 50  0001 C CNN
	1    2850 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 6850 2850 6750
Wire Wire Line
	2850 6850 2850 7000
Connection ~ 2850 6850
$Comp
L Device:Q_NMOS_DGS Q?
U 1 1 5F11822B
P 2750 6550
AR Path="/5EEB0B83/5F11822B" Ref="Q?"  Part="1" 
AR Path="/5EEC1828/5F11822B" Ref="Q4"  Part="1" 
F 0 "Q4" H 2955 6596 50  0000 L CNN
F 1 "AO3400A" H 2955 6505 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 2950 6650 50  0001 C CNN
F 3 "~" H 2750 6550 50  0001 C CNN
	1    2750 6550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 6200 2850 6300
Wire Wire Line
	2850 5750 2850 5900
Connection ~ 2850 6300
Wire Wire Line
	2850 6300 2850 6350
Wire Wire Line
	2750 6200 2750 5750
Wire Wire Line
	2750 5750 2850 5750
Connection ~ 2850 5750
Wire Wire Line
	750  4950 650  4950
Wire Wire Line
	650  4950 650  3200
Connection ~ 650  3200
Wire Wire Line
	2850 5750 3050 5750
Wire Wire Line
	4350 6300 4350 2450
Wire Wire Line
	4350 2450 4450 2450
Wire Wire Line
	2850 6300 4350 6300
Text HLabel 4150 2850 0    50   Output ~ 0
PWM_AUXFAN
Wire Wire Line
	4450 2850 4150 2850
Wire Wire Line
	5200 2350 5400 2350
Wire Wire Line
	5400 1750 5400 2350
$Comp
L Device:R R?
U 1 1 5F3F7D17
P 2400 6550
AR Path="/5EEB0B83/5F3F7D17" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F3F7D17" Ref="R25"  Part="1" 
F 0 "R25" H 2470 6596 50  0000 L CNN
F 1 "160R" H 2470 6505 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2330 6550 50  0001 C CNN
F 3 "~" H 2400 6550 50  0001 C CNN
	1    2400 6550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2250 6550 2100 6550
Connection ~ 2100 6550
Wire Wire Line
	2100 6850 2850 6850
Wire Wire Line
	2100 6200 2750 6200
Wire Wire Line
	3050 2350 3050 2600
$Comp
L Device:R R?
U 1 1 5F415DB0
P 2450 4800
AR Path="/5EEB0B83/5F415DB0" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F415DB0" Ref="R27"  Part="1" 
F 0 "R27" H 2520 4846 50  0000 L CNN
F 1 "160R" H 2520 4755 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2380 4800 50  0001 C CNN
F 3 "~" H 2450 4800 50  0001 C CNN
	1    2450 4800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3050 4050 2900 4050
Wire Wire Line
	2900 4050 2900 4100
Connection ~ 3050 4050
Wire Wire Line
	3050 4050 3050 5750
Wire Wire Line
	2900 4600 2900 4500
Wire Wire Line
	2300 4800 2150 4800
Connection ~ 2150 4800
Wire Wire Line
	2900 5200 2150 5200
Wire Wire Line
	2150 5200 2150 5100
Wire Wire Line
	2900 5000 2900 5200
Connection ~ 2900 5200
Wire Wire Line
	2900 4500 3950 4500
Connection ~ 2900 4500
Wire Wire Line
	2900 4500 2900 4400
Wire Wire Line
	3950 4500 3950 2750
Wire Wire Line
	2900 4050 2700 4050
Wire Wire Line
	2700 4050 2700 4450
Wire Wire Line
	2700 4450 2150 4450
Connection ~ 2900 4050
Wire Wire Line
	2200 2350 3050 2350
$Comp
L Device:R R?
U 1 1 5F4323EF
P 2450 3450
AR Path="/5EEB0B83/5F4323EF" Ref="R?"  Part="1" 
AR Path="/5EEC1828/5F4323EF" Ref="R26"  Part="1" 
F 0 "R26" H 2520 3496 50  0000 L CNN
F 1 "160R" H 2520 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2380 3450 50  0001 C CNN
F 3 "~" H 2450 3450 50  0001 C CNN
	1    2450 3450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2150 3750 2250 3750
Wire Wire Line
	2250 3750 2250 3900
Wire Wire Line
	2900 3750 2900 3650
Connection ~ 2250 3750
Wire Wire Line
	2300 3450 2150 3450
Connection ~ 2150 3450
Wire Wire Line
	2900 3250 2900 3200
Wire Wire Line
	3600 3200 2900 3200
Connection ~ 2900 3200
Wire Wire Line
	2900 3200 2900 3100
Wire Wire Line
	2900 2800 2900 2600
Wire Wire Line
	2900 2600 3050 2600
Connection ~ 3050 2600
Wire Wire Line
	3050 2600 3050 4050
Wire Wire Line
	2900 2600 2750 2600
Wire Wire Line
	2750 2600 2750 3100
Wire Wire Line
	2750 3100 2150 3100
Connection ~ 2900 2600
Text HLabel 5250 1750 0    50   Input ~ 0
V_ADJ_CC
Wire Wire Line
	3050 2350 3300 2350
Wire Wire Line
	5250 1750 5400 1750
Text HLabel 5800 2850 2    50   Input ~ 0
THERM_SMBALERT
Wire Wire Line
	5200 2850 5800 2850
$Comp
L Device:C C?
U 1 1 5F5E1F05
P 3300 2050
AR Path="/5EE187C5/5F5E1F05" Ref="C?"  Part="1" 
AR Path="/5EEC1828/5F5E1F05" Ref="C32"  Part="1" 
F 0 "C32" H 3415 2096 50  0000 L CNN
F 1 "100nF" H 3415 2005 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3338 1900 50  0001 C CNN
F 3 "~" H 3300 2050 50  0001 C CNN
	1    3300 2050
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F5E1F0B
P 3300 1900
AR Path="/5EE08608/5F5E1F0B" Ref="#PWR?"  Part="1" 
AR Path="/5EEC1828/5F5E1F0B" Ref="#PWR0134"  Part="1" 
F 0 "#PWR0134" H 3300 1650 50  0001 C CNN
F 1 "GND" H 3305 1727 50  0000 C CNN
F 2 "" H 3300 1900 50  0001 C CNN
F 3 "" H 3300 1900 50  0001 C CNN
	1    3300 1900
	-1   0    0    1   
$EndComp
Wire Wire Line
	3300 2200 3300 2350
Connection ~ 3300 2350
Wire Wire Line
	3300 2350 4450 2350
Text HLabel 5200 2450 2    50   Output ~ 0
D1+
Text HLabel 5200 2550 2    50   Output ~ 0
D1-
Text HLabel 5200 2650 2    50   Output ~ 0
D2+
Text HLabel 5200 2750 2    50   Output ~ 0
D2-
Wire Wire Line
	2250 3750 2900 3750
$Comp
L Device:Q_NMOS_DGS Q?
U 1 1 5F052BD3
P 2800 3450
AR Path="/5EEB0B83/5F052BD3" Ref="Q?"  Part="1" 
AR Path="/5EEC1828/5F052BD3" Ref="Q5"  Part="1" 
F 0 "Q5" H 3005 3496 50  0000 L CNN
F 1 "AO3400A" H 3005 3405 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3000 3550 50  0001 C CNN
F 3 "~" H 2800 3450 50  0001 C CNN
	1    2800 3450
	1    0    0    -1  
$EndComp
$EndSCHEMATC
