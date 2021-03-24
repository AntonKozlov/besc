
#include <map>
#include <ostream>
#include <string>
#include <vector>

#include <llvm/IR/Instruction.h>

class source_printer {
public:
    source_printer(const char* source_path, std::ostream& out)
        : source_path(source_path), out(out) {}

    void print_code_point(const llvm::Instruction& inst);

private:
    class file {
    public:
        std::vector<std::string> lines;

        file(const std::string& filename);
    };

    const std::string source_path;
    std::ostream& out;
    std::map<std::string, file*> files;
};
