::mods_hookExactClass("mapgen/map_generator", function(o)
{
    local registerTemplates = o.registerTemplates;
    o.registerTemplates = function()
    {
        local roots = [
            "scripts/mapgen/templates/",
            "scripts/custom_maps/"
        ];
        foreach (root in roots)
        {
            local templateScripts = this.IO.enumerateFiles(root);
            foreach (i, templateScript in templateScripts)
            {
                local inst = null;
                try { inst = this.new(templateScript); } catch (e) { inst = null; }
                if (inst == null) continue;

                // Attempt init + register; rely on inheritance for getName()
                try
                {
                    inst.init();
                    this.m.Templates[inst.getName()] <- inst;
                }
                catch (e)
                {
                    // Non-fatal: skip templates that fail to init
                }
            }
        }
    }
});
