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
        elif ti in ("GameObject", "EffectGameObject", "LabelGameObject", "RingObject", "AnimatedGameObject"):
            return PyGameObject().fromPtr(self.inst)
        else:
            return self

def thread_sync(func):
    def k(*args, **kwargs):
        if (onMainThread()):
            return func(*args, **kwargs)
        future = []
        mainThread(lambda: future.append(func(*args, **kwargs)))
        while len(future)==0:
            continue
        return future[0]
    return k

def thread_async(func):
    def k(*args, **kwargs):
        if (onMainThread()):
            return func(*args, **kwargs)
        mainThread(lambda: func(*args, **kwargs))
    return k
include "GDArray.pyx"
include "EditorUI.pyx"
include "GameObject.pyx"
include "PyLvl.pyx"