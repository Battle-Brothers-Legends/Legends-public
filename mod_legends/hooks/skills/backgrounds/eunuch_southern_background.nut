::mods_hookExactClass("skills/backgrounds/eunuch_southern_background", function(o)
{
	o.create = function ()
	{
		this.eunuch_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = null;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Impatient)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.onBuildDescription <- function ()
	{
		return "{When desert raiders invaded his village, %name% fought back only for his cock and balls to be cut from his body as punishment. | Accused of a heinous crime in the bed of an unwanting woman, %name% had the option of death or living life as a eunuch. You don\'t need physical evidence to know which one he chose. | As a child, %name%\'s drunkard {mother | father | elder sister | elder brother} took a {hot pan | jagged knife} {to his cock while he slept | to his cock as a form of vicious torture}. | When %name% was traversing the endless deserts, he was attacked by a wild hyena which tore great strands of flesh from his body. Surviving, he eventually realized the beast had castrated him, too. | %name% hails from the whorehouses of %randomcitystate% where mutilation of his body was made to satisfy a particular customer\'s requests.} {The man was adrift when you ran across him. Now, it just seems like he wants to get away from the world, even if it means joining {sellswords | mercenaries}. Though his plight is not one you would wish upon anyone, he is a rather calm fellow. | You found the man being bullied by kids when you found him. Seeing your sword, he politely asked to join your band of men where one\'s past, or physical deformities, do not matter. He is already used to life\'s struggles, perhaps in a way most men can\'t speak to. | Surprisingly, the man stands straighter than most. He looks rather calm and collected for man who has had something so dear to him removed. | While the horrors of the man\'s past raise your hairs, and lower your nether regions into nearly being tucked, the eunuch seems unbothered by what has happened to him. He is a calm, almost passive figure. | The man has more stoicism in his movements than most monks you\'ve seen. He seems at peace with his calamitous past. | No longer able to satiate his carnal desires, the man seems rather pacified and calm. Resolute, even, and seeing more in the world than what its physical appearances might initially offer.}";
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.padded_vest]
		]))
	}
});