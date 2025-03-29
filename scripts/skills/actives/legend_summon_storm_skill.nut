this.legend_summon_storm_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		SoundOnLightning = [
			"sounds/combat/dlc2/legendary_lightning_01.wav",
			"sounds/combat/dlc2/legendary_lightning_02.wav",
			"sounds/combat/electricity_01.wav",
			"sounds/combat/electricity_02.wav",
			"sounds/combat/electricity_03.wav",
			"sounds/combat/electricity_04.wav"
		]
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSummonStorm);
		this.m.Description = "Summons rain to the battlefield. Anyone caught in the rain will have their vision reduced by 1 and their ranged skill and ranged defense reduces by 10%. If cast when you are already wet, it will be like drinking a lionheart potion.";
		this.m.Icon = "skills/rain_square.png";
		this.m.IconDisabled = "skills/rain_square_bw.png";
		this.m.Overlay = "active_12";
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
	}


	  function isHidden()
	{
		return this.m.IsHidden || !this.getContainer().getActor().getItems().hasEmptySlot(this.Const.ItemSlot.Mainhand);
	}


	function onUse( _user, _targetTile )
	{
		local weather = this.Tactical.getWeather();
		local rain = weather.createRainSettings();

		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		{

			if (this.m.SoundOnLightning.len() != 0)
			{
				this.Sound.play(this.m.SoundOnLightning[this.Math.rand(0, this.m.SoundOnLightning.len() - 1)], this.Const.Sound.Volume.Skill * 2.0, _user.getPos());
			}
			if (!this.m.Container.hasEffect(::Legends.Effect.LionheartPotion))
			{
				::Legends.Effects.grant(this, ::Legends.Effect.LionheartPotion);
			}

			weather.setAmbientLightingColor(this.createColor(this.Const.Tactical.AmbientLightingColor.Storm));
			weather.setAmbientLightingSaturation(this.Const.Tactical.AmbientLightingSaturation.Storm);
			local clouds = weather.createCloudSettings();
			clouds.Type = this.getconsttable().CloudType.StaticFog;
			clouds.MinClouds = 12;
			clouds.MaxClouds = 18;
			clouds.MinAlpha = 0.25;
			clouds.MaxAlpha = 0.5;
			clouds.MinScale = 2.0;
			clouds.MaxScale = 3.0;
			weather.buildCloudCover(clouds);
			local rain = weather.createRainSettings();
			rain.MinDrops = 150;
			rain.MaxDrops = 150;
			rain.NumSplats = 50;
			rain.MinVelocity = 400.0;
			rain.MaxVelocity = 500.0;
			rain.MinAlpha = 1.0;
			rain.MaxAlpha = 1.0;
			rain.MinScale = 0.75;
			rain.MaxScale = 1.0;
			weather.buildRain(rain);
			this.Sound.setAmbience(0, this.Const.SoundAmbience.Rain, this.Const.Sound.Volume.Ambience, 0);
		}
		else
		{
			local everyone = this.Tactical.Entities.getAllInstances();
			foreach (ever in everyone)
			{
				foreach (e in ever)
				{
					if (e.getBaseProperties().IsAffectedByRain)
					{
						::Legends.Effects.grant(e, ::Legends.Effect.LegendRain);
					}
				}
			}
			weather.setAmbientLightingColor(this.createColor(this.Const.Tactical.AmbientLightingColor.LightRain));
			weather.setAmbientLightingSaturation(this.Const.Tactical.AmbientLightingSaturation.LightRain);
			rain.MinDrops = 20;
			rain.MaxDrops = 60;
			rain.NumSplats = 30;
			rain.MinVelocity = 250.0;
			rain.MaxVelocity = 500.0;
			rain.MinAlpha = 0.3;
			rain.MaxAlpha = 0.7;
			rain.SplatAlpha = 0.5;
			rain.MinScale = 0.6;
			rain.MaxScale = 1.1;
			weather.buildRain(rain);
			this.Sound.setAmbience(0, this.Const.SoundAmbience.RainLight, this.Const.Sound.Volume.Ambience, 0);
		}
	}




});

