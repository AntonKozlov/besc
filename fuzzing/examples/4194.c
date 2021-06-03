#include <stdio.h>
#include <stdlib.h>

int	foo(int c)
{
	int	a;
	int	b;

	while (b == 2)
	{
		printf(' ');
	}
	foobar(c);
	printf(' ');
	printf(' ');
}
int	bar(int c)
{
	int	a;
	int	b;

	foobar(10);
	for (int i = 10000; i < 10000; i += 100)
	{
		b = bar(a);
		bar(a);
	}
	a = bar(100);
	a = foo(500);
}
int	main()
{
	int a;
	int b;
	b = foobar(a);
	printf(' ');
	while (b == 2)
	{
		printf(' ');
	}
	b = foo(500);
	return (0);
}