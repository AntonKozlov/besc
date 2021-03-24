#include <fstream>
#include <ostream>
#include <sstream>

#include <llvm/IR/Module.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/DebugInfoMetadata.h>

#include "utils.hxx"

void source_printer::print_code_point(const llvm::Instruction& inst) {
    auto sourcefile = inst.getModule()->getSourceFileName();
    std::string full_name(this->source_path + '/' + sourcefile);

    auto* dil = static_cast<llvm::DILocation*>(inst.getMetadata("dbg"));
    if (dil == nullptr) {
        this->out << full_name << ":1:1" << std::endl;
        this->out << "\tno location" << std::endl;
        return;
    }

    auto line = dil->getLine();
    auto column = dil->getColumn();

    auto it = this->files.find(sourcefile);
    source_printer::file* file = nullptr;
    if (it == this->files.end()) {
        this->files[sourcefile] = new source_printer::file(full_name);
        file = this->files[sourcefile];
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

source_printer::file::file(const std::string& filename) {
    std::ifstream in(filename);

    std::string line;

    while (std::getline(in, line)) {
        this->lines.push_back(std::string(line));
    }
}
