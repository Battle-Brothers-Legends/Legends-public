WorldScreenTopbarDayTimeModule.prototype.showMessage = function(_data)
{
	this.mPausedDiv.addClass('display-block');
	this.mPausedSpacebarDiv.addClass('display-block');

	this.mPausedDiv.html(_data.Header)
	this.mPausedSpacebarDiv.empty()
	for(var i = 0; i < _data.Subheader.length; ++i)
	{
		var text = $('<div>' + _data.Subheader[i] + '</div>')
		this.mPausedSpacebarDiv.append(text);
	}
}
