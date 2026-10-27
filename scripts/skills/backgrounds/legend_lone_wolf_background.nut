this.legend_lone_wolf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},

	function create() {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendLoneWolf);
		this.m.BackgroundDescription = "You\'ve come this far. Is it worth it? What are a few more heads on the pile in the pursuit of satisfaction?";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight)
		];
		this.m.Titles = [//More
			"the Lone Wolf",
			"the Wolf",
			"the Hyena",
			"the Hound",
			"Steelwielder",
			"the Slayer",
			"the Jouster",
			"the Giant",
			"the Mountain",
			"Butcher of %townname%",
			"the Defiler",
			"the Knightslayer",
			"the Hedge Knight"
		];

		this.m.Ethnicity = ::Math.rand(0, 2);
	}

	function setGender(_gender = -1) {
		if (_gender == -1) {
			_gender = this.setCommanderGender();
		}
		if (this.m.Ethnicity == 0) {
			this.setBodyCharacteristics(_gender, _gender ? {} : {
				Bodies = ::Const.Bodies.Muscular,
				Hairs = ::Const.Hair.CommonMale
			}, 60);
			if (_gender) {
				this.m.Names = ::Const.Strings.CharacterNamesFemale;
			}
		} else if (this.m.Ethnicity == 1) {
			this.setBodyCharacteristics(_gender, _gender ? {
				Bodies = ::Const.Bodies.SouthernFemaleMuscular,
				Faces = ::Const.Faces.SouthernFemale,
				Hairs = ::Const.Hair.SouthernFemale,
				HairColors = ::Const.HairColors.Young
			} : {
				Bodies = ::Const.Bodies.Gladiator,
				Faces = ::Const.Faces.SouthernMale,
				Hairs = ::Const.Hair.SouthernMale,
				HairColors = ::Const.HairColors.Southern,
				Beards = ::Const.Beards.Southern
			}, 60);
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		} else if (this.m.Ethnicity == 2) {
			this.setBodyCharacteristics(_gender, _gender ? {
				Bodies = ::Const.Bodies.AfricanFemaleMuscular,
				Faces = ::Const.Faces.AfricanFemale,
				Hairs = ::Const.Hair.SouthernFemale,
				HairColors = ::Const.HairColors.African
			} : {
				Bodies = ::Const.Bodies.AfricanGladiator,
				Faces = ::Const.Faces.AfricanMale,
				Hairs = ::Const.Hair.SouthernMale,
				HairColors = ::Const.HairColors.African,
				Beards = ::Const.Beards.Southern
			}, 60);
			this.m.Names = ::Const.Strings.SouthernNames;
			this.m.LastNames = ::Const.Strings.SouthernNamesLast;
		}
	}

	function onBuildDescription() {
		return "{You\'ve come so far that you forgot where you came from and how it all started. Distant memories of gold grew into fame. But what point is fame and gold to those who are mortal? If you want to create a legacy you\'ll need to prove yourself first - but years spent alone training for battles that never came will make it hard for anyone to notice you outside of a tournament.}";
	}

	function onSetAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (::Math.rand(1, 100) <= 25) {
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 25) {
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance() {
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush) {
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes() {
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendLoneWolf);
	}

	function onAddEquipment() {
		//chooses a weapon through starting event
	}
});
