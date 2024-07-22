#pragma once
#include <iostream>


enum class BoolVal {
    TRUE, 
    FALSE, 
    UNDEF
};

class BoolValWrapper {
    BoolVal value;

public:

    BoolValWrapper operator^(const BoolValWrapper& other) const {
        if (this->value == BoolVal::UNDEF || 
            other.value == BoolVal::UNDEF)
            return BoolValWrapper(BoolVal::UNDEF);
        if (this->value == other.value)
            return BoolValWrapper(BoolVal::FALSE);
        else 
            return BoolValWrapper(BoolVal::TRUE);
    }

    BoolValWrapper() {};

    BoolValWrapper(BoolVal new_value) : value(new_value) {}

    friend std::ostream& operator<<(std::ostream& os, 
        const BoolValWrapper& object) {
            switch (object.value) {
            case BoolVal::TRUE:
                os << "True";
                break;
            case BoolVal::FALSE:
                os << "False";
                break;
            default: 
                os << "Undef";
                break;
            }
        return os;
    }

    bool operator==(const BoolValWrapper& other) const {
        return value == other.value;
    }
};

class Boolean {

BoolValWrapper value;

public:

    Boolean () {};
    Boolean (bool bool_val) {
        if (bool_val) value = BoolVal::TRUE;
        else value = BoolVal::FALSE;
    }

    Boolean(BoolVal new_value) : value(new_value) {}
    Boolean(BoolValWrapper new_value) : value(new_value) {}
    friend std::ostream& operator<<(std::ostream& os, const Boolean& boolean) {
        os << boolean.value; 
        return os; 
    }

    Boolean operator^ (const Boolean& other) const {
        return Boolean(this->value ^ other.value);
    }

    bool operator==(const Boolean& other) const {
        return value == other.value;
    }
    
};


class Integer {
    int value;

public:

    Integer() {};

    Integer(int new_value) : value(new_value) {}
    Integer operator+(const Integer& other) const {
         return Integer(value + other.value);
    }

    Integer operator-(const Integer& other) const {
        return Integer(value - other.value);
    }

    Boolean operator<(const Integer& other) const {
        return value < other.value;
    }

    Boolean operator>(const Integer& other) const {
        return value > other.value;
    }

    bool operator==(const Integer& other) const {
        return value == other.value;
    }

    friend std::ostream& operator<<(std::ostream& os, const Integer& integer) {
        os << integer.value; 
        return os; 
    }

};

enum class CellVal {
    EMPTY,
    WALL, 
    BOX,
    EXIT,
    UNDEF
};

class CellValWrapper {
    CellVal value;

public:

    CellValWrapper() {};

    CellValWrapper(CellVal new_value) : value(new_value) {}

    friend std::ostream& operator<<(std::ostream& os, 
        const CellValWrapper& object) {
            switch (object.value) {
            case CellVal::EMPTY:
                os << "Empty";
                break;
            case CellVal::WALL:
                os << "Wall";
                break;
            case CellVal::BOX:
                os << "Box";
                break;
            case CellVal::EXIT:
                os << "Exit";
                break;
            case CellVal::UNDEF:
                os << "Undef";
                break;
            }
        return os;
    }

};
class Cell {
    CellValWrapper value;

public:

    Cell() {};

    Cell(CellVal new_value) : value(new_value) {}
    friend std::ostream& operator<<(std::ostream& os, const Cell& cell) {
        os << cell.value; 
        return os; 
    }  
};
