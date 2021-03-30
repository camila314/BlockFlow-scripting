from libcpp.string cimport string

cdef extern from "../cBind.h":
    cppclass CCObject:
        void retain()
        void release()
    cppclass CCArray(CCObject):
        int count()
        CCObject* objectAtIndex(unsigned int)
    EditorUI* EditorUI_shared()
    long makeUsable(void*)
    char* getNode(CCObject*)
    cppclass EditorUI:
        void pasteObjects(string)
        CCArray* getSelectedObjects()
        void deselectAll()