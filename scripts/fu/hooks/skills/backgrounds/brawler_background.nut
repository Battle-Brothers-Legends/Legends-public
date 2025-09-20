::mods_hookExactClass("skills/backgrounds/brawler_background", function(o)
{
    if (!("onAnySkillUsed" in o))
    {
        o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
        {
            // Pass-through to base handler if present, otherwise no-op
            if ("character_background" in this)
            {
                return this.character_background.onAnySkillUsed(_skill, _targetEntity, _properties);
            }
        }
    }
});

