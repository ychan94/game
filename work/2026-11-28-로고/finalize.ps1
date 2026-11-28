$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/prepare.ps1"
$root = (Get-Item "$PSScriptRoot/../..").FullName
$logo = [System.Drawing.Bitmap]::FromFile("$PSScriptRoot/option-a.png")
$logo.Save("$root/assets/sprites/ui/logo.png")
$icon = New-Object System.Drawing.Bitmap(64,64)
for ($y=0; $y -lt 54; $y++) { for ($x=0; $x -lt 40; $x++) { $icon.SetPixel($x+12,$y+5,$logo.GetPixel($x+189,$y+13)) } }
$icon.Save("$root/assets/sprites/ui/app_icon.png")
$preview = New-Object System.Drawing.Bitmap(960,500)
$g = [System.Drawing.Graphics]::FromImage($preview)
$g.Clear([System.Drawing.ColorTranslator]::FromHtml('#10101c'))
$font = New-Object System.Drawing.Font('Arial',12)
$g.DrawString('KILNBORN / SELECTED A / 2x',$font,[System.Drawing.Brushes]::Wheat,30,24)
[LogoPrep]::Draw($g,$logo,160,64,2)
$g.DrawString('1x',$font,[System.Drawing.Brushes]::Gray,160,244)
[LogoPrep]::Draw($g,$logo,160,274,1)
$g.DrawString('ICON 64 / 32',$font,[System.Drawing.Brushes]::Gray,590,244)
[LogoPrep]::Draw($g,$icon,590,282,1)
$g.DrawImage($icon,[System.Drawing.Rectangle]::new(690,298,32,32),0,0,64,64,[System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString('Transparent PNG assets shown on #10101c',$font,[System.Drawing.Brushes]::Gray,160,430)
$preview.Save("$PSScriptRoot/preview_dark.png")
$g.Dispose(); $preview.Dispose(); $logo.Dispose(); $icon.Dispose(); $font.Dispose()
$metrics=@()
foreach($name in @('logo','app_icon')) {
 $b=[System.Drawing.Bitmap]::FromFile("$root/assets/sprites/ui/$name.png")
 $colors=New-Object 'System.Collections.Generic.HashSet[int]'
 $alpha=New-Object 'System.Collections.Generic.HashSet[int]'
 $transparent=0; $partial=0; $isolated=0
 for($y=0;$y -lt $b.Height;$y++){for($x=0;$x -lt $b.Width;$x++){
  $c=$b.GetPixel($x,$y); [void]$alpha.Add([int]$c.A)
  if($c.A -eq 0){$transparent++}else{[void]$colors.Add($c.ToArgb())}
  if($c.A -gt 0 -and $c.A -lt 255){$partial++}
  if($c.A -gt 0){$neighbors=0;for($dy=-1;$dy -le 1;$dy++){for($dx=-1;$dx -le 1;$dx++){
   $xx=$x+$dx;$yy=$y+$dy
   if(($dx -ne 0 -or $dy -ne 0) -and $xx -ge 0 -and $xx -lt $b.Width -and $yy -ge 0 -and $yy -lt $b.Height -and $b.GetPixel($xx,$yy).A -gt 0){$neighbors++}
  }};if($neighbors -eq 0){$isolated++}}
 }}
 $box=[LogoPrep]::Bounds($b)
 $metrics += [pscustomobject]@{file="$name.png";width=$b.Width;height=$b.Height;opaque_colors=$colors.Count;rgba_colors_including_transparent=($colors.Count+1);transparent_pixels=$transparent;partial_alpha_pixels=$partial;isolated_opaque_pixels=$isolated;alpha_values=@($alpha);bounds=@($box.X,$box.Y,$box.Width,$box.Height)}
 $b.Dispose()
}
$metrics | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 "$PSScriptRoot/asset-metrics.json"
$metrics | ConvertTo-Json -Depth 5
