this.legend_transformed_terrain_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 5,
	Body = "",
	Head = "",
	Injury = ""
	},
	function create()
	{
		this.m.ID = "effect.legend_transformed_terrain";
		this.m.Name = "Cunning Disguise";
		this.m.Description = "This character is currently disguised as terrain.";
		this.m.Icon = "ui/perks/bear_circle.png";
		this.m.IconMini = "status_effect_08_mini";
		this.m.Type = this.Const.SkillType.Terrain | this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		{
			ret.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "[color=%positive%]+100%[/color] Hitpoints"
				}
			]);
		}
		return ret;
	}


	function onAdded()
	{
		local actor = this.getContainer().getActor();
			if (actor.getTile().IsVisibleForPlayer)
			{
				if (this.Const.Tactical.HideParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
					}
				}
			}
		local items = actor.getItems();
		items.getData()[this.Const.ItemSlot.Offhand][0] = null;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = null;
		this.m.Body = actor.getSprite("body").getBrush().Name;
		this.m.Head = actor.getSprite("head").getBrush().Name;
		actor.getSprite("body").setBrush("brush_01");
		actor.setBrushAlpha(10);
		actor.getSprite("body").setHorizontalFlipping(1);
		actor.getSprite("head").setHorizontalFlipping(1);
		actor.getSprite("injury").setHorizontalFlipping(1);
		actor.getSprite("hair").Visible = false;
		actor.getSprite("beard").Visible = false;
		this.m.TurnsLeft = 5;

		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendTrueForm))
		{
			this.m.TurnsLeft = 6;
		}

	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("body").setBrush(this.m.Body);
		actor.setBrushAlpha(255);
		actor.getSprite("hair").Visible = true;
		actor.getSprite("beard").Visible = true;
		actor.getSprite("body").setHorizontalFlipping(0);
		actor.getSprite("head").setHorizontalFlipping(0);
		actor.getSprite("injury").setHorizontalFlipping(0);

		if (actor.getTile().IsVisibleForPlayer)
		{
			if (this.Const.Tactical.HideParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.HideParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.HideParticles[i].Brushes, actor.getTile(), this.Const.Tactical.HideParticles[i].Delay, this.Const.Tactical.HideParticles[i].Quantity, this.Const.Tactical.HideParticles[i].LifeTimeQuantity, this.Const.Tactical.HideParticles[i].SpawnRate, this.Const.Tactical.HideParticles[i].Stages);
				}
			}
		}

		local items = actor.getItems();
		items.getData()[this.Const.ItemSlot.Offhand][0] = null;
		items.getData()[this.Const.ItemSlot.Mainhand][0] = null;
	}

	function onUpdate( _properties )
	{

		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasPerk(::Legends.Perk.LegendAssassinate))
		{
			_properties.DamageRegularMin *= 2;
			_properties.DamageRegularMax *= 2;
		}
		_properties.TargetAttractionMult *= 0.5;

		local actor = this.getContainer().getActor();
		actor.setAmorAlpha(10);

		actor.getSprite("body").setBrush("brush_01");
		actor.setBrushAlpha(10);
		actor.getSprite("hair").Visible = false;
		actor.getSprite("beard").Visible = false;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});

