Import-Module oh-my-posh
# Function Ipython {python -m IPython}
# 一些命令的别名
Function ipy {python -m IPython}
Function cvue {cd e:\vue-project}
function gcl {
	git clone --recursive $args
}
function touch {New-Item "$args" -ItemType File}

Set-Alias notepad D:\Notepad2_zh-Hans_x64_v4.22.01r4056\Notepad2.exe
Set-Alias codex D:\Programs\VSCodeInsiders\bin\code-insiders.cmd
Set-Alias hugo D:\Programs\hugo_0.93.2_Windows-64bit\hugo.exe
Set-Alias -Name ll -Value Get-ChildItem

# 设置主题
oh-my-posh --init --shell pwsh --config "~/my_aliens.json" | Invoke-Expression
# 导入图标
Import-Module -Name Terminal-Icons
# 设置自动补全
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
# 提示颜色
Set-PSReadLineOption -Colors @{ InlinePrediction = '#757679'}

# This custom binding makes `RightArrow` behave similarly - accepting the next word instead of the entire suggestion text.
Set-PSReadLineKeyHandler -Key RightArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
                         -ScriptBlock {
    param($key, $arg)

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -lt $line.Length) {
        [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
    }
}

cls
