#cython: language_level=3
from libcpp.string cimport string
from libcpp cimport bool

cdef extern from "../cBind.h":
    struct CCPoint:
        float x
        float y

    cppclass CCObject:
        void retain()
        void release()

    cppclass CCNode:
        void setPosition(CCPoint pt)
        CCPoint getPosition()
        void setRotation(float)
        float getRotation()

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

    cppclass GameObject(CCNode):
        void destroyObject()

    cppclass MainThreadCaller:
        @staticmethod
        MainThreadCaller* sharedState()
        bool schedulePy(object p)