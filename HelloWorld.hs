--import Graphics.Rendaring.OpenGL
import Graphics.UI.GLUT
import Data.IORef

import Bindings

main :: IO ()
main = do
  (progname, _) <- getArgsAndInitialize
  --initialDisplayMode $= [DoubleBuffered]
  initialDisplayMode $= [WithDepthBuffer]
  createWindow "Hello World"
  reshapeCallback $= Just reshape
  depthFunc $= Just Less
  angle <- newIORef (0.0::GLfloat)
  delta <- newIORef (0.1::GLfloat)
  position <- newIORef (0.0::GLfloat, 0.0)
  keyboardMouseCallback $= Just (keyboardMouse delta position)
  idleCallback $= Just (idle angle delta)
  displayCallback $= (display angle position)
  mainLoop
