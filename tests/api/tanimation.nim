import unittest
import ../../astroships

suite "animation":

  test "Animation":
    let
      frameDuration = 0.5
      frames = @[7, 5, 3, 8, 6]
      anim = newAnimation(frameDuration, frames)

    check anim.duration == 2.5
    check anim.getCurrentFrame(0.0).index == frames[0]
    check anim.getCurrentFrame(0.499).index == frames[0]

    check anim.getCurrentFrame(0.5).index == frames[1]
    check anim.getCurrentFrame(0.999).index == frames[1]

    check anim.getCurrentFrame(1.0).index == frames[2]
    check anim.getCurrentFrame(1.499).index == frames[2]

    check anim.getCurrentFrame(1.5).index == frames[3]
    check anim.getCurrentFrame(1.999).index == frames[3]

    check anim.getCurrentFrame(2.0).index == frames[4]
    check anim.getCurrentFrame(2.499).index == frames[4]

  test "Animation reversed":
    let
      frameDuration = 0.5
      frames = @[7, 5, 3, 8, 6]
      anim = newAnimation(frameDuration, frames, true)

    check anim.duration == 4.0

    check anim.getCurrentFrame(0.0).index == frames[0]
    check anim.getCurrentFrame(0.499).index == frames[0]

    check anim.getCurrentFrame(0.5).index == frames[1]
    check anim.getCurrentFrame(0.999).index == frames[1]

    check anim.getCurrentFrame(1.0).index == frames[2]
    check anim.getCurrentFrame(1.499).index == frames[2]

    check anim.getCurrentFrame(1.5).index == frames[3]
    check anim.getCurrentFrame(1.999).index == frames[3]

    check anim.getCurrentFrame(2.0).index == frames[4]
    check anim.getCurrentFrame(2.499).index == frames[4]

    check anim.getCurrentFrame(2.5).index == frames[3]
    check anim.getCurrentFrame(2.999).index == frames[3]

    check anim.getCurrentFrame(3.0).index == frames[2]
    check anim.getCurrentFrame(3.499).index == frames[2]

    check anim.getCurrentFrame(3.5).index == frames[1]
    check anim.getCurrentFrame(3.999).index == frames[1]

    expect Exception:
      discard anim.getCurrentFrame(4.0)
      discard anim.getCurrentFrame(4.499)
   
