from typing import List, Dict


class cobj:
    def __repr__(self) -> str:
        return ""


class valuetype(cobj):
    def __init__(self, name: str) -> None:
        self.name = name

    def __repr__(self) -> str:
        return self.name


class operation(cobj):
    def __init__(self, sign: str) -> None:
        self.sign = sign

    def __repr__(self) -> str:
        return self.sign


class operand(cobj):
    pass


class block(cobj):
    def __init__(self, body: List[cobj]) -> None:
        self.body = body

    def __repr__(self) -> str:
        return "\n".join(
            map(lambda x: "  " + "  ".join(str(x).splitlines(keepends=True)), self.body)
        )


class lvalue(operand):
    pass


class variable(lvalue):
    def __init__(self, vt: valuetype, name: str) -> None:
        self.name = name
        self.valutype = vt

    def __repr__(self) -> str:
        return self.name


class indexed(lvalue):
    def __init__(self, name: lvalue, index: operand) -> None:
        self.name = name
        self.index = index

    def __repr__(self) -> str:
        return f"{self.name}[{self.index}]"


class func(cobj):
    def __init__(self, vt: valuetype, name: str, argv: List[variable], body: block):
        self.valuetype = vt
        self.name = name
        self.argc = len(argv)
        self.argv = argv
        self.body = body

    def __repr__(self) -> str:
        return f"{self.valuetype} {self.name}({', '.join(map(lambda x: f'{x.valutype} {x}', self.argv))}) {{\n{self.body}\n}}"


class rvalue(operand):
    pass


class constant(rvalue):
    def __init__(self, value: int) -> None:
        self.value = value

    def __repr__(self) -> str:
        return str(self.value)


class fcall(rvalue):
    def __init__(self, f: func, args: List[operand]) -> None:
        self.func = f
        if len(args) != f.argc:
            raise ValueError
        else:
            self.args = args

    def __repr__(self) -> str:
        return f"{self.func.name}({', '.join(map(lambda x: str(x), self.args))})"


class binop(rvalue):
    def __init__(self, lhs: operand, rhs: operand, op: operation) -> None:
        self.lhs = lhs
        self.rhs = rhs
        self.op = op

    def __repr__(self) -> str:
        return f"({self.lhs} {self.op} {self.rhs})"


class assignop(binop):
    def __init__(self, lhs: lvalue, rhs: operand, op: operation = "") -> None:
        super().__init__(lhs, rhs, op)

    def __repr__(self) -> str:
        return f"{self.lhs} {self.op}= {self.rhs};"


class declaration(cobj):
    def __init__(self, vt: valuetype, value: operand) -> None:
        self.valuetype = vt
        self.value = value

    def __repr__(self) -> str:
        return f"{self.valuetype} {str(self.value).rstrip(';')};"


class loop(cobj):
    def __init__(self, condition: operand, body: block) -> None:
        self.condition = condition
        self.body = body


class branch(cobj):
    def __init__(self, condition: operand, thenb: block, elseb: block = None) -> None:
        self.condition = condition
        self.thenb = thenb
        self.elseb = elseb

    def __repr__(self) -> str:
        return f"if ({self.condition}) {{\n{self.thenb}\n}}" + (
            f" else {{\n{self.elseb}\n}}" if self.elseb != None else ""
        )


class forloop(loop):
    def __init__(
        self, condition: operand, body: block, init: assignop, step: binop
    ) -> None:
        super().__init__(condition, body)
        self.init = init
        self.step = step

    def __repr__(self) -> str:
        return f"for ({str(self.init).rstrip(';')}; {self.condition}; {str(self.step).rstrip(';')}) {{\n{self.body}\n}}"


class whileloop(loop):
    def __init__(self, condition: operand, body: block) -> None:
        super().__init__(condition, body)

    def __repr__(self) -> str:
        return f"while ({self.condition}) {{\n{self.body}\n}}"


class returns(cobj):
    def __init__(self, result: operand) -> None:
        self.result = result

    def __repr__(self) -> str:
        return f"return {self.result};"


class context:
    def __init__(
        self, types: Dict[str, valuetype], operations: Dict[str, operation]
    ) -> None:
        self.types = types
        self.operations = operations
        self.variables = {type: list() for type in types.values()}
        self.functions = list()
