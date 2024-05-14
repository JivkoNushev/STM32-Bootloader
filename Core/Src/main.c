
#define COUNT 200

struct A {
	int a;
	char b;
};

char data_var = 20;

unsigned data_var_bss;

struct A list[COUNT];

int main(void)
{
	int a = 9;
	int b = a + 9;
	
	return b - 18;
}