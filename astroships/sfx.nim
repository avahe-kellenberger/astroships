import api/soundeffect
export soundeffect

var
  SFX_MENU_HOVER*, SFX_MENU_CLICK*: SoundEffect

proc loadSoundEffects*() =
  SFX_MENU_HOVER = newSoundEffect("menu_hover", 255)
  SFX_MENU_CLICK = newSoundEffect("menu_click", 255)