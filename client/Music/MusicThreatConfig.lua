--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

local statuses = {}
statuses.VERSION = 1

table.insert(statuses, { id = "MoodlePanic", intensity = 20.0 })
table.insert(statuses, { id = "PlayerHealth", intensity = 20.0 })

-- all of these values are multiplied x 0.01 code side
table.insert(statuses, { id = "ZombiesVisible", intensity = 10.0 })
table.insert(statuses, { id = "ZombiesTargeting.DistantNotMoving", intensity = 10.0 })
table.insert(statuses, { id = "ZombiesTargeting.NearbyNotMoving", intensity = 50.0 })
table.insert(statuses, { id = "ZombiesTargeting.DistantMoving", intensity = 500.0 })
table.insert(statuses, { id = "ZombiesTargeting.NearbyMoving", intensity = 1000.0 })

MusicThreatConfig.getInstance():initStatuses(statuses)
