::mods_hookExactClass("skills/backgrounds/juggler_southern_background", function(o)
{
	o.create = function ()
	{
		this.juggler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 60;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.onBuildDescription <- function ()
	{
		return "{Natural talent is rare, and %name% had it in ample supply. A quick and easy career awaited them as a juggler and performer at the most illustrious street corners. Eventually climbing to a position within the Vizir\'s court, one vicious mockery of a steward\'s nose ended badly. %name% had a choice — be thrown into the arena for the insult, or self imposed exile. | %name% is a mercurial character and very different to the performers you have seen before. Other performers swear they have not seen or heard of them before, yet they have a reputation among their own craft. When asked about their routine and history, %name% casually waves off the question and laughs. Their startling obsession with anything pointed and throwable is not all that unusual — but what you can\'t shake is the feeling that you have seen them before. | While not as dangerous as mercenary work, %name% found themselves in recent trouble concerning some knives, a target and a young street girl. When pushed for answers all they can grumble is “I did not hit her” and “It\'s not true”, normally followed by “I did not”. Even for a performer their behaviour is bizarre and often erratic, going on at length about the ideas they have for new stage plays, sometimes for hours. | Jaded by a life of performance, %name% retired from physical acts and instead devoted their time to writing for others. They had dreamt about this moment for years but when the time came to writing their audience informed them that they were, quite frankly, terrible. A long deep spiral of despair awaited %name% until the day their writing had them cast out of their home by a mob. | Slathered in a musk of arrogance, %name% strides around like everyone should know their name — throwing veiled insults as they go. Overly critical and thin skinned themselves, %name% managed to get on the bad side of almost everyone they met, somehow without realising they were doing so at all. The day another performer rejected their “help” was the last straw. In just a few moments they destroyed all their work and set out to work in another profession, much to the relief of their fellow performers. | Natural talent in the juggling arts is rare, but %name% claims to be a renowned master. Other performers swear they have never seen or heard of them before, so you take this with a pinch of salt. While juggling is not as dangerous as mercenary work, they recently found themselves in trouble after witnessing a common back-alley robbery. Eager to be a hero, %name% applied their natural talent in a new, unexpectedly violent way, much to the distress of all present. With the local Muhtasib seeking answers for the unexplained deaths, %name% wisely decided it was time for a change of profession.}";
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash]
		]));
	}
});
