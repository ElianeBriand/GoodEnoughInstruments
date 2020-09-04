
#include <w4c_usart.h>


#include <stdint.h>
#include <stm32f103rc.h>
#include <system_stm32f103rc.h>
#include <stm32f1xx_ll_gpio.h>
#include <stm32f1xx_ll_dma.h>
#include <stm32f1xx_ll_usart.h>

#include <w4c_gpio.h>
#include <delay.h>
#include <panic.h>


#define serial_print_queue_SIZE					( 16 )

typedef struct
{
	uint32_t length;
	char *message;
} _serial_message;

QueueHandle_t serial_print_queue = 0;

#define ARRAY_LEN(x)            (sizeof(x) / sizeof((x)[0]))

const uint8_t __attribute__ ((aligned (4))) usart_welcome_message[] = 
"--- USART 1 link established --- \r\n" ;
const uint32_t usart_welcome_message_size = ARRAY_LEN(usart_welcome_message);




void setup_usart_1() {
    
    // Enable clock to AFIO
    RCC->APB2ENR |= RCC_APB2ENR_AFIOEN;
    
    // Enable clock to USART 1
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
    
    // Enable clock to DMA 1
    RCC->AHBENR |= RCC_AHBENR_DMA1EN;
    
    
    
    ///*
    ///
     //* USART3 GPIO Configuration
    // *
    // * PA9    ------> USART1_TX
    // * PA10   <------ USART1_RX
    // 
    LL_GPIO_InitTypeDef GPIO_InitStruct_9 = {0};
    GPIO_InitStruct_9.Pin = LL_GPIO_PIN_9;
    GPIO_InitStruct_9.Mode = LL_GPIO_MODE_ALTERNATE;
    GPIO_InitStruct_9.Speed = LL_GPIO_MODE_OUTPUT_50MHz;
    GPIO_InitStruct_9.OutputType = LL_GPIO_OUTPUT_PUSHPULL;
    GPIO_InitStruct_9.Pull = LL_GPIO_PULL_UP;
    LL_GPIO_Init(GPIOA, &GPIO_InitStruct_9);
    
    LL_GPIO_InitTypeDef GPIO_InitStruct_10 = {0};
    GPIO_InitStruct_10.Pin = LL_GPIO_PIN_10;
    GPIO_InitStruct_10.Mode = LL_GPIO_MODE_FLOATING;
    GPIO_InitStruct_10.Speed = LL_GPIO_MODE_OUTPUT_50MHz;
    GPIO_InitStruct_10.Pull = LL_GPIO_PULL_UP;
    LL_GPIO_Init(GPIOA, &GPIO_InitStruct_10);

    
    // Configure the TX DMA 
    /*
    LL_DMA_ConfigTransfer(DMA1,
                          LL_DMA_CHANNEL_4,
                          LL_DMA_DIRECTION_MEMORY_TO_PERIPH | LL_DMA_MODE_NORMAL | 
                          LL_DMA_PERIPH_NOINCREMENT | LL_DMA_MEMORY_INCREMENT |
                          LL_DMA_PDATAALIGN_BYTE | LL_DMA_MDATAALIGN_BYTE |
                          LL_DMA_PRIORITY_LOW
                         );
    
    LL_DMA_SetPeriphAddress(DMA1, LL_DMA_CHANNEL_4, (uint32_t) &USART1->DR);
    LL_DMA_SetMemoryAddress(DMA1, LL_DMA_CHANNEL_4, (uint32_t) usart_welcome_message);
    LL_DMA_SetDataLength(DMA1, LL_DMA_CHANNEL_4, usart_welcome_message_size);
    
    // Disable all DMA interrupts for this channel
    LL_DMA_DisableIT_HT(DMA1, LL_DMA_CHANNEL_4);
    LL_DMA_DisableIT_TC(DMA1, LL_DMA_CHANNEL_4);
    LL_DMA_DisableIT_TE(DMA1, LL_DMA_CHANNEL_4);
    */
    
    
    // USART configuration
    LL_USART_Disable(USART1);
    
    LL_USART_InitTypeDef USART_InitStruct = {0};
    USART_InitStruct.BaudRate = 115200;
    USART_InitStruct.DataWidth = LL_USART_DATAWIDTH_8B;
    USART_InitStruct.StopBits = LL_USART_STOPBITS_1;
    USART_InitStruct.Parity = LL_USART_PARITY_NONE;
    USART_InitStruct.TransferDirection = LL_USART_DIRECTION_TX_RX;
    USART_InitStruct.HardwareFlowControl = LL_USART_HWCONTROL_NONE;
    USART_InitStruct.OverSampling = LL_USART_OVERSAMPLING_16;
    LL_USART_Init(USART1, &USART_InitStruct); 
    
    LL_USART_ConfigAsyncMode(USART1);
    LL_USART_EnableDMAReq_RX(USART1);
    // Set correct baud rate to 115200
    // (ad-hoc STM32 function do not seem to work correctly, 
    //  so manually setting divider to 10.850 = 0xA.D -> 0xAD )
    USART1->BRR = 0xAD;
    
    
    //LL_DMA_EnableChannel(DMA1);
    // Enable USART
    LL_USART_Enable(USART1);
    
    print_serial_immediate(usart_welcome_message);
    
    serial_print_queue = xQueueCreate( serial_print_queue_SIZE, sizeof( _serial_message ) );

    
    if(serial_print_queue == 0) {
        // Unexpected failure
        while(1) {
            print_serial_immediate("PANIC: Could not create queue [serial_print_queue]???\r\n");
        }
        panic();
    } else {
        print_serial_immediate("Created queue [serial_print_queue]\r\n");
    }
    
    /*
    while(!LL_USART_IsActiveFlag_TC(USART1));
    LL_DMA_ClearFlag_HT(DMA1);
    LL_USART_ClearFlag_TC(USART1);
    */
    
    
}


