

void isr_hard_fault() {
    print_serial_immediate("ISR: isr_hard_fault\r\n");
    while(1) {
        ;
    }
}


void isr_nmi() {
    print_serial_immediate("ISR: isr_nmi\r\n");
    while(1) {
        ;
    }
}



void isr_mem_mgmt() {
    print_serial_immediate("ISR: isr_mem_mgmt\r\n");
    while(1) {
        ;
    }
}

void isr_bus_fault() {
    print_serial_immediate("ISR: isr_bus_fault\r\n");
    while(1) {
        ;
    }
}

void isr_usage_fault() {
    print_serial_immediate("ISR: isr_usage_fault\r\n");
    while(1) {
        ;
    }
}

