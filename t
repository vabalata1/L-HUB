

local Player, Rayfield, Click, comma, Notify, CreateWindow = loadstring(game:HttpGet("https://raw.githubusercontent.com/vabalata1/a/main/Webhook"))()

local Window = CreateWindow()

local Farm = Window:CreateTab("Farm", 4483362458) -- Title, Image





  






local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")





-- Vérifie si le dossier "Client" existe
if not Workspace:FindFirstChild("Client") then
-- Crée le dossier "Client"
local clientFolder = Instance.new("Folder")
clientFolder.Name = "Client"
clientFolder.Parent = Workspace
end

-- Vérifie si le dossier "Mobs" existe
if not Workspace.Client:FindFirstChild("Mobs") then
-- Crée le dossier "Mobs"
local mobsFolder = Instance.new("Folder")
mobsFolder.Name = "Mobs"
mobsFolder.Parent = Workspace.Client
end

local Mobs = game:GetService("Workspace").Client.Mobs

-- Fonction qui téléporte le joueur vers le mob d'indice donné
local function teleportToMob(index)
  -- Vérifie si le dossier "Mobs" existe et contient au moins un mob
  if Mobs and #Mobs:GetChildren() > 0 then
    -- Sélectionne le mob d'indice donné dans la liste, ou le premier mob s'il n'existe pas
    local mob = Mobs:GetChildren()[index] or Mobs:GetChildren()[1]
    
    -- Téléporte le joueur vers le mob
    Players.LocalPlayer.Character:MoveTo(mob.PrimaryPart.Position)
  end
end

-- Fonction qui appelle récursivement "teleportToMob" avec un délai entre chaque appel
local function teleportLoop()
  if TpLooping then
    -- Téléporte le joueur vers le deuxième mob de la liste, ou le premier s'il n'existe pas
    teleportToMob(2)
    -- Attends un temps déterminé avant de recommencer
    task.delay(math.huge, teleportLoop)
  end
end






  
  



















Toggle = Farm:CreateToggle({
	Name = "Teleport Mobs",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
            TpLooping = Value
            if TpLooping then
              -- Démarre la boucle de téléportation
              teleportLoop()
            end
			end,
})







-- Fonction qui envoie un événement "MobAttack" au serveur avec la liste des mobs
local function sendMobAttackEvent()
    local args = {
      [1] = {
        [1] = "MobAttack",
        [2] = {}
      }
    }
    
    -- Vérifie si le dossier "Mobs" existe et contient des enfants (des mobs)
    if Mobs and #Mobs:GetChildren() > 0 then
      -- Parcours la liste des mobs
      for i, mob in pairs(Mobs:GetChildren()) do
        -- Récupère le nom du mob
        local mobName = mob.Name
        -- Place le nom du mob dans le tableau "args" à la bonne position
        args[1][2][mobName] = true
      end
    end
    
    ReplicatedStorage.Remotes.Server:FireServer(unpack(args))
  end
  
  -- Fonction qui appelle récursivement "sendMobAttackEvent" avec un délai entre chaque appel
  local function attackLoop()
    if AutoAttack then
      -- Envoie l'événement "MobAttack" au serveur
      sendMobAttackEvent()
      -- Attends un temps déterminé avant de recommencer
      task.delay(math.huge, attackLoop)
    end
  end
  
  Toggle = Farm:CreateToggle({
      Name = "Auto Attack",
      CurrentValue = false,
      Flag = "Toggle2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
      Callback = function(Value)
              AutoAttack = Value
              if AutoAttack then
                -- Démarre la boucle d'attaque
                attackLoop()
              end
              end,
  })


  Farm:CreateSection("enable noclip to make auto farm work better")
 
  
  
local Noclip = nil
local Clip = nil

function noclip()
	Clip = false
	local function Nocl()
		if Clip == false and game.Players.LocalPlayer.Character ~= nil then
			for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
					v.CanCollide = false
				end
			end
		end
		wait(0.21) -- basic optimization
	end
	Noclip = game:GetService('RunService').Stepped:Connect(Nocl)
end

function clip()
	if Noclip then Noclip:Disconnect() end
	Clip = true
end

Toggle = Farm:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "Toggle3",
	Callback = function(Value)
		if Value then
			noclip()
		else
			clip()
		end
	end,
})










