#cython: language_level=3
#distutils: language = c++
from base cimport *

cdef public class PyGameObject(PyCCObject) [object PyGameOb, type PyGameObj]:
    cdef GameObject* gameob_inst(self):
        return <GameObject*>self.inst
    def destroy(self):
        self.gameob_inst().destroyObject()