extern void prepare_reboot_usart_1() {
    USART1->BRR = 0xAD;
}


void print_serial_immediate(const char* message) {
    vTaskSuspendAll();
    uint32_t len = strlen(message);
    uint32_t currIndex = 0;
    while(1) {
        LL_USART_TransmitData8(USART1, message[currIndex]);
        currIndex++;
        if(currIndex >= len) {
            break;
        }
        while(!LL_USART_IsActiveFlag_TXE(USART1));
    }
    while(!LL_USART_IsActiveFlag_TC(USART1));
    LL_USART_ClearFlag_TC(USART1);
    xTaskResumeAll();
}

// Message will be internally copied to a new buffer
char adress_buffer[50];
char example_1[] = "aaa";
char example_2[] = "aadbgfnjhezfdiorfgbujpia";
char example_3[] = "aa";
char example_4[] = "aaaa";
char example_5[] = "aaaaaa";
void print_serial(char* message) {
    
    sprintf(adress_buffer,"%p",example_1);
    print_serial_immediate("{D} print_serial: ADRESS EXAMPLE 1 = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    
    sprintf(adress_buffer,"%p",example_2);
    print_serial_immediate("{D} print_serial: ADRESS EXAMPLE 2 = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    
    sprintf(adress_buffer,"%p",example_3);
    print_serial_immediate("{D} print_serial: ADRESS EXAMPLE 3 = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    
    sprintf(adress_buffer,"%p",example_4);
    print_serial_immediate("{D} print_serial: ADRESS EXAMPLE 4 = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    
    sprintf(adress_buffer,"%p",example_5);
    print_serial_immediate("{D} print_serial: ADRESS EXAMPLE 5 = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    
    print_serial_immediate("{D} print_serial: entering\r\n");
    _serial_message current_message;
    
    current_message.length = strlen(message);
    print_serial_immediate("{D} print_serial: after strlen\r\n");
    char* message_copy = pvPortMalloc(current_message.length+1);
    sprintf(adress_buffer,"%p",message_copy);
    print_serial_immediate("{D} print_serial: malloced address = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    print_serial_immediate("{D} print_serial: after malloc\r\n");
    if(message_copy == NULL) {
        print_serial_immediate("{D} print_serial: Cannot allocate !\r\n");
        panic();
    }
    print_serial_immediate("{D} print_serial: Before strcpy\r\n");
    sprintf(adress_buffer,"%p",message);
    print_serial_immediate("{D} print_serial: message address = ");
    print_serial_immediate(adress_buffer);
    print_serial_immediate("\r\n");
    strcpy(message_copy, message);
    print_serial_immediate("{D} print_serial: After strcpy\r\n");
    current_message.message = message_copy;
    print_serial_immediate("{D} print_serial: queuing\r\n");
    xQueueSend(serial_print_queue,
               (void*) &current_message,
               ( TickType_t ) 300);
    print_serial_immediate("{D} print_serial: yielding\r\n");
    portYIELD();
    print_serial_immediate("{D} print_serial: exiting\r\n");
}

void print_serial_n(char* message, size_t length)  {
    
}

// These functions take ownership of message ptr, will free afterward
void print_serial_heap(char* message){
    
}

void print_serial_heap_n(char* message, size_t length) {
    
}

// Non blocking print: can fail if the print queue is full
int print_serial_nonblocking(char* message) {
    return SERIAL_PRINT_FAIL;
}



void usart_task(void* pvParameters ) {
    print_serial_immediate("[usart_task] Execution start\r\n");
    _serial_message current_message;
    
    while(1) {
        print_serial_immediate("[usart_task] Looping\r\n");
        if( xQueueReceive( serial_print_queue,
                (void*) &( current_message ),
                         ( TickType_t ) 0 ) == pdTRUE )
        {
            print_serial_immediate("[usart_task] Processing message\r\n");
            // Process structure
            print_serial_immediate(current_message.message);
            vPortFree(current_message.message);
            
        }
        vTaskDelay(50);
    }
    
}
