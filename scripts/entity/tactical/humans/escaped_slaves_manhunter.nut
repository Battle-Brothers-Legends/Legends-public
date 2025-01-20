this.escaped_slaves_manhunter <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.EscapedSlavesManhunter;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.EscapedSlavesManhunter.XP;
		this.human.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/escaped_slaves_manhunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.EscapedSlavesManhunter);

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		b.IsSpecializedInMaces = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInThrowing = true;

		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == this.Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function assignRandomEquipment()
	{
		local weapons = [
			"weapons/scimitar",
			"weapons/oriental/light_southern_mace"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/scimitar",
				"weapons/scimitar",
				"weapons/oriental/light_southern_mace",
				"weapons/oriental/light_southern_mace",
				"weapons/battle_whip"
			]);
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));

		local armor = [
			[1, "leather_lamellar"],
			[1, "oriental/plated_nomad_mail"],
			[1, "oriental/southern_mail_shirt"]
		];

		if (this.World.getTime().Days > 18)
		{
			armor.extend([
				[1, "mail_shirt"],
				[1, "oriental/mail_and_lamellar_plating"]
			]);
		}
		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		local helmet = [
			[1, "oriental/nomad_leather_cap"],
			[1, "oriental/nomad_light_helmet"],
			[1, "oriental/wrapped_southern_helmet"],
			[1, "oriental/spiked_skull_cap_with_mail"]
		];

		if (this.World.getTime().Days <= 18)
		{
			helmet.extend([
				[1, "oriental/southern_head_wrap"]
			]);
		}
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
