
#include <stdint.h>
#include <svdpi.h>
#include "tinyALUtest.h"
#include "constants.h"

int tinyALUtest (svLogicVecVal *idata_A, svLogicVecVal *idata_C,
                        svLogicVecVal *sel_op, svLogicVecVal *odata_C)
{
    if (sel_op->aval == TRIG_A)
    {
        odata_C->aval =  idata_A->aval;
    }
    else if (sel_op->aval == MULT)
    {
        odata_C->aval = idata_A->aval * idata_C->aval;
    }
    else if (sel_op->aval == SUM)
    {
        odata_C->aval = idata_A->aval + idata_C->aval;
    }
    else 
    {
        odata_C->aval = idata_C->aval;
    }
    odata_C->bval = 0;  

    return 0;
}
