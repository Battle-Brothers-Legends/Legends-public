::FU.Class.BasicTooltip <- class extends ::FU.Class.Tooltip
{
	Title = null;
	Text = null;

	constructor( _title, _text, _data = null )
	{
		this.setTitle(_title);
		this.setText(_text);
		base.constructor(_data);
	}

	function setTitle( _title )
	{
		::FU.requireOneFromTypes(["string", "function"], _title);
		this.Title = typeof _title == "string" ? @() _title : _title;
	}

	function setText( _text )
	{
		::FU.requireOneFromTypes(["string", "function"], _text);
		this.Text = typeof _text == "string" ? @() _text : _text;
	}

	function getTitle( _data )
	{
		return this.Title.getinfos().parameters.len() == 1 ? this.Title() : this.Title(_data);
	}

	function getText( _data )
	{
		return this.Text.getinfos().parameters.len() == 1 ? this.Text() : this.Text(_data);
	}

	function getUIData( _data )
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getTitle(_data)
			},
			{
				id = 2,
				type = "description",
				text = this.getText(_data)
			},
		];
	}
}
