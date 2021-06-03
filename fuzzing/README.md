## Grammar Mutation And Filtering Guide

- Install **AFL++** following the instructions [here](https://github.com/AFLplusplus/Grammar-Mutator#prerequisites)
- Then install **Grammar-Mutator** tool:
   ```
   cd AFLplusplus/custom_mutators/grammar_mutator/
   bash build_grammar_mutator.sh`
   ```
- Put `c.json` file with the proposed grammar to the following folder:
  ```
  AFLplusplus/custom_mutators/grammar_mutator/grammar_mutator/grammars
  ```
- Open `grammar_mutator` folder and run: `make GRAMMAR_FILE=grammars/c.json`
- It should create at least 2 files in the `grammar_mutator` root folder: `libgrammarmutator-c.so`
  and `grammar_generator-c`
- Then run mutation: `./grammar_generator-c 10000s 100000 ./seeds ./trees`
- Finally, you can filter the output in the `./seeds` folder using `filtering.py` script
    - When running it, just specify `./seeds` as first argument
    - The script requires `c-formatter-42` lib (can be installed with `pip`) and `gcc` (it runs the compiler as a
      subprocess)
    - The output will be saved to the same directory (`./seeds/`)