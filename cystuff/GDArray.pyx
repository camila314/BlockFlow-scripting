#cython: language_level=3
#distutils: language = c++
include "base.pyx"

cdef public class PyCCArray(PyCCObject) [object _CCArray, type __CCArray]:

    cdef CCArray* arr_inst(self):
        return <CCArray*>self.inst

    @staticmethod
    cdef fromPtr(CCArray* usable):
        i = PyCCArray()
        i.inst = usable
        i.inst.retain()
        return i
    def __len__(self):
        #print(<long>self.inst)
        return self.arr_inst().count()
    def __del__(self):
        self.arr_inst().release()
    def __getitem__(self, e):
        if type(e) != int:
            raise ValueError("Invalid index")
        if e >= len(self):
            raise IndexError("CCArray index out of range")
        return PyCCObject.fromPtr(self.arr_inst().objectAtIndex(e))