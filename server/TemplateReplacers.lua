--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

TemplateReplacers = {};

TemplateReplacers.keys = {};

TemplateReplacers.keys.fruit = {
    "Apple",
    "Orange",
    "Banana",
    "Peach",
    "Grape",
}

function TemplateReplacers.init()
    for key, list in pairs(TemplateReplacers.keys) do
        TemplateText.RegisterKey(key, list);
    end
end

Events.OnTemplateTextInit.Add(TemplateReplacers.init);

function TemplateReplacers.runExample()
    print("TemplateText Example:")

    -- A template text example (normally defined in a template file or such):
    local tpl_orig = "Hello ${firstname} ${lastname}! i would like to give you a ${fruit} as token of my appreciation.";
    -- Note: firstname and lastname are defined in Java.

    -- Build the text without overrides using the registered sets.
    local s = TemplateText.Build(tpl_orig);

    print("[1] = "..tostring(s));

    -- Defining some overrides that force a template key to be overridden by a specific value.
    local overrides = {
        firstname = "John",
        lastname = "Doe",
    }

    -- Build text with overrides
    s = TemplateText.Build(tpl_orig, overrides);

    print("[2] = "..tostring(s));

    -- Defining overrides, but here instead of overriding fruit with a specific value we redefine the random values it may pick from
    local overrides = {
        firstname = "John",
        lastname = "Doe",
        fruit = { "rotten Apple", "rotten Banana" },
    }

    -- Build text a few times, fruit should only be replaced by either 'rotten Apple' or 'rotten Banana'.
    for i=0,4 do
        s = TemplateText.Build(tpl_orig, overrides);
        print("["..tostring(3+i).."] = "..tostring(s));
    end

    --Example using a ReplaceProvider.
    --This provider takes a character and sets replacements for the 'firstname' and 'lastname' keys based on supplied character
    overrides = ReplaceProviderCharacter.new(getPlayer());
    s = TemplateText.Build(tpl_orig, overrides);
    print("[8] = "..tostring(s));

    --Custom lua overrides can still be set as well:
    overrides = ReplaceProviderCharacter.new(getPlayer());
    --Setting lua table to ReplaceProvider object:
    overrides:addKey("fruit", { "ring", "gold nugget" }); --addKey accepts both strings and lua tables as second parameter.
    for i=0,4 do
        s = TemplateText.Build(tpl_orig, overrides);
        print("["..tostring(9+i).."] = "..tostring(s));
    end
end

--Events.OnGameTimeLoaded.Add(TemplateReplacers.runExample);