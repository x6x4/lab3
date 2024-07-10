#pragma once
#include <unordered_map>
#include <string>
#include <utility>
#include <variant>


class Variable {};

class Integer {};

class Boolean {};

class Cell {};


using ValueType = std::variant<Variable, Integer, Boolean, Cell>;

struct Symbol_table {

    std::unordered_map<std::string, ValueType> symbol_table;

    void add_entry (const std::string &name) {
        symbol_table.insert(
            std::pair<std::string, ValueType>(name, ValueType())
        );
    }

    void fill_entry (const std::string &name, ValueType& value) {
        symbol_table[name] = value;
    }
};