#cython: language_level=3
#distutils: language = c++
from base cimport *

cdef public class Editor(PyCCObject) [object PyEditorUI, type PyEditUI]:

    cdef EditorUI* edit_inst(self):
        return <EditorUI*>self.inst
    def __init__(self):
        self.inst = <CCObject*>EditorUI_shared()
    def pasteObjects(self, obs):
        if type(obs)==str:
            obs = obs.encode()
        MainThreadCaller.sharedState().schedulePy(lambda: self.edit_inst().pasteObjects(obs))
    @property
    def selectedObjects(self):
        cdef CCArray* sel = self.edit_inst().getSelectedObjects()
        c = PyCCArray().fromPtr(sel)
        return c
    def deselectAll(self):
        self.edit_inst().deselectAll()