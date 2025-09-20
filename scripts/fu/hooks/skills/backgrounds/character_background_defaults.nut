// Provide default background methods expected by some hooks/mods
::mods_hookExactClass("skills/backgrounds/character_background", function(o)
{
    if (!("getTooltip" in o))
    {
        o.getTooltip <- function()
        {
            return [];
        }
    }
    if (!("onAnySkillUsed" in o))
    {
        o.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
        {
            // No-op default
        }
    }
});

