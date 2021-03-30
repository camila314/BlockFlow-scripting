from base cimport *

include "GDArray.pyx"

cdef public class PyCCObject [object _CCObject, type __CCObject]:
    cdef CCObject* inst
    cdef CCObject* ob_inst(self):
        return self.inst
    @staticmethod
    cdef fromPtr(CCObject* usable):
        i = PyCCObject()
        i.inst = usable
        i.inst.retain()
        return i
    def __del__(self):
        self.inst.release()
    @property
    def typeinfo(self):
        return getNode(self.inst).decode()