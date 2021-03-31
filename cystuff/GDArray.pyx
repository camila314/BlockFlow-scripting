#cython: language_level=3
from base cimport *

cdef public class PyCCArray(PyCCObject) [object _CCArray, type __CCArray]:

    cdef CCArray* arr_inst(self):
        return <CCArray*>self.inst

    def __len__(self):
        #print(<long>self.inst)
        return self.arr_inst().count()
    def __getitem__(self, e):
        if type(e) != int:
            raise ValueError("Invalid index")
        if e >= len(self):
            raise IndexError("CCArray index out of range")
        return PyCCObject().fromPtr(self.arr_inst().objectAtIndex(e)).reinterpret_cast()