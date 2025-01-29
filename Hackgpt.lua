local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Função para criar a GUI do Hub
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
    MainFrame.BackgroundTransparency = 0.5  -- 50% de transparência
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

    -- Variáveis de voo
    local flying = false
    local flightSpeed = 50  -- Velocidade do voo
    local jumpPower = 50  -- Poder de pulo
    local gravity = 196.2  -- Gravidade padrão

    -- Botão de Voo
    local FlyButton = Instance.new("TextButton")
    FlyButton.Text = "Ativar Voo"
    FlyButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    FlyButton.Position = UDim2.new(0.3, 0, 0.65, 0)
    FlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlyButton.Parent = MainFrame

    -- Função para ativar/desativar voo
    local function toggleFlight()
        flying = not flying
        if flying then
            FlyButton.Text = "Desativar Voo"
        else
            FlyButton.Text = "Ativar Voo"
        end
    end

    -- Função para ajustar a velocidade do voo
    local function adjustFlightSpeed(value)
        flightSpeed = value
    end

    -- Função para ajustar o poder do pulo
    local function adjustJumpPower(value)
        jumpPower = value
        Player.Character:WaitForChild("Humanoid").JumpPower = jumpPower
    end

    -- Função para ajustar a gravidade
    local function adjustGravity(value)
        gravity = value
        workspace.Gravity = gravity
    end

    -- Criação dos controles deslizantes (Sliders)

    -- Slider de velocidade de voo
    local SpeedSlider = Instance.new("TextBox")
    SpeedSlider.Text = "Velocidade de Voo: " .. flightSpeed
    SpeedSlider.Size = UDim2.new(0.4, 0, 0.1, 0)
    SpeedSlider.Position = UDim2.new(0.3, 0, 0.75, 0)
    SpeedSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpeedSlider.Parent = MainFrame
    SpeedSlider.FocusLost:Connect(function()
        local value = tonumber(SpeedSlider.Text:match("%d+"))
        if value then
            adjustFlightSpeed(value)
            SpeedSlider.Text = "Velocidade de Voo: " .. value
        end
    end)

    -- Slider de poder do pulo
    local JumpSlider = Instance.new("TextBox")
    JumpSlider.Text = "Poder de Pulo: " .. jumpPower
    JumpSlider.Size = UDim2.new(0.4, 0, 0.1, 0)
    JumpSlider.Position = UDim2.new(0.3, 0, 0.85, 0)
    JumpSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    JumpSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpSlider.Parent = MainFrame
    JumpSlider.FocusLost:Connect(function()
        local value = tonumber(JumpSlider.Text:match("%d+"))
        if value then
            adjustJumpPower(value)
            JumpSlider.Text = "Poder de Pulo: " .. value
        end
    end)

    -- Slider de gravidade
    local GravitySlider = Instance.new("TextBox")
    GravitySlider.Text = "Gravidade: " .. gravity
    GravitySlider.Size = UDim2.new(0.4, 0, 0.1, 0)
    GravitySlider.Position = UDim2.new(0.3, 0, 0.95, 0)
    GravitySlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    GravitySlider.TextColor3 = Color3.fromRGB(255, 255, 255)
    GravitySlider.Parent = MainFrame
    GravitySlider.FocusLost:Connect(function()
        local value = tonumber(GravitySlider.Text:match("%d+"))
        if value then
            adjustGravity(value)
            GravitySlider.Text = "Gravidade: " .. value
        end
    end)

    -- Ação dos Botões
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    FlyButton.MouseButton1Click:Connect(toggleFlight)

    -- Loop para mover o personagem enquanto o voo está ativado
    RunService.RenderStepped:Connect(function()
        if flying and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local root = Player.Character.HumanoidRootPart
            local camera = workspace.CurrentCamera
            local direction = camera.CFrame.LookVector * flightSpeed
            root.Velocity = direction
        end
    end)
end

-- Quando o jogador morrer, recria o Hub
Player.CharacterAdded:Connect(function()
    wait(1)  -- Aguarda um momento após o personagem ser criado
    createHubGui()
end)

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
