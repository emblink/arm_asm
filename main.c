static const int rodata_var = 255;
int global = 15;
int bss_var;

int main(void)
{
    volatile int stack_var;
    int data_var = 27;
    while(1)
    {
        data_var += global;
        stack_var += rodata_var;
    }
    return 0;
}