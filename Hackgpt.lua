local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")

local flying = false
local noclipping = false
local flightSpeed = 50
local jumpPower = 50
local gravity = 196.2  -- Gravidade padrão no Roblox

-- Função para ativar/desativar voo
local function toggleFlight()
    flying = not flying
    if flying then
        FlyButton.Text = "Desativar Voo"
    else
        FlyButton.Text = "Ativar Voo"
    end
end

-- Função para ativar/desativar noclip
local function toggleNoClip()
    noclipping = not noclipping
    if noclipping then
        NoClipButton.Text = "Desativar Noclip"
    else
        NoClipButton.Text = "Ativar Noclip"
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

-- Loop de voo e noclip
RunService.RenderStepped:Connect(function()
    if flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        local direction = camera.CFrame.LookVector * flightSpeed
        root.Velocity = direction
    end

    -- Noclip
    if noclipping and Player.Character then
        local character = Player.Character
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CanCollide = false
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    else
        -- Se o noclip estiver desativado, garantir que as colisões sejam ativadas
        if Player.Character then
            local character = Player.Character
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Criação da GUI com novos botões
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

    -- Botão de Voo
    local FlyButton = Instance.new("TextButton")
    FlyButton.Text = "Ativar Voo"
    FlyButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    FlyButton.Position = UDim2.new(0.3, 0, 0.65, 0)
    FlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyButton.Parent = MainFrame

    -- Botão de Noclip
    local NoClipButton = Instance.new("TextButton")
    NoClipButton.Text = "Ativar Noclip"
    NoClipButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    NoClipButton.Position = UDim2.new(0.3, 0, 0.75, 0)
    NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NoClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoClipButton.Parent = MainFrame

    -- Função de abrir e fechar a GUI
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    -- Funções de ativar/desativar voo e noclip
    FlyButton.MouseButton1Click:Connect(toggleFlight)
    NoClipButton.MouseButton1Click:Connect(toggleNoClip)
end

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
