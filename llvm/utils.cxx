#include <fstream>
#include <ostream>
#include <sstream>

#include <llvm/IR/Module.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/DebugInfoMetadata.h>

#include "utils.hxx"

class source_printer::file {
public:
    std::vector<std::string> lines;

    static file* read(const std::string& filename) {
        std::ifstream in(filename);
        if (!in.is_open()) {
            return nullptr;
        }

        std::string line;
        auto file = new source_printer::file();

        while (std::getline(in, line)) {
            file->lines.push_back(std::string(line));
        }

        return file;
    }
};

void source_printer::print_code_point(const llvm::Instruction& inst) {
    auto sourcefile = inst.getModule()->getSourceFileName();
    std::string full_name(this->source_path + '/' + sourcefile);

    auto* dil = static_cast<llvm::DILocation*>(inst.getMetadata("dbg"));
    if (dil == nullptr) {
        this->out << full_name << std::endl;
        this->out << "\tno location" << std::endl;
        return;
    }

    auto line = dil->getLine();
    auto column = dil->getColumn();

    auto it = this->files.find(sourcefile);
    file* file = nullptr;
    if (it == this->files.end()) {
        file = file::read(full_name);
        if (file == nullptr) {
            this->out << full_name << std::endl;
            this->out << "\tno file" << std::endl;
        }
        this->files[sourcefile] = file;
    } else {
        file = it->second;
    }

    std::stringstream line_stream;
    line_stream << line;
    auto line_str = line_stream.str();

    this->out << full_name << ':' << line << ':' << column << std::endl;
    this->out << '\t' << line_str << " |\t" << file->lines[line - 1] << std::endl;
    this->out << '\t' << std::string(line_str.size(), ' ') << " |\t" << std::string(column - 1, ' ') << '^' << std::endl;
}
