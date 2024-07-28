#pragma once

#include <ratio>
enum class CellType {
    BOX, 
    WALL, 
    EMPTY,
    EXIT,
    UNDEF
};

enum class WeightType {
    MINUS_INF,
    PLUS_INF,
    NUM, 
    UNDEF,
    ZERO
};

class Weight {
    WeightType m_wt = WeightType::UNDEF;
    int m_wval = 0;

public:
    Weight() {};

    Weight(WeightType wt, int wval = 0) : m_wt(wt) {
        if (wt == WeightType::NUM)
            m_wval = wval;
    } 
};

class Robot;

class LabCell {

friend Robot;

    int cell_num;

    LabCell* north;
    LabCell* north_east;
    LabCell* south_east;
    LabCell* south;
    LabCell* south_west;
    LabCell* north_west;
    

    CellType status;
    Weight weight;

    LabCell(CellType ct, int w) : status(ct){
        switch (ct) {
            case CellType::BOX:
                weight = Weight(WeightType::NUM, w);
                break;
            case CellType::WALL:
                weight = Weight(WeightType::MINUS_INF);
                break;
            case CellType::EMPTY:
                weight = Weight(WeightType::ZERO);
                break;
            case CellType::EXIT:
                weight = Weight(WeightType::PLUS_INF);
            default:
                weight = Weight(WeightType::UNDEF);
        }
    }
};

enum class Orient {
    NORTH, 
    NORTH_EAST,
    SOUTH_EAST,
    SOUTH,
    SOUTH_WEST,
    NORTH_WEST
};

class Robot {
    LabCell *cur_cell;
    Orient direction;

    void forward () {
        switch (direction) {
            case Orient::NORTH:
                cur_cell = cur_cell->north;
            break;
        }
        
    }
    void right () {
        int new_dir = (int) direction; 
        if (direction != Orient::NORTH_WEST)
            direction = (Orient) ++new_dir;
        else 
            direction = Orient::NORTH;
    }

};