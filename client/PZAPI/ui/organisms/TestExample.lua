require "PZAPI/ui/organisms/Window"
require "PZAPI/ui/molecules/TabPanel"
local UI = PZAPI.UI

UI.TestExample = UI.Window{
    x = 100, y = 100,
    width = 350, height = 350,
    children = {
        body = UI.Window.children.body{
            children = {
                tabPanel = UI.TabPanel{
                    tabs = {"info", "skills", "health", "protection", "temperature"},
                    children = {
                        info = UI.Node{
                            name = "Info",
                            children = {
                                text = UI.Text{
                                    text = "INFO"
                                }
                            }
                        },
                        skills = UI.Node{
                            name = "Skills"
                        },
                        health = UI.Node{
                            name = "Health"
                        },
                        protection = UI.Node{
                            name = "Protection"
                        },
                        temperature = UI.Node{
                            name = "Temperature"
                        },
                    }
                }
            }
        }
    }
}
