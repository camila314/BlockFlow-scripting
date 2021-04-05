#include <Python.h>
#include <cc_defs.hpp>
#include <pthread.h>

class MainThreadCaller : public cocos2d::CCNode {
 public:
    bool schedulePy(PyObject* p);
    static MainThreadCaller* sharedState();
    virtual void update(float o);
    static MainThreadCaller* create();
    static MainThreadCaller* shared;
    inline bool onMain() {return threadID==pthread_self();}
 protected:
    PyGILState_STATE gstate;
    std::vector<PyObject*> things;
    pthread_t threadID;
};