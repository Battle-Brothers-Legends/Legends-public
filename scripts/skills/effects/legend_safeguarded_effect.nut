this.legend_safeguarded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Block = 0
	},
	function create() {
		this.m.ID = "effects.legend_safeguarded"; 
		this.m.Name = "Safeguarded";
		this.m.Description = "This character is being safeguarded";
		this.m.Icon = "ui/perks/safeguard_circle.png";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.IconMini = "mini_safeguard_circle";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
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
				id = 10,
				type = "text",
				icon = "ui/icons/block.png",
				text = "Gain [color=%positive%]%_block%[/color] Block",
				param = [["_block", this.m.Block]]
			}
		];
	}

	function onUpdate( _properties ) {
		_properties.Block += this.m.Block;
	}

	function onTurnStart() {
		this.removeSelf();
	}

	function onRemoved() {
		this.m.Block = 0;
	}

});