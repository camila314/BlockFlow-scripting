#include "pystuff.h"
#include <Cacao.hpp>
#include <Cocoa/Cocoa.h>
#include <string>
using namespace cocos2d;
#include "MTC.h"
#include "cystuff/base.h"

static PyObject* PyGD_alert(PyObject *self, PyObject *args) {
    char* title;
    char* des;
    char* button;
    if(!PyArg_ParseTuple(args, "sss:alert", &title, &des, &button)) // get the arg
        return NULL;

    dispatch_async(dispatch_get_main_queue(), ^{
        auto fl = FLAlertLayer::create(title, std::string(des), button);
        fl->show();
    });
    Py_RETURN_NONE;
}

static PyMethodDef PyGDMethods[] = {
    {"alert", PyGD_alert, METH_VARARGS, "Simple FLAlertLayer creator"},
    {NULL, NULL, 0, NULL}
};

static PyModuleDef PyGDModule = {
    PyModuleDef_HEAD_INIT, "pygd", NULL, -1, PyGDMethods,
    NULL, NULL, NULL, NULL
};

static PyObject*
PyInit_PyGD(void)
{
    return PyModule_Create(&PyGDModule);
}

int dostuff(char const* progname)
{
    //Py_SetProgramName("Interactive");  /* optional but recommended */

    auto mtc = MainThreadCaller::sharedState();

    CCDirector::sharedDirector()
                ->getScheduler()
                ->scheduleUpdateForTarget(mtc,1,false);

    PyImport_AppendInittab("pygd", &PyInit_PyGD);
    PyImport_AppendInittab("EditorUI", &PyInit_base);
    Py_Initialize();
    
    PyRun_SimpleString("from EditorUI import *");
    PyRun_InteractiveLoop(stdin, "<stdin>");


    CCDirector::sharedDirector()
                ->getScheduler()
                ->unscheduleAllForTarget(mtc);

    if (Py_FinalizeEx() < 0) {
        printf("what happened\n");
        exit(120);
    }
    return 0;
}