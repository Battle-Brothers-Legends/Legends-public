::FU.Mod.Keybinds.addSQKeybind("ClosePopup", "escape", ::FU.Key.State.All, function()
{
	if (::FU.Popup.isVisible() && !::FU.Popup.isAnimating())
	{
		if (::FU.Popup.isForceQuitting())
		{
			::FU.Popup.quitGame();
		}
		else
		{
			::FU.Popup.hide();
		}
		return true;
	}
	return false;
}, "Close FU Popup");
