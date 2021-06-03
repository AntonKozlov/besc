import argparse
import os
import re

from c_formatter_42.run import run_all

MINIMAL_SYMBOLS_NUM = 200


def main(path_to_seeds: str):
    for filename in os.listdir(path_to_seeds):
        # print(f"Seeing the seed #{filename}")

        path_to_seed = os.path.join(path_to_seeds, filename)
        with open(path_to_seed, "r") as f:
            program = f.read()
        is_valid = True

        # Initial check for program's length
        if len(program) <= MINIMAL_SYMBOLS_NUM:
            is_valid = False

        # Check if the program contains at least 3 pairs of pairwise nested curly brackets
        elif not re.match(".*{.*{.*{.*}.*}.*}.*", program, flags=re.DOTALL):
            is_valid = False

        # Check if all `break` and `continue` statements are contained in some nested loops
        else:
            balance = 0
            for i, c in enumerate(program):
                if c == '{':
                    balance += 1
                elif c == '}':
                    balance -= 1
                elif program[i:i + 5] == 'break':
                    prefix = program[:i]
                    if balance <= 4 or 'for' not in prefix and 'while' not in prefix:
                        is_valid = False
                        break
                elif program[i:i + 8] == 'continue':
                    prefix = program[:i]
                    if balance <= 3 or 'for' not in prefix and 'while' not in prefix:
                        is_valid = False
                        break

        if is_valid:
            if not path_to_seed.endswith(".c"):
                os.rename(path_to_seed, f'{path_to_seed}.c')
                path_to_seed += '.c'

            if os.system(f"gcc -c -w -O0 -fsyntax-only {path_to_seed}") != 0:
                is_valid = False
            else:
                print(filename, len(program))

                # Reformat and save the program
                program = run_all(program)
                with open(path_to_seed, "w") as f:
                    f.write(program)
                continue

        if not is_valid:
            os.remove(path_to_seed)


if __name__ == '__main__':
    print(run_all("ff"))
    parser = argparse.ArgumentParser()
    parser.add_argument("seeds", help="path to the directory with generated seeds (C programs) to filter", type=str)
    args = parser.parse_args()
    main(args.seeds)
