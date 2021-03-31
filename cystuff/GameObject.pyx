#cython: language_level=3
#distutils: language = c++
from base cimport *

cdef public class PyGameObject(PyCCObject) [object PyGameOb, type PyGameObj]:
    cdef GameObject* gameob_inst(self):
        return <GameObject*>self.inst
    def moveTo(self, x, y):
        cdef CCPoint p
        p.x = x
        p.y = y+90
        self.gameob_inst().setPosition(p)
    def move(self, x, y):
        cdef CCPoint p = self.gameob_inst().getPosition()
        p.x += x
        p.y += y
        self.gameob_inst().setPosition(p)
    @property
    def position(self):
        cdef CCPoint p = self.gameob_inst().getPosition()
        return (p.x, p.y-90)
    def rotateTo(self, deg):
        self.gameob_inst().setRotation(deg)
    @property
    def rotation(self):
        return self.gameob_inst().getRotation()