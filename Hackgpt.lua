local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")

local flying = false
local vehicleFlying = false
local flightSpeed = 50
local jumpPower = 50
local gravity = 196.2  -- Gravidade padrão no Roblox

-- Função para ativar/desativar voo com veículo
local function toggleVehicleFlight()
    vehicleFlying = not vehicleFlying
    if vehicleFlying then
        -- Criando o veículo para voo
        local vehicle = Instance.new("VehicleSeat")
        vehicle.CFrame = Player.Character.HumanoidRootPart.CFrame
        vehicle.Parent = workspace
        vehicle.Pilot = Player.Character.HumanoidRootPart
        Player.Character.HumanoidRootPart.Anchored = false
        vehicle.MaxSpeed = flightSpeed
        -- Adicionando a parte do veículo que será pilotada
        local part = Instance.new("Part")
        part.Size = Vector3.new(5, 1, 5)  -- Definindo o tamanho da base do veículo
        part.Position = Player.Character.HumanoidRootPart.Position
        part.Anchored = false
        part.CanCollide = false
        part.Parent = vehicle
    else
        -- Destruir o veículo caso o voo seja desativado
        for _, object in pairs(workspace:GetChildren()) do
            if object:IsA("VehicleSeat") then
                object:Destroy()
            end
        end
    end
end

-- Função para ajustar o poder do pulo
local function adjustJumpPower(value)
    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.JumpPower = value
    end
end

-- Função para ajustar a gravidade
local function adjustGravity(value)
    workspace.Gravity = value
end

-- Criando a GUI com rolagem
local function createHubGui()
    -- Criando a Interface
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HubGui"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    -- MainFrame (com transparência)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.5
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    -- OpenButton (botão para abrir)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Text = "Abrir Hub"
    OpenButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    OpenButton.Position = UDim2.new(0, 0, 0.9, 0)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.Parent = ScreenGui

    -- CloseButton (botão para fechar)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "Fechar"
    CloseButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = MainFrame

    -- Botão de Voo com Veículo
    local VehicleFlyButton = Instance.new("TextButton")
    VehicleFlyButton.Text = "Ativar Voo com Veículo"
    VehicleFlyButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    VehicleFlyButton.Position = UDim2.new(0.3, 0, 0.65, 0)
    VehicleFlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    VehicleFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    VehicleFlyButton.Parent = MainFrame

    -- Função de abrir e fechar a GUI
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    -- Função de ativar/desativar voo com veículo
    VehicleFlyButton.MouseButton1Click:Connect(toggleVehicleFlight)
end

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
