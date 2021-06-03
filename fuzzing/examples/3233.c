#include <stdio.h>
#include <stdlib.h>

int	foo(int c)
{
	int	a;
	int	b;

	bar(2);
	a = foobar(1000);
	foo(a);
	for (int i = 2; i < 10000; i += 10000)
	{
		b = foo(b);
	}
}
int	bar(int c)
{
	int	a;
	int	b;

	printf(' ');
	b = foobar(c);
	b = bar(a);
	foo(c);
}
int	main()
{
	int a;
	int b;
	while (a == 10000)
	{
		for (int i = 1; i < 100; i += 1)
		{
			bar(10000);
		}
	}
	bar(b);
	foobar(a);
	foo(a);
	return (0);
}