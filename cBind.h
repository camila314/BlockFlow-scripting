// bad practice my ass
#include <Cacao.hpp>
using namespace cocos2d;

#include <cstdlib>
#include <memory>
#include <cxxabi.h>
#include <string>
#include "MTC.h"

char const* demangle(const char* name) {

    int status = -4; // some arbitrary value to eliminate the compiler warning

    // enable c++11 by passing the flag -std=c++11 to g++
    auto res = abi::__cxa_demangle(name, NULL, NULL, &status);

    return (status==0) ? res : name ;
}

inline EditorUI* EditorUI_shared() {
	if (LEL) {
		return LEL->_editorUI();
	} else {
		return 0;
	}
}
inline long makeUsable(void* stuff) {
	return (long)stuff;
}


inline char* getNode(CCObject* node) {
    char* name = (char*)(demangle(typeid(*node).name()));
    return name;
}

void EditorUI_pasteObjects(EditorUI* self, std::string objects);