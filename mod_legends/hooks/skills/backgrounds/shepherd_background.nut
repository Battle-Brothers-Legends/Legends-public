::mods_hookExactClass("skills/backgrounds/shepherd_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Shepherd);
		this.m.Name = "Shepherd";
		this.m.Icon = "ui/backgrounds/background_44.png";
		this.m.BackgroundDescription = "Shepherds are used to physical labor and known to keep the occasional wolf at bay with a sling.";
		this.m.GoodEnding = "It was unusual that a shepherd such as %name% ever found %their% way into a company of sellswords, but %they% did prove himself an able warrior. With injuries mounting, %they% eventually retired, returning to a meadow, staff in hand, and herding sheep until %their% final, peaceful days.";
		this.m.BadEnding = "You\'d think a shepherd would have no place in the company of sellsword and, eventually, %name% agreed. %They% left the %companyname% not long after you and last you heard %they% was back to tending his sheep. While most men left the company in poor spirits, %name%\'s injuries did not bring down %their% docile lifestyle of staring at fluffy white critters about as dangerous as a bad dream.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Titles = [
			"the Shepherd",
			"the Humble",
			"the Peaceful",
			"the Goatman",
			"Hoofmind",
			"the Sheep"
		];
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale});
	}

	o.onBuildDescription <- function ()	{
		return "{%name% was just a simple shepherd from a simple town, spending many years tending to %their% flock. | A lovely place like %townname% deserved a lovely shepherd like %name%. | %name% inherited %their% flock the same day %they% buried %their% father. | As a child, %name% stumbled upon a dead shepherd and the listless flock beside %them%. The %child% took up the shepherd\'s staff and continued %their% work for many years. | More colorblind than a dog, %name% always enjoyed the company of color-friendly sheep. | When %name% fell from a tower, a flock of sheep broke %their% fall. %They% vowed to repay their sacrifice by being the safest shepherd in the land. | %name% found profit in bandying sheep about from one town to the next, selling their coats to tailors and skins to tanners. | Tending sheep was the easiest job %name% could find. | As harmless as the sheep %they% tends, %name% took to shepherding to find peace in the cruel world. | Never one to find good company amongst humans, %name% preferred the somber sapience of sheep. | Bullied as a child, %name% found peace in tending flocks of sheep. | The playfully obedient sheep of %name%\'s life gave %them% the peace and calm from an otherwise rough upbringing. | Once mistaken for a {prophet | new messiah}, %name% escaped the {religious hordes | angry inquisitors} by disappearing into the vocation of shepherding. | Watching {sheep | white blobs of wool} munch on grass all day sounds boring, but to %name% it was bliss. | Enthralled by a sheep herding competition, %name% took to shepherding as a surprisingly competitive vocation. | Always a soft, kind %child%, shepherding just made sense to the likes of %name%. | Escaping %their% abusive {mother | father | sisters | brothers | uncle | aunt}, %name% took the tranquility of being a shepherd.} {Mixed up in a religious conflict between gods followers and cultists, %their% flock suffered the wrath of those looking for both scapegoats and sacrifices. | Once fending off {brigands | wolves} with %their% walking stick, the shepherd wondered if maybe %they% was more physically capable than %they% once thought. | As time passed, the %person% felt {as though %their% vocation had passed %them% by. | like %their% heart just wasn\'t in it anymore.} {%They% mournfully retired | %They% hung up %their% shepherding stick} and sought out other work. | Feeling as though %they% was seeing the world\'s beauty but not experiencing it in full, the %person% decided to abandon shepherding. | When hulking, furry beasts slaughtered %their% flock, the shepherd was left looking for vengeance. | Sadly, the %person%\'s sole companion, a shepherding dog, was killed by {brigands | orcs | wolves}, leaving the peaceful %person% looking for revenge. | Caught in a loan shark\'s schemes, though, the shepherd suddenly needed more coin than %their% flock of sheep could ever provide. | However, the loneliness of %their% life finally got the shepherd. | But long days and nights by %themselves% wore on the shepherd as they would any %person%. | But %they% could not escape the expectations %their% father expected of %them%, and one day put down %their% walking stick to seek out a more demanding vocation. | But one day, textiling while tending, %they% led every last sheep over a cliff. | But on a rainy afternoon %they% took one baaa too many: %they% had to do something beyond just staring at sheep all day. | One morning %they% awoke covered in sheep\'s blood, entrails, and bloody, entrails-laden wool. Wolves howled merrily in the distance. As it turned out, %they% had counted one too many sheep that night. | Unfortunately, rumors of what %they% did in the privacy of %their% flock were too embarrassing to face and %they% had to flee to greener, more accepting pastures. | Sadly, brigands drunk on violence stumbled upon %their% flock. Bessie, Little Ada, and even the newborn Goatsieg were bloodily dispatched.} {While stopping into town to think things over, %name% stumbled upon a call for mercenaries. With nothing to lose, %they% is ready to sign up. | The land had no place for a peaceful shepherd. It was time to move on to a new life. | A tiny, blood-rusted bell clings below %name%\' neck. It is a relic of another life, and perhaps the sign of a new one. | %They% swears to still hear the bleating of %their% flock. For some reason, this does not inspire much confidence in %their% fighting skills. | Although peaceful as could be, without a flock the %person% is lost. | While hardly a fighter, the %person% knows how to keep a tight formation. | %name% knows the stars surprisingly well and can locate a sound in the darkness like a blind dog sniffing a treat. | Walking so much has given %name% sturdy legs, but the most combat experience %they% has is with a stick. | The world doesn\'t usually turn to shepherds in its time of need, but this is one very needy world at the moment. | Staring at the shepherd, you wonder just how bad things have gotten for such a %person% to be standing where %they% is. | %name% carries almost all weapons like they\'re walking sticks, and %they% has a bad habit of whacking the legs of others to move them along. | %name%\'s humility is a welcome respite from the usual gungho brethren that become sellswords. | %name% looks like %they% wouldn\'t hurt a fly, but with good training you can see to it that %they%\'ll hurt a lot more than that. | %name% doesn\'t carry the murderous conviction of other sellswords, but like any %person% %they% can be trained up in all the right ways. | Some of the %companyname%\'s men are little better than sheep. Maybe %name% has a place here after all.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Shepherd);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r = this.Math.rand(1, 100);

		if (r <= 25)
		{
			items.equip(this.new("scripts/items/weapons/legend_dilapidated_sling"));
		}
		else if (r <= 40)
		{
			items.equip(this.new("scripts/items/weapons/legend_sturdy_sling"));
		}
		else if (r <= 60)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.straw_hat],
		]));

	}

});

