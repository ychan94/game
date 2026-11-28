param([switch]$Publish)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Collections.Generic;
public static class TitleLayers {
 static string[] hex={"120e16","1c1622","282322","171c2b","252d3d","354354","536675","6f7f87","b0b8c0","dfe6ee","2a2236","5a4630","8a6a48","a8862e","e8c35a","fff1c4","b98a5e","7a5a44","e8dcb8","f2e6c8","6f6c66","b8463a","7a2a24","6b9878","a6c5a3","ff9a3c","304b43","456d58","302b27","494039","736357"};
 static Color[] Palette(){var p=new Color[hex.Length];for(int i=0;i<p.Length;i++)p[i]=ColorTranslator.FromHtml("#"+hex[i]);return p;}
 public static void Convert(string input,string output,string layer){
  var p=Palette(); using(var src=new Bitmap(input)) using(var dst=new Bitmap(704,400,PixelFormat.Format32bppArgb)){
   var a=new int[704*400];
   for(int y=0;y<400;y++)for(int x=0;x<704;x++){
    double logicalY=layer=="front"?(y+.5-100)/.75:layer=="mid"?(y+.5)/.85:y+.5;
    if(logicalY<0){a[y*704+x]=0;continue;}
    Color c=src.GetPixel(Math.Min(src.Width-1,(int)((x+.5)*src.Width/704)),Math.Min(src.Height-1,(int)(logicalY*src.Height/400)));
    if((layer!="far" && c.A<128)||(layer=="front"&&y<200)){a[y*704+x]=0;continue;}
    double best=Double.MaxValue; int k=0;
    for(int j=0;j<p.Length;j++){
     if(layer=="far"&&j>9)continue;
     double dr=c.R-p[j].R,dg=c.G-p[j].G,db=c.B-p[j].B;
     double d=dr*dr*.30+dg*dg*.50+db*db*.20;
     if(d<best){best=d;k=j;}
    }
    a[y*704+x]=p[k].ToArgb();
   }
   var clean=(int[])a.Clone();
   int removed=0;
   for(int y=1;y<399;y++)for(int x=1;x<703;x++){
    int n=y*704+x, c=a[n]; if(c==0)continue;
    Color co=Color.FromArgb(c); // Preserve intentional bright eyes, stars and glaze reflections.
    if(co.R>175||co.G>175||co.B>175)continue;
    int[] near={a[n-1],a[n+1],a[n-704],a[n+704]}; bool match=false;
    foreach(int v in near)if(v==c)match=true;
    if(match)continue;
    for(int j=0;j<4;j++){int count=0;foreach(int v in near)if(v==near[j])count++;
     if(count>=3){clean[n]=near[j];removed++;break;}}
   }
   // Merge small dark color islands while retaining silhouette edges and purposeful bright accents.
   var seen=new bool[clean.Length]; int islands=0;
   for(int start=0;start<clean.Length;start++){
    if(seen[start]||clean[start]==0)continue;
    int color=clean[start];Color cc=Color.FromArgb(color);
    if(cc.R>175||cc.G>175||cc.B>175)continue;
    var region=new List<int>();var queue=new Queue<int>();var boundary=new Dictionary<int,int>();
    queue.Enqueue(start);seen[start]=true;
    while(queue.Count>0){int n=queue.Dequeue();region.Add(n);int x=n%704,y=n/704;
     int[] ns={x>0?n-1:-1,x<703?n+1:-1,y>0?n-704:-1,y<399?n+704:-1};
     foreach(int m in ns){if(m<0)continue;int v=clean[m];if(v==color){if(!seen[m]){seen[m]=true;queue.Enqueue(m);}}else{if(!boundary.ContainsKey(v))boundary[v]=0;boundary[v]++;}}
    }
    if(region.Count>(layer=="far"?32:3)||boundary.ContainsKey(0))continue;
    int replacement=color,votes=0;foreach(var item in boundary){if(item.Value>votes){votes=item.Value;replacement=item.Key;}}
    foreach(int n in region)clean[n]=replacement;islands++;
   }
   Console.WriteLine(layer+": small dark color islands merged="+islands);
   for(int y=0;y<400;y++)for(int x=0;x<704;x++)dst.SetPixel(x,y,Color.FromArgb(clean[y*704+x]));
   dst.Save(output,ImageFormat.Png);Console.WriteLine(layer+": isolated dark pixels cleaned="+removed);
  }
 }
 public static string Inspect(string path){using(var b=new Bitmap(path)){
  var colors=new HashSet<int>();int clear=0,partial=0,top=0;
  for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++){var c=b.GetPixel(x,y);colors.Add(c.ToArgb());if(c.A==0)clear++;else {if(y<200)top++;if(c.A!=255)partial++;}}
  return System.IO.Path.GetFileName(path)+": "+b.Width+"x"+b.Height+", RGBA colors="+colors.Count+", transparent="+clear+", partial-alpha="+partial+", top-half-visible="+top;
 }}
 public static void Composite(string dir,string output){using(var b=new Bitmap(704,400))using(var g=Graphics.FromImage(b)){
  foreach(var name in new[]{"far","mid","front"})using(var a=new Bitmap(System.IO.Path.Combine(dir,"title_"+name+".png")))g.DrawImageUnscaled(a,0,0);
  b.Save(output,ImageFormat.Png);
 }}
}
'@
$taskDir = $PSScriptRoot
foreach ($layer in @('far','mid','front')) {
 [TitleLayers]::Convert((Join-Path $taskDir "$layer-generated.png"),(Join-Path $taskDir "title_$layer.png"),$layer)
}
[TitleLayers]::Composite($taskDir,(Join-Path $taskDir 'preview.png'))
$results = foreach ($layer in @('far','mid','front')) { [TitleLayers]::Inspect((Join-Path $taskDir "title_$layer.png")) }
$results | Set-Content -Encoding UTF8 (Join-Path $taskDir 'validation.txt')
$results
if ($Publish) {
 $assetDir = Join-Path (Split-Path (Split-Path $taskDir)) 'assets/sprites/ui'
 foreach ($layer in @('far','mid','front')) {
  $dest = Join-Path $assetDir "title_$layer.png"
  if (Test-Path -LiteralPath $dest) { throw "Refusing to overwrite existing asset: $dest" }
 }
 foreach ($layer in @('far','mid','front')) { Copy-Item -LiteralPath (Join-Path $taskDir "title_$layer.png") -Destination (Join-Path $assetDir "title_$layer.png") }
}
