local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Função para conceder todas as GamePasses automaticamente
local function grantAllGamePasses()
    local gamePassService = game:GetService("GamePassService")
    local success, gamePasses = pcall(function()
        return gamePassService:GetGamePasses(Player)  -- Tenta obter as GamePasses do jogador
    end)
    
    if success then
        -- Para cada GamePass, concede automaticamente
        for _, gamePass in pairs(gamePasses) do
            local gamePassId = gamePass.Id
            local hasGamePass = Player:HasGamePass(gamePassId)

            -- Se o jogador não tem a GamePass, concede
            if not hasGamePass then
                local successGrant = pcall(function()
                    Player:GrantGamePass(gamePassId)  -- Concede a GamePass ao jogador
                end)

                if successGrant then
                    print("GamePass " .. gamePassId .. " concedida com sucesso!")
                else
                    print("Erro ao conceder a GamePass " .. gamePassId)
                end
            else
                print("O jogador já possui a GamePass: " .. gamePassId)
            end
        end
    else
        print("Erro ao obter as GamePasses: " .. tostring(gamePasses))
    end
end

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
    MainFrame.BackgroundTransparency = 0.5  -- Definindo 50% de transparência
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    -- OpenButton (botão para abrir)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Text = "Abrir Hub"
    OpenButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    OpenButton.Position = UDim2.new(0, 0, 0.9, 0)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    OpenButton.Parent = ScreenGui

    -- CloseButton (botão para fechar)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "Fechar"
    CloseButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Cor preta
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Cor do texto branca
    CloseButton.Parent = MainFrame

local flying = false
local flightSpeed = 50  -- Velocidade do voo

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
    -- Aguarda a criação do personagem e recria o Hub
    wait(1)  -- Aguarda um momento após o personagem ser criado
    createHubGui()
end)

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
e
