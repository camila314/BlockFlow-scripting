// replace this code

#include <Cacao.hpp>
#include <iostream>
#include "pystuff.h"

ModContainer* m;
void inject() {
	m = new ModContainer("Template code");

	dostuff("none");
	// ...
}