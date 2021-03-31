#include "MTC.h"

bool MainThreadCaller::schedulePy(PyObject* p) {
    if (p && PyCallable_Check(p)) { // can we call it?
        Py_INCREF(p);

        PyThreadState *mainThreadState = PyEval_SaveThread();
        things.push_back(p);
        while (!things.empty()) {

        }
        PyEval_RestoreThread(mainThreadState);
        return true;

    } else {
        return false;
    }
}
MainThreadCaller* MainThreadCaller::sharedState() {
    if (!MainThreadCaller::shared)
        MainThreadCaller::shared = MainThreadCaller::create();
    return MainThreadCaller::shared;
}
void MainThreadCaller::update(float o) {
    gstate = PyGILState_Ensure();
    while (!things.empty()) {
        PyObject* func = things.back();

        PyObject_CallObject(func, NULL);

        Py_DECREF(func);

        things.pop_back();
    }
    PyGILState_Release(gstate);
}
MainThreadCaller* MainThreadCaller::create() {
    auto pRet = new MainThreadCaller();
    pRet->autorelease();
    return pRet;
}
MainThreadCaller* MainThreadCaller::shared = 0;