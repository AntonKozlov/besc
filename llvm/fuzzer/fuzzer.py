import sys
from random import randint, random


def headers():
    return [f'#include <{lib}.h>' for lib in ['stdio', 'stdlib']]


def test_functions():
    return [
'''
int test_read(char* filename) {
    FILE *fp = fopen(filename, "r");
    int sum = 0;
    int product = 1;
    int number = fgetc(fp);
    while (number != EOF) {
        if (number != '\\n') {
            product *= number; 
        } else {
            sum += product;
            product = 1;
        }
        number = fgetc(fp);
    }

    fclose(fp);
    return sum != 0 ? abs(sum) : 1;
} 
''',
'''
int test_write(char* filename) {
    FILE *fp = fopen(filename, "w");
    int sum = 0;
    for (int i = 0; i < rand() % 1000 + 100; i++) {
        sum += fputc(rand(), fp);
    }

    fclose(fp);
    return sum != 0 ? abs(sum) : 1;
}
'''
    ]


def create_function(number: int, size: int, files_count):

    body = [f'\nint test_{number}(int arg) {{', 'int sum = 0;', f'printf("function %d arg %d\\n", {number}, arg);', 'fflush(stdout);'] 

    for i in range(size):
        r = randint(0, 4)

        if (r == 0):
            # if + call
            body.append('if (arg > 0) {')
            body.append(f'sum += test_{randint(0, size - 1)}(arg - 1);')
            body.append('}')
        elif (r == 1):
            # for
            body.append('for (int i = 0; i < sum; i++) {')
            body.append(f'sum -= test_{randint(0, size - 1)}(arg - 1);')
            body.append('}')
        elif (r == 2):
            # while
            body.append('while (sum > 0) {')
            body.append(f'sum -= test_{randint(0, size - 1)}(arg - 1);')
            body.append('}')
        elif (r == 3):
            # read
            input = randint(0, files_count)
            if (input == files_count):
                files_count += 1
            body.append(f'sum += test_read("{input}");')
        elif (r == 4):
            # write
            output = randint(0, files_count)
            if (output == files_count):
                files_count += 1
            body.append(f'sum += test_write("{output}");')

    body.append('printf("sum %d\\n", sum);')
    body.append('fflush(stdout);')
    body.append('return sum != 0 ? abs(sum) : 1;')
    body.append('}')
    return body, files_count


def create_main(size: int):
    declarations = [f'int test_{number}(int arg);' for number in range(size)]
   
    files_count = 0
    definitions  = list()
    for number in range(size):
        definition, files_count = create_function(number, size, files_count)
        definitions.extend(definition)

    for number in range(files_count):
        with open(f'{number}', 'w') as f:
            for _ in range(size):
                f.write(str(random()) + '\n')
            f.close()

    main_func = ['int main() {', 'int sum = 0;']
    main_func.extend([f'sum += test_{number}({randint(0, size)});' for number in range(size)])
    main_func.append('return sum;')
    main_func.append('}')

    program = list()
    program.extend(headers())
    program.extend(declarations)
    program.extend(test_functions())
    program.extend(definitions)
    program.extend(main_func)

    return program
    

def generate(output: str, size: int):    
    with open(f'{output}.c', 'w') as f:
        f.write('\n'.join(create_main(size)) + '\n')
        f.close()

# output name, number of functions
generate(sys.argv[1], int(sys.argv[2]))
