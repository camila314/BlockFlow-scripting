#cython: language_level=3
#distutils: language = c++
from base cimport (EditorUI, EditorUI_shared, 
                  CCArray,
                  makeUsable)
include "GDArray.pyx"

cdef public class Editor [object PyEditorUI, type PyEditUI]:
    cdef EditorUI* inst
    def __init__(self):
        self.inst = EditorUI_shared()
    def pasteObjects(self, obs):
        if type(obs)==str:
            obs = obs.encode()
        self.inst.pasteObjects(obs)
    @property
    def selectedObjects(self):
        cdef CCArray* sel = self.inst.getSelectedObjects()
        c = PyCCArray.fromPtr(sel)
        return c
    def deselectAll(self):
        self.inst.deselectAll()