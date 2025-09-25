::mods_hookExactClass("mapgen/map_generator", function(o)
{
    local registerTemplates = o.registerTemplates;
    o.registerTemplates = function()
    {
        local templateScripts = this.IO.enumerateFiles("scripts/mapgen/templates/");
        foreach (i, templateScript in templateScripts)
        {
            local inst = null;
            try { inst = this.new(templateScript); }
            catch (e) { inst = null; }

            if (inst == null) continue;

            // Only register well-formed templates (must have init() and getName())
            if (!("init" in inst) || !("getName" in inst))
            {
                // Skip non-template scripts under templates folder (e.g., helper or experimental files)
                continue;
            }

            try
            {
                inst.init();
                this.m.Templates[inst.getName()] <- inst;
            }
            catch (e)
            {
                // Skip any template that fails to initialize instead of aborting
            }
        }
    }
});
