#include <Python.h>
#include <cc_defs.hpp>

class MainThreadCaller : public cocos2d::CCNode {
 public:
    bool schedulePy(PyObject* p);
    static MainThreadCaller* sharedState();
    virtual void update(float o);
    static MainThreadCaller* create();
    static MainThreadCaller* shared;
 protected:
    PyGILState_STATE gstate;
    std::vector<PyObject*> things;
};