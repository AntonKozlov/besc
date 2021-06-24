import sys
from random import randint
from c_ast import *

name, size = sys.argv[1], int(sys.argv[2])

ctx = context(
    {"int": valuetype("int"), "array": valuetype("int*")},
    {
        "sum": operation("+"),
        "dif": operation("-"),
        "mul": operation("*"),
        "div": operation("/"),
        "gt": operation(">"),
    },
)


def headers() -> str:
    return [f"#include <{lib}.h>" for lib in ["stdio", "stdlib"]]


def create_function(number: int, size: int) -> block:
    arg = ctx.variables[ctx.types["int"]][0]
    sum = ctx.variables[ctx.types["int"]][1]
    arr = ctx.variables[ctx.types["array"]][0]

    body = list()
    body.extend([f'printf("func {number} arg %d\\n", arg);', "fflush(stdout);"])
    body.append(declaration(ctx.types["int"], assignop(sum, constant(0))))

    for _ in range(size):
        r = randint(0, 4)

        if r == 0:
            # if + call
            body.append(
                branch(
                    binop(arg, constant(0), ctx.operations["gt"]),
                    block(
                        [
                            assignop(
                                sum,
                                fcall(
                                    ctx.functions[randint(0, size - 1)],
                                    [
                                        binop(arg, constant(1), ctx.operations["dif"]),
                                        arr,
                                    ],
                                ),
                            )
                        ]
                    ),
                )
            )
        elif r == 1:
            # for
            i = variable(ctx.types["int"], "i")
            body.append(
                forloop(
                    binop(sum, i, ctx.operations["gt"]),
                    block(
                        [
                            assignop(
                                sum,
                                fcall(
                                    ctx.functions[randint(0, size - 1)],
                                    [binop(arg, i, ctx.operations["dif"]), arr],
                                ),
                                ctx.operations["sum"],
                            )
                        ]
                    ),
                    declaration(ctx.types["int"], assignop(i, constant(1))),
                    assignop(i, constant(1), ctx.operations["sum"]),
                )
            )
        elif r == 2:
            # while
            body.append(
                whileloop(
                    binop(arg, constant(0), ctx.operations["gt"]),
                    block(
                        [
                            assignop(
                                sum,
                                fcall(
                                    ctx.functions[randint(0, size - 1)],
                                    [
                                        binop(arg, constant(1), ctx.operations["dif"]),
                                        arr,
                                    ],
                                ),
                                ctx.operations["sum"],
                            )
                        ]
                    ),
                )
            )
        elif r == 3:
            # read
            body.append(
                assignop(
                    sum,
                    indexed(arr, constant(randint(0, size ** 2 - 1))),
                    ctx.operations["sum"],
                )
            )
        elif r == 4:
            # write
            body.append(
                branch(
                    binop(arg, constant(0), ctx.operations["gt"]),
                    block(
                        [
                            assignop(
                                indexed(arr, constant(randint(0, size ** 2 - 1))),
                                fcall(
                                    ctx.functions[randint(0, size - 1)],
                                    [
                                        binop(arg, constant(2), ctx.operations["div"]),
                                        arr,
                                    ],
                                ),
                                ctx.operations["sum"],
                            )
                        ]
                    ),
                )
            )

    body.append(returns(sum))

    return block(body)


def create_main(size: int) -> str:
    declarations = [f"int test_{number}(int arg, int* arr);" for number in range(size)]

    arg = variable(ctx.types["int"], "arg")
    sum = variable(ctx.types["int"], "sum")
    arr = variable(ctx.types["array"], "arr")

    ctx.variables[ctx.types["int"]].extend([arg, sum])
    ctx.variables[ctx.types["array"]].append(arr)

    ctx.functions.extend(
        [
            func(ctx.types["int"], f"test_{number}", [arg, arr], None)
            for number in range(size)
        ]
    )

    for number in range(size):
        ctx.functions[number].body = create_function(number, size)

    main = func(
        ctx.types["int"],
        "main",
        [],
        block(
            [
                declaration(ctx.types["int"], assignop(sum, constant(0))),
                declaration(
                    "int",
                    assignop(
                        arr,
                        constant(
                            f"{{{', '.join([str(randint(0, size ** 2)) for _ in range(size ** 2)])}}}"
                        ),
                        "[] ",
                    ),
                ),
            ]
        ),
    )

    main.body.body.extend(
        [
            assignop(
                sum,
                fcall(
                    ctx.functions[randint(0, size - 1)],
                    [constant(randint(0, size ** 2)), arr],
                ),
                ctx.operations["sum"],
            )
            for _ in range(size)
        ]
    )
    main.body.body.append(returns(sum))

    program = list()
    program.extend(headers())
    program.extend(declarations)
    program.extend(map(lambda x: str(x), ctx.functions))
    program.append(str(main))

    return "\n\n".join(program)


def generate(output: str, size: int) -> None:
    with open(f"{output}.c", "w") as f:
        f.write(create_main(size))
        f.close()


generate(name, size)
