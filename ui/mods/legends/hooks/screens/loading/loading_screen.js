LoadingScreen.prototype.mTipContainer = null;

mod_legends.Hooks.LoadingScreen_createDIV = LoadingScreen.prototype.createDIV;
LoadingScreen.prototype.createDIV = function (_parentDiv)
{
	mod_legends.Hooks.LoadingScreen_createDIV.call(this, _parentDiv);
	this.mTipContainer = $('<div class="text-container"></div>');
}

LoadingScreen.prototype.updateProgress = function ( _text )
{
	this.mTipOfTheDayLabel.remove();
	this.mTipOfTheDayLabel = $('<div class="text description-font-normal font-color-description">' + _text + '</div>');
	this.mTipContainer.append(this.mTipOfTheDayLabel);
	//this.mTipOfTheDayLabel.html( _text );
}
