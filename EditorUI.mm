#include "pystuff.h"

static PyObject* EditorUI_init(PyObject *self, PyObject *args)
{
    printf("EditorUI._ _init_ _ called\n");
    Py_INCREF(Py_None);
    return Py_None;
}

static PyObject* EditorUI_doSomething(PyObject *self, PyObject *args)
{
    printf("EditorUI.doSomething called\n");
    Py_INCREF(Py_None);
    return Py_None;
}

static PyMethodDef EditorUIMethods[] =
{
    {"__init__", EditorUI_init, METH_VARARGS, "doc string"},
    {"doSomething", EditorUI_doSomething, METH_VARARGS, "doc string"},
    {0, 0},
};

static PyMethodDef ModuleMethods[] = { {0, 0} };


PyObject* initEditorUI() {
    PyMethodDef *def;

    /* create new module and class objects */
    PyObject *module = Py_InitModule("EditorUI", ModuleMethods);
    PyObject *moduleDict = PyModule_GetDict(module);
    PyObject *classDict = PyDict_New();
    PyObject *className = PyString_FromString("EditorUI");
    PyObject *EditorUIClass = PyClass_New(NULL, classDict, className);
    PyDict_SetItemString(moduleDict, "EditorUI", EditorUIClass);
    Py_DECREF(classDict);
    Py_DECREF(className);
    Py_DECREF(EditorUIClass);

    /* add methods to class */
    for (def = EditorUIMethods; def->ml_name != NULL; def++) {
        PyObject *func = PyCFunction_New(def, NULL);
        PyObject *method = PyMethod_New(func, NULL, EditorUIClass);
        PyDict_SetItemString(classDict, def->ml_name, method);
        Py_DECREF(func);
        Py_DECREF(method);
    }
    return module;
}