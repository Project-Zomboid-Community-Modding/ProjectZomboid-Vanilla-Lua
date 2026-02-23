LastStandChallenge = {};

function addChallenge(challenge)
    challenge.name = getText("Challenge_" .. challenge.id .. "_name")
    challenge.description = getText("Challenge_" .. challenge.id .. "_desc")
    table.insert(LastStandChallenge, challenge)
end
