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
        @staticmethod
        CCArray* create()
        int count()
        CCObject* objectAtIndex(unsigned int)
        void addObject(CCObject*)

    EditorUI* EditorUI_shared()
    bool onMainThread()
    long makeUsable(void*)
    char* getNode(CCObject*)

    cppclass LevelEditorLayer:
        GameObject* createObject(int, CCPoint, bool)

    cppclass EditorUI:
        void selectObjects(CCArray*, bool)
        void pasteObjects(string)
        void onDuplicate(CCObject*)
        CCArray* getSelectedObjects()
        void deselectAll()
        LevelEditorLayer* _editorLayer()

    cppclass GameObject(CCNode):
        int _id()
        void destroyObject()
        @staticmethod
        GameObject* createWithKey(int k)
        int& _zOrder()

    cppclass MainThreadCaller:
        @staticmethod
        MainThreadCaller* sharedState()
        bool schedulePy(object p)

cdef inline mainThread(object o):
    MainThreadCaller.sharedState().schedulePy(o)