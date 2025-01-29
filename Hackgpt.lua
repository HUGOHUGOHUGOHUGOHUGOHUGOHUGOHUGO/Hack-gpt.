local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")

local flying = false
local flightSpeed = 50  -- Velocidade inicial do voo
local jumpPower = 50
local gravity = 196.2  -- Gravidade padrão no Roblox
local teleportDistance = 20  -- Distância máxima para o teleporte

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
    print("Gravidade ajustada para: " .. value)
end

-- Função para ativar/desativar voo
local function toggleFlight()
    flying = not flying
    if flying then
        print("Voo ativado!")
    else
        print("Voo desativado!")
    end
end

-- Função para movimentar o jogador no voo
local function handleFlight()
    if flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local root = Player.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        local direction = camera.CFrame.LookVector * flightSpeed
        local upDirection = Vector3.new(0, 1, 0) * flightSpeed
        
        -- Movendo o jogador no voo
        root.Velocity = direction + upDirection

        -- Teleporte para onde a câmera está olhando
        local targetPosition = camera.CFrame.Position + camera.CFrame.LookVector * teleportDistance
        root.CFrame = CFrame.new(targetPosition)
    end
end

-- Criando a GUI com rolagem
local function createHubGui()
    -- Criando a Interface
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HubGui"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    -- MainFrame (com transparência)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.4, 0, 0.7, 0)  -- Ajustando a altura para suportar rolagem
    MainFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.3  -- Ajustando transparência para 30%
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    -- Criando uma Frame de conteúdo para rolagem
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    ContentFrame.Position = UDim2.new(0, 0, 0, 0)
    ContentFrame.Parent = MainFrame

    -- Adicionando rolagem
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Parent = ContentFrame
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 2, 0)  -- Aumentando o tamanho da área rolável
    ScrollingFrame.ScrollBarThickness = 8  -- Espessura da barra de rolagem

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
    FlyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    FlyButton.Position = UDim2.new(0.1, 0, 0.05, 0)
    FlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyButton.Parent = ScrollingFrame

    -- Botões para aumentar e diminuir a velocidade do voo
    local SpeedButtonIncrease = Instance.new("TextButton")
    SpeedButtonIncrease.Text = "Aumentar Velocidade: " .. flightSpeed
    SpeedButtonIncrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    SpeedButtonIncrease.Position = UDim2.new(0.1, 0, 0.15, 0)
    SpeedButtonIncrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedButtonIncrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedButtonIncrease.Parent = ScrollingFrame

    local SpeedButtonDecrease = Instance.new("TextButton")
    SpeedButtonDecrease.Text = "Diminuir Velocidade"
    SpeedButtonDecrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    SpeedButtonDecrease.Position = UDim2.new(0.1, 0, 0.25, 0)
    SpeedButtonDecrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedButtonDecrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedButtonDecrease.Parent = ScrollingFrame

    -- Botão de Ajustar Pulo
    local JumpButtonIncrease = Instance.new("TextButton")
    JumpButtonIncrease.Text = "Aumentar Pulo: " .. jumpPower
    JumpButtonIncrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    JumpButtonIncrease.Position = UDim2.new(0.1, 0, 0.35, 0)
    JumpButtonIncrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    JumpButtonIncrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpButtonIncrease.Parent = ScrollingFrame

    local JumpButtonDecrease = Instance.new("TextButton")
    JumpButtonDecrease.Text = "Diminuir Pulo"
    JumpButtonDecrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    JumpButtonDecrease.Position = UDim2.new(0.1, 0, 0.45, 0)
    JumpButtonDecrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    JumpButtonDecrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpButtonDecrease.Parent = ScrollingFrame

    -- Botão de Ajustar Gravidade
    local GravityButtonIncrease = Instance.new("TextButton")
    GravityButtonIncrease.Text = "Aumentar Gravidade: " .. gravity
    GravityButtonIncrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    GravityButtonIncrease.Position = UDim2.new(0.1, 0, 0.55, 0)
    GravityButtonIncrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    GravityButtonIncrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    GravityButtonIncrease.Parent = ScrollingFrame

    local GravityButtonDecrease = Instance.new("TextButton")
    GravityButtonDecrease.Text = "Diminuir Gravidade"
    GravityButtonDecrease.Size = UDim2.new(0.8, 0, 0.1, 0)
    GravityButtonDecrease.Position = UDim2.new(0.1, 0, 0.65, 0)
    GravityButtonDecrease.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    GravityButtonDecrease.TextColor3 = Color3.fromRGB(255, 255, 255)
    GravityButtonDecrease.Parent = ScrollingFrame

    -- Função de abrir e fechar a GUI
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    -- Função de ativar/desativar voo
    FlyButton.MouseButton1Click:Connect(toggleFlight)

    -- Aumentar Velocidade
    SpeedButtonIncrease.MouseButton1Click:Connect(function()
        flightSpeed = flightSpeed + 10
        SpeedButtonIncrease.Text = "Aumentar Velocidade: " .. flightSpeed
        print("Velocidade ajustada para: " .. flightSpeed)
    end)

    -- Diminuir Velocidade
    SpeedButtonDecrease.MouseButton1Click:Connect(function()
        flightSpeed = flightSpeed - 10
        if flightSpeed < 10 then
            flightSpeed = 10  -- Limitar para uma velocidade mínima
        end
        SpeedButtonIncrease.Text = "Aumentar Velocidade: " .. flightSpeed
        print("Velocidade ajustada para: " .. flightSpeed)
    end)

    -- Ajuste de pulo
    JumpButtonIncrease.MouseButton1Click:Connect(function()
        jumpPower = jumpPower + 10
        JumpButtonIncrease.Text = "Aumentar Pulo: " .. jumpPower
        adjustJumpPower(jumpPower)
    end)

    JumpButtonDecrease.MouseButton1Click:Connect(function()
        jumpPower = jumpPower - 10
        if jumpPower < 10 then
            jumpPower = 10  -- Limitar para um poder de pulo mínimo
        end
        JumpButtonIncrease.Text = "Aumentar Pulo: " .. jumpPower
        adjustJumpPower(jumpPower)
    end)

    -- Ajuste de gravidade
    GravityButtonIncrease.MouseButton1Click:Connect(function()
        gravity = gravity + 10
        GravityButtonIncrease.Text = "Aumentar Gravidade: " .. gravity
        adjustGravity(gravity)
    end)

    GravityButtonDecrease.MouseButton1Click:Connect(function()
        gravity = gravity - 10
        if gravity < 50 then
            gravity = 50  -- Limitar a gravidade para não ser negativa ou muito baixa
        end
        GravityButtonIncrease.Text = "Aumentar Gravidade: " .. gravity
        adjustGravity(gravity)
    end)
end

createHubGui()

-- Loop para movimentar o jogador enquanto o voo está ativado
RunService.RenderStepped:Connect(handleFlight)