local Tab = Window:CreateTab("Auto Join", 4483362458) -- Title, Image

local areas = game:GetService("Players").LocalPlayer.PlayerGui.UI.MissionSettings.MissionFrame.FrameGUI:GetChildren()
local areasTable = {}
local Option = ""

for i,v in pairs(areas) do
    if v:IsA("ImageLabel") then
        table.insert(areasTable, v.Name)
    end
end


local Dropdown = Tab:CreateDropdown({
    Name = "Dropdown Example",
    options = areasTable,
    CurrentOption = "",
    Flag = "Dropdown1",
    Callback = function(Option)
        -- Appel de la fonction de rappel ici
        DropdownCallback(Option)
    end,
    Options = areasTable
})

Tab:CreateSection("starts again every 30 seconds to avoid that a person is already inside")

local Toggle = Tab:CreateToggle({
    Name = "Auto Join [Room] ",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        if Value then
            enabled = true
            -- Récupération de la valeur actuelle du Dropdown
            local Option = Dropdown.CurrentOption
            while enabled do
                local character = game:GetService("Players").LocalPlayer.Character
                character:SetPrimaryPartCFrame(game:GetService("Workspace").Client.Rooms["Room_1"].CFrame)
                wait(1)

                -- Call the "RoomJoin" function
                local args = {
                    [1] = {
                        [1] = "RoomJoin",
                        [2] = workspace.Client.Interact:FindFirstChild("Game Interact")
                    }
                }
                game:GetService("ReplicatedStorage").Remotes.Server:FireServer(unpack(args))
                wait(1)

                -- Appel de la fonction de rappel du Dropdown ici
                DropdownCallback(Option)
                -- Wait for 60 seconds before repeating the loop
                wait(30)
                
                if not enabled then
                    break
                end
            end
        else
            enabled = false
            -- TP back to the original location
        end
    end,
})


function DropdownCallback(Option)
    -- Définition de Option en tant que variable locale
    local Option = Option or ""
    -- Votre code ici
    local args = {
        [1] = {
            [1] = "MapSelect",
            [2] = Option
        }
    }
    game:GetService("ReplicatedStorage").Remotes.Server:FireServer(unpack(args))
end


















local Eggs = Window:CreateTab("Eggs", 4483362458) -- Title, Image


local eggsFolder = game:GetService("Players").LocalPlayer.PlayerGui.UI.SummonSettings.SummonFrame.FrameGUI
local eggNames = {}

for _, egg in pairs(eggsFolder:GetChildren()) do
    -- Vérifie si l'enfant est une image
    if egg:IsA("ImageLabel") then
      table.insert(eggNames, egg.Name)
    end
  end

local args = {
    [1] = {
        [1] = "TierBuy",
        [2] = "Demon Slayer",
        [3] = "E",
        [4] = {}
    }
}

local Dropdown = Eggs:CreateDropdown({
  Name = "Select Egg",
  Options = eggNames,
  CurrentOption = eggNames[1],
  Flag = "Dropdown1",
  Callback = function(Option)
    -- Update the egg name in the args table
    args[1][2] = Option
  end,
})

local eggCountOptions = { "E", "R" }

local EggCountDropdown = Eggs:CreateDropdown({
  Name = "Egg Count",
  Options = eggCountOptions,
  CurrentOption = eggCountOptions[1],
  Flag = "EggCountDropdown",
  Callback = function(Option)
    -- Update the egg count in the args table
    args[1][3] = Option
  end,
})



local Section = Eggs:CreateSection("")




local Toggle = Eggs:CreateToggle({
    Name = "Open Egg",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
      -- Update the toggle state
      Toggle.State = Value
  
      if Toggle.State then
        -- Téléporte le joueur une seule fois au lieu indiqué
        game.Players.LocalPlayer.Character:MoveTo(game:GetService("Workspace").Client.NPCs.Kakashe.HumanoidRootPart.Position)
      end
  
      -- Open eggs continuously until the toggle is turned off
      while Toggle.State do
        game:GetService("ReplicatedStorage").Remotes.Server:FireServer(unpack(args))
        wait(math.huge) -- wait for half a second between each egg opening
      end
    end,
  })
  









