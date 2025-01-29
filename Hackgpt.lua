local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Função para pegar todos os itens de todo o jogo, independentemente da pasta
local function pickUpAllItems()
    -- Lista de serviços que vamos percorrer
    local services = {
        game.Workspace,
        game.ReplicatedStorage,
        game.ServerStorage,
        game.Lighting,
        game.CollectionService,
        game.Players
    }
    
    -- Percorrer todos os serviços e suas pastas
    for _, service in ipairs(services) do
        for _, item in ipairs(service:GetDescendants()) do
            -- Verifica se o item é um "BasePart" ou "Model" ou outros tipos que você deseja pegar
            if item:IsA("BasePart") or item:IsA("Model") then
                -- Aqui, podemos destruir o item como exemplo, mas você pode mover para o inventário ou outra coisa
                item:Destroy()
                print("Item Pegado: " .. item.Name .. " de " .. service.Name)
            end
        end
    end
end

-- Variáveis para Controle
local speed = 16  -- Velocidade padrão
local jumpPower = 50  -- Poder de pulo padrão

-- Função para criar a GUI do Hub
local function createHubGui()
    -- Criando a Interface
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "HubGui"
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")

    -- MainFrame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    -- OpenButton
    local OpenButton = Instance.new("TextButton")
    OpenButton.Text = "Abrir Hub"
    OpenButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    OpenButton.Position = UDim2.new(0, 0, 0.9, 0)
    OpenButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    OpenButton.Parent = ScreenGui

    -- CloseButton
    local CloseButton = Instance.new("TextButton")
    CloseButton.Text = "Fechar"
    CloseButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.Parent = MainFrame

    -- Botão para ajustar a Velocidade
    local SpeedButton = Instance.new("TextButton")
    SpeedButton.Text = "Ajustar Velocidade"
    SpeedButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    SpeedButton.Position = UDim2.new(0.3, 0, 0.2, 0)
    SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    SpeedButton.Parent = MainFrame

    -- Botão para ajustar o Poder de Pulo
    local JumpPowerButton = Instance.new("TextButton")
    JumpPowerButton.Text = "Ajustar Pulo"
    JumpPowerButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    JumpPowerButton.Position = UDim2.new(0.3, 0, 0.35, 0)
    JumpPowerButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    JumpPowerButton.Parent = MainFrame

    -- Botão para pegar todos os itens
    local PickUpButton = Instance.new("TextButton")
    PickUpButton.Text = "Pegar Todos os Itens"
    PickUpButton.Size = UDim2.new(0.4, 0, 0.1, 0)
    PickUpButton.Position = UDim2.new(0.3, 0, 0.5, 0)
    PickUpButton.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    PickUpButton.Parent = MainFrame

    -- Função para ajustar a velocidade
    local function adjustSpeed()
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.3, 0, 0.1, 0)
        input.Position = UDim2.new(0.35, 0, 0.5, 0)
        input.Text = tostring(speed)
        input.Parent = MainFrame

        -- Aguarda o usuário digitar o valor
        input.FocusLost:Connect(function()
            local newSpeed = tonumber(input.Text)
            if newSpeed then
                speed = newSpeed
                Player.Character:WaitForChild("Humanoid").WalkSpeed = speed
            end
            input:Destroy()
        end)

        input:CaptureFocus()
    end

    -- Função para ajustar o poder de pulo
    local function adjustJumpPower()
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.3, 0, 0.1, 0)
        input.Position = UDim2.new(0.35, 0, 0.65, 0)
        input.Text = tostring(jumpPower)
        input.Parent = MainFrame

        -- Aguarda o usuário digitar o valor
        input.FocusLost:Connect(function()
            local newJumpPower = tonumber(input.Text)
            if newJumpPower then
                jumpPower = newJumpPower
                Player.Character:WaitForChild("Humanoid").JumpPower = jumpPower
            end
            input:Destroy()
        end)

        input:CaptureFocus()
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

    SpeedButton.MouseButton1Click:Connect(adjustSpeed)
    JumpPowerButton.MouseButton1Click:Connect(adjustJumpPower)
    PickUpButton.MouseButton1Click:Connect(pickUpAllItems)

    -- Configurações iniciais de velocidade e pulo
    local humanoid = Player.Character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed
    humanoid.JumpPower = jumpPower
end

-- Quando o jogador morrer, recria o Hub
Player.CharacterAdded:Connect(function()
    -- Aguarda a criação do personagem e recria o Hub
    wait(1)  -- Aguarda um momento após o personagem ser criado
    createHubGui()
end)

-- Cria o Hub imediatamente quando o jogo começa
createHubGui()
