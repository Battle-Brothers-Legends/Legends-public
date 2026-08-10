::mods_hookExactClass("skills/backgrounds/witchhunter_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.Witchhunter);
		this.m.Name = "Witchhunter";
		this.m.Icon = "ui/backgrounds/background_23.png";
		this.m.BackgroundDescription = "Witchhunters tend to have some martial experience, and their resolve often remains unbroken even in the face of unspeakable horror.";
		this.m.GoodEnding = "%name% the witchhunter eventually heard word of evil spreading in northern villages. %They% departed the %companyname% and has been burning those horrid witches at the stake ever since.";
		this.m.BadEnding = "Word of evil spreading in the north drew %name% the witchhunter from the company. %They% departed with stakes, vials of strange liquids, and a lot of kindling. A month later a peasant found %them% wandering the northern wastes with %their% eyes gouged out and %their% mouth sewn shut. %They% had a strange symbol ironed into %their% chest and when the peasant touched it both %people% exploded.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Drunkard)
		];
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CrossbowTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.SwordTree,
				::Const.Perks.DaggerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.AgileTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.CalmTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [
				::Const.Perks.UndeadTree,
				::Const.Perks.OccultTree
			],
			Class = [
				::Const.Perks.PoisonClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+20[/color] Resolve at morale checks against fear, panic or mind control effects. Also knows how to craft wooden stakes for use against vampires."
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
	{
		return "{%name% appeared one day in %townname%, some say upon request {of the local council | of a local priest}. | %name% has a reputation of showing up where things out of the ordinary happen and being out and about at the darkest part of the night. | Being a quiet and grim %person%, %name% has the tendency to make other people feel uncomfortable around %them%, even afraid. | The name of %name% is known in many a village, for %they% has travelled the land to wherever %their% talents are needed the most.} {A Witchhunter %they% calls %themselves%. With %their% assortment of exotic tools %they% has a great deal of experience in getting people to confess in agony their sinful liaisons with demons and devils under terrible torture. | %They% refers to %themselves% as a Witchhunter, but only superstitious fools would believe this and fall for %their% preposterous tales. | A Witchhunter %they% calls %randomname%, and %they% claims to have seen horrors from beyond that would drive a lesser mind insane. | After %their% arrival in %townname%, rumors spread that %they% was on the hunt for devil worshippers and creatures of the night, but no one knew what the real purpose of %their% visit was. | In %townname% %they% killed an elderly woman and was thrown into the dungeon. As it turned out, the woman was responsible for the abduction and death of 3 infants, and so %they% was set free again. | For nights on end %they% sat in %townname%\'s pub, silently studying every patron like a bird of prey circling above, %their% crossbow never far away. It didn\'t sit well with the residents but they didn\'t dare approach %them%.} {By now most of the local folks want %name% to be gone rather sooner than later and would happily see %them% join a travelling mercenary company. | It seems that whatever %their% mission was is now accomplished and so %name% offers %their% service as a mercenary. | It is somewhat obvious that %name% is not easily scared and %they% also knows how to handle a crossbow. Nobody was therefore surprised as %they% approached a mercenary company that was hiring. | Now, a mercenary company would be just the tool %they% needed to fulfill %their% personal quest against the evil from the world beyond. | Most people would be glad to get rid of %them%.}";
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Faces = ::Const.Faces.OldFemale, HairColors = ::Const.HairColors.Old}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Witchhunter);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.WitchhunterTitles[this.Math.rand(0, this.Const.Strings.WitchhunterTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.ragged_surcoat]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.witchhunter_hat]
		]))

	}

	o.onUpdate = function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.MoraleCheckBravery[1] += 20;
	}

});
