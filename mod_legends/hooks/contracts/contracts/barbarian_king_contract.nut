::mods_hookExactClass("contracts/contracts/barbarian_king_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "The Winter King";
		this.m.DescriptionTemplates = [
			"Cold winds rise in the north. A terrible Barbarian King has emerged, dealing death and destruction to all in his path.",
			"From the icy wastes emerges a barbarian king, ready to conquer and rule the northern lands!",
			"Behold, the rise of a barbarian king in the north, his might unmatched, his fury unstoppable!",
			"The northlands are ablaze with the rise of a barbarian king, his dominance unchallenged, his strength unmatched!",
			"The savage tribes of the north rally under the banner of their new king, a barbarian lord of unmatched ferocity.",
			"A mighty barbarian king claims his throne in the frozen north, his rule marked by fire and steel.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "AGreaterThreat5")
			{
				s.start <- function ()
				{
					if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull() && this.Contract.m.Destination.isAlive())
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
					}

					local item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet]]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.makeName()) + item.makeName()
					});
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "The Winter King";
			}
		}
	}
});
