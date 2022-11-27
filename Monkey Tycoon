local Player, Rayfield, Click, comma, Notify, CreateWindow = loadstring(game:HttpGet("https://raw.githubusercontent.com/vabalata1/a/main/Webhook"))()

Window = CreateWindow()

Farm = Window:CreateTab("Farm", 4483362458) -- Title, Image

    Toggle = Farm:CreateToggle({
	Name = "Grab Bananas",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
            GrabBananasLooping = Value
			end,
})


    Toggle = Farm:CreateToggle({
	Name = "Deposit Bananas",
	CurrentValue = false,
	Flag = "Toggle2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
            DepositBananasLooping = Value
			end,
})



    Button = Farm:CreateButton({
    Name = "Merge",
    Callback = function()
        local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.MergeDroppers;Target:FireServer();
    end,
})


    Button = Farm:CreateButton({
    Name = "Buy Monkey +1",
    Callback = function()
        local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuyDropper;Target:FireServer('1');
    end,
})


    Button = Farm:CreateButton({
    Name = "Buy Monkey +5",
    Callback = function()
        local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuyDropper;Target:FireServer('5');
    end,
})


    Button = Farm:CreateButton({
    Name = "Buy Speed Bananas Launcher",
    Callback = function()
        local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.BuySpeed;Target:FireServer('1');
    end,
})


task.spawn(function()
    while task.wait(0.00001) do
        if DepositBananasLooping then
            local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.DepositDrops;Target:FireServer();        
        end 
    end
end)




task.spawn(function()
    while task.wait(0.00001) do
        if GrabBananasLooping then
            local Target = game:GetService("ReplicatedStorage").GTycoonClient.Remotes.GrabDrops;Target:FireServer('99999999999999');
        end 
    end
end)



