this.legend_vala_crafts_staff_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Vala = null,
		RandomBrother = null,
		RandomBrother2 = null
    },

    function create() {
        this.m.Type = "encounter.legend_vala_crafts_staff";
        this.m.Name = "Vala crafts staff";
		this.m.Cooldown = 60 * ::World.getTime().SecondsPerDay;
	    this.createScreens();
	}

    function createScreens() {
        this.m.Screens.push({
            ID = "Start",
            Title = "In camp...",
			Text = "[img]gfx/ui/events/legend_vala_recruitment.png[/img]{The sounds of a heated argument draw you from your tent. What greets you is %vala% throwing inventory items left and right desperately looking for something, while %randombrother% and %randombrother2% try to stop her.%SPEECH_ON%Ye, daft witch! I spent hours organizing these!%SPEECH_OFF%%vala% simply stares at %them_randombrother% with a cold unmoving gaze and your mercenaries are taken aback. The vala finally fishes out a gnarled staff, a trophy from your fight with the hexe covenant. She plants the staff and to your surprise fishes out a runestone from her pockets. Her head tilts back and looks at your location despite you never making your presence known. sA smile spreads.%SPEECH_ON%I don\'t really give you all of these, leader%SPEECH_OFF%She inserts the gemstone into the tangled roots of the witch staff and starts a chant. The staff begins to untangle. Slowly. The roots shift like flesh — wet, unnatural. They twist and coil until something new stands in her hand. The wisewoman\'s eyes are peeled back with just the white showing but even in this state you can see a craftswoman spinning a thread that is barely visible to you.\n\nA minute passes and the staff is long and slender with an ornate pattern where the gnarled roots previously stood. It hums through the air as %vala% moves it. Her eyes don\'t move away from as she speaks.%SPEECH_ON%It is done. You can not sell this, leader. You simply can\'t.%SPEECH_OFF%Closing your gaping mouth you simply nod and watch her go back to her corner of the camp.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Vala.getImagePath());
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.legend_staff_gnarled")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/weapons/legend_named_staff_vala");
				item.m.Name = _event.m.Vala.getNameOnly() + "\'s " + item.m.Name;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				_event.m.Vala.improveMood(2.0, "Forged a staff of legend");

				if (_event.m.Vala.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Vala.getMoodState()],
						text = _event.m.Vala.getName() + this.Const.MoodStateEvent[_event.m.Vala.getMoodState()]
					});
				}

				_event.m.RandomBrother.improveMood(1.0, "Witnessed a miracle");

				if (_event.m.RandomBrother.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.RandomBrother.getMoodState()],
						text = _event.m.RandomBrother.getName() + this.Const.MoodStateEvent[_event.m.RandomBrother.getMoodState()]
					});
				}

				_event.m.RandomBrother2.improveMood(1.0, "Witnessed a miracle");

				if (_event.m.RandomBrother2.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.RandomBrother2.getMoodState()],
						text = _event.m.RandomBrother2.getName() + this.Const.MoodStateEvent[_event.m.RandomBrother2.getMoodState()]
					});
				}
			}
		});
	}

	function onPrepareVariables (_vars) {
		_vars.push([
			"vala",
			this.m.Vala.getName()
		]);
		_vars.push([
			"randombrother",
			this.m.RandomBrother.getName()
		]);
		_vars.push([
			"randombrother2",
			this.m.RandomBrother2.getName()
		]);
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Vala.getGender(), "vala");
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.RandomBrother.getGender(), "randombrother");
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.RandomBrother2.getGender(), "randombrother2");
	}

	function isValid(_camp) {
		if (::World.getPlayerRoster().getSize() < 3)
			return false;

		local bros = this.World.getPlayerRoster().getAll();
		local randomBros = [];
		foreach (bro in bros)
		{
			if (bro.getBackground().getID() != "background.legend_vala" && !bro.getSkills().hasTrait(::Legends.Trait.Player))
			{
				randomBros.push(bro);
			}
			else if (bro.getBackground().getID() == "background.legend_vala" && bro.getLevel() >= 12)
			{
				this.m.Vala = bro;
			}
		}
		if (this.m.Vala == null)
			return;

		this.m.RandomBrother = randomBros[this.Math.rand(0, randomBros.len() - 1)];
		this.m.RandomBrother2 = randomBros[this.Math.rand(0, randomBros.len() - 1)];

		return !this.isOnCooldown();
	}

	function onClear()
	{
		this.m.Vala = null;
		this.m.RandomBrother = null;
		this.m.RandomBrother2 = null;
	}
});
