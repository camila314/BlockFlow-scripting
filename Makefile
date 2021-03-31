#customizable-kind of
CXX=g++
OUTPUT=dist/main.dylib
SDK_LOCATION=/Users/jakrillis/projects/builds/macosx-sdks/MacOSX10.7.sdk/
# no touch

INCL=Cacao/include Cacao/include/cocos2dx Cacao/include/cocos2dx/include Cacao/include/cocos2dx/kazmath/include Cacao/include/cocos2dx/platform/mac Cacao/include/cocos2dx/platform/third_party/mac Cacao/include/cocos2dx/platform/third_party/mac/OGLES Cacao/include/cocos2dext Cacao/include/cocos2dx/custom/Sprites/CCMenuItemSpriteExtra
CXX_INCL=$(INCL:%=-I%)
PYCFLAGS= -I/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/include/python3.9 #-I/usr/local/Cellar/python@3.8/3.8.8_1/Frameworks/Python.framework/Versions/3.8/include/python3.8 -I/usr/local/Cellar/python@3.8/3.8.8_1/Frameworks/Python.framework/Versions/3.8/include/python3.8 -Wno-unused-result -Wsign-compare -Wunreachable-code -fno-common -dynamic -DNDEBUG -g -fwrapv -I/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/System/Library/Frameworks/Tk.framework/Versions/8.5/Headers
CXX_FLAGS= $(PYCFLAGS) `python3-config --ldflags` -mmacosx-version-min=10.7 -isysroot $(SDK_LOCATION) -std=c++11 -DCC_TARGET_OS_MAC -lGDML -lCacao -LCacao/static -dynamiclib -lSystem -lstdc++ -g Cacao/include/Cacao.cpp -Wno-deprecated

main: dist
	@echo "Building project..."
	@$(CXX) $(CXX_INCL) $(CXX_FLAGS) $(CXX_EXTRA) main.mm pystuff.mm cystuff/base.c MTC.cpp -o $(OUTPUT) -lpython3.9
	@echo "Finished"
dist:
	mkdir dist
clean: 
	-@rm -rf dist 2>/dev/null || true
inject: # If you have osxinj installed use this.
	sudo osxinj "Geometry Dash" $(OUTPUT)
cy:
	cython cystuff/base.pyx