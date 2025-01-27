this.legend_magic_web_bolt_skill <- this.inherit("scripts/skills/actives/legend_magic_skill", {
	m = {
	},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicWebBolt);
		this.m.Description = "Send a web of silk out to ensnare an opponent, rooting them in place halving their damage, defenses and initiative";
		this.m.Icon = "skills/web_bolt_01.png";
		this.m.IconDisabled = "skills/web_bolt_01_bw.png";
		this.m.Overlay = "active_114";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_shoot_net_hit_01.wav",
			"sounds/enemies/dlc2/giant_spider_shoot_net_hit_02.wav",
			"sounds/enemies/dlc2/giant_spider_shoot_net_hit_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];


		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Bind your opponent with web."
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Hit chance based on ranged attack (estimated hit chance not accurate)."
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		local ourSkill = _user.getCurrentProperties().getRangedSkill();
		local theirSkill = targetEntity.getCurrentProperties().getRangedDefense();
		local r = this.Math.rand(1, 100);

		local chance = ourSkill - theirSkill;
		chance = chance > 95 ? 95 : chance;
		chance = chance < 5 ? 5 : chance;

		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Web Bolt on " + this.Const.UI.getColorizedEntityName(targetEntity) + " (Chance: " + chance + ", Rolled: " + r +")");

		if (r <= chance)
		{
			if (targetEntity.isAlive())
			{
				if (!targetEntity.getCurrentProperties().IsImmuneToRoot)
				{
					if (this.m.SoundOnHit.len() != 0)
					{
						this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
					}

					::Legends.Effects.grant(targetEntity, ::Legends.Effect.Web);
					local breakFree = this.new("scripts/skills/actives/break_free_skill");
					breakFree.setDecal("web_destroyed");
					breakFree.m.Icon = "skills/active_113.png";
					breakFree.m.IconDisabled = "skills/active_113_sw.png";
					breakFree.m.Overlay = "active_113";
					breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;
					targetEntity.getSkills().add(breakFree);
					local effect = this.Tactical.spawnSpriteEffect("bust_web2", this.createColor("#ffffff"), _targetTile, 0, 4, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
					local flip = !targetEntity.isAlliedWithPlayer();
					effect.setHorizontalFlipping(flip);
					this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), targetEntity);
				}
			}
		}
	}

	function onNetSpawn( _targetEntity )
	{
		local rooted = _targetEntity.getSprite("status_rooted");
		rooted.setBrush("bust_web2");
		rooted.Visible = true;
		local rooted_back = _targetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush("bust_web2_back");
		rooted_back.Visible = true;
		_targetEntity.setDirty(true);
	}
});
