import nico

const sfxDirectory = "sfx/"
const sfxFormat = ".ogg"
var sfxCount: int = 0

type
  SoundEffect* = ref object
    id*: int
    volume*:  0..255

proc newSoundEffect*(fileName: string, volume: 0..255 = 255): SoundEffect =
  ## Loads the sound effect with the given file name.
  result = SoundEffect(id: sfxCount, volume: volume)
  loadSfx(result.id, sfxDirectory & fileName & sfxFormat)
  sfxCount.inc

proc play*(this: SoundEffect) =
  ## TODO: Investigate how channel works
  sfx(0, this.id)