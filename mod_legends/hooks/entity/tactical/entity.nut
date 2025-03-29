::mods_hookBaseClass("entity/tactical/entity", function ( o )
{
	while(!("Flags" in o.m)) o=o[o.SuperName];

	o.m.IsRock <- false;
	o.m.IsTree <- false;
	o.m.IsSticks <- false;
	o.m.IsBush <- false;
	o.m.IsSupplies <- false;
	o.m.IsSummoned <- false;
	o.m.IsHidden <- false;

	o.isTree <- function ()
	{
		return this.m.IsTree;
	}

	o.isSticks <- function ()
	{
		return this.m.IsSticks;
	}

	o.isStump <- function ()
	{
		return this.m.IsStump;
	}

	o.isRock <- function ()
	{
		return this.m.IsRock;
	}

	o.isBush <- function ()
	{
		return this.m.IsBush;
	}

	o.isSupplies <- function ()
	{
		return this.m.IsSupplies;
	}

	o.isSummoned <- function ()
	{
		return this.m.IsSummoned;
	}

	o.isHidden <- function ()
	{
		return this.m.IsHidden;
	}

	o.setHidden <- function ( _val )
	{
		this.m.IsHidden = _val;
	}
});
