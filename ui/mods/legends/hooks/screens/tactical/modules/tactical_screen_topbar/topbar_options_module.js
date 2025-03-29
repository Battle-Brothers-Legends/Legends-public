TacticalScreenTopbarOptionsModule.prototype.changeFleeButtonToAllowRetreat = function (_allowRetreat)
{
	if (_allowRetreat === true)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Legends.BUTTON_ALLOW_RETREAT);
	}
	else if(_allowRetreat === false)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Asset.BUTTON_FLEE);
	}
};
