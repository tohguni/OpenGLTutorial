module Display (display, idle) where

--import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
import Data.IORef

import Cube
import Points

display angle position = do
  clear [ColorBuffer, DepthBuffer]
  loadIdentity
  (x,y) <- get position
  translate $ Vector3 x y (0::GLfloat)
  preservingMatrix $ do
    a <- get angle
    rotate a $ Vector3 0 0.1 (1::GLfloat)
    scale 0.7 0.7 (0.7::GLfloat)
    mapM_ (\(x,y,z) -> preservingMatrix $ do
      color $ Color3 ((x+1.0)/2.0) ((y+1.0)/2.0) ((z+1.0)/2.0)
      translate $ Vector3 x y z
      cube (0.1::GLfloat)
      color $ Color3 (0.0::GLfloat) (0.0::GLfloat) (0.0::GLfloat)
      cubeFrame (0.1::GLfloat)
      ) $ points 7
  swapBuffers

idle angle delta = do
  a <- get angle
  d <- get delta
  angle $=! (a + d)
  postRedisplay Nothing
