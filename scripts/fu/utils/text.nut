::FU.Text <- {
	function color( _color, _string )
	{
		return ::Const.UI.getColorized(_string, _color);
	}

	function colorGreen( _string )
	{
		return this.color(::Const.UI.Color.PositiveValue, _string);
	}

	function colorRed( _string )
	{
		return this.color(::Const.UI.Color.NegativeValue, _string);
	}
}
