#include <stdio.h>
#include <stdlib.h>

int	foo(int c)
{
	int	a;
	int	b;

	foobar(a);
	printf(' ');
	bar(c);
	a = bar(b);
}
int	bar(int c)
{
	int	a;
	int	b;

	while (b != 10000)
	{
		while (a == 2)
		{
			foobar(c);
		}
	}
	for (int i = 100; i < 10; i += 500)
	{
		if (a == 10)
		{
			foo(c);
			while (b < 2)
			{
				a = foo(5);
			}
			while (a != 100)
			{
				b = bar(10000);
			}
			for (int i = 5; i < 1000; i += 100)
			{
				continue ;
			}
			foo(1000);
			bar(c);
			foo(b);
			bar(b);
		}
	}
	b = foo(1);
	b = foo(b);
}
int	main()
{
	int a;
	int b;
	printf(' ');
	b = foo(a);
	bar(1000);
	b = foo(a);
	return (0);
}