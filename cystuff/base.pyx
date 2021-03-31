#cython: language_level=3
from base cimport *

cdef public class PyCCObject [object _CCObject, type __CCObject]:
    cdef CCObject* inst
    cdef CCObject* ob_inst(self):
        return self.inst

    cdef fromPtr(self, CCObject* usable):
        self.inst = usable
        self.inst.retain()
        return self
    def __del__(self):
        self.inst.release()
    @property
    def typeinfo(self):
        return getNode(self.inst).decode()
    def reinterpret_cast(self):
        ti = self.typeinfo
        if ti == "cocos2d::CCArray":
            return PyCCArray().fromPtr(self.inst)
        elif ti in ("GameObject", "EffectGameObject", "LabelGameObject", "RingObject"):
            return PyGameObject().fromPtr(self.inst)
        else:
            return self

include "GDArray.pyx"
include "EditorUI.pyx"
include "GameObject.pyx"