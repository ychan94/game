$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing
Add-Type -ReferencedAssemblies System.Drawing -TypeDefinition @'
using System;
using System.IO;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Collections.Generic;
public static class LogoPrep {
 static Color[] pal = Array.ConvertAll(new string[]{"282322","5a4630","8a6a48","a8862e","e8c35a","fff1c4","7a5a44","b8463a","7a2a24","6b9878","a6c5a3","ff9a3c","e8dcb8"}, s=>ColorTranslator.FromHtml("#"+s));
 static Color Match(Color c) { int best=0; double score=1e20; for(int i=0;i<pal.Length;i++){double r=c.R-pal[i].R,g=c.G-pal[i].G,b=c.B-pal[i].B; double d=r*r+g*g+b*b; if(d<score){score=d; best=i;}} return pal[best]; }
 public static Rectangle Bounds(Bitmap b) {int l=b.Width,t=b.Height,r=-1,d=-1; for(int y=0;y<b.Height;y++)for(int x=0;x<b.Width;x++)if(b.GetPixel(x,y).A>=180){l=Math.Min(l,x);t=Math.Min(t,y);r=Math.Max(r,x);d=Math.Max(d,y);} return Rectangle.FromLTRB(l,t,r+1,d+1);}
 public static Bitmap Process(string path) {
  using(Bitmap s=new Bitmap(path)){
   Rectangle box=Bounds(s); Bitmap b=new Bitmap(320,80);
   int w=302,h=54,left=9,top=13;
   for(int y=0;y<h;y++) for(int x=0;x<w;x++){
    Color c=s.GetPixel(box.Left+(int)((x+.5)*box.Width/w),box.Top+(int)((y+.5)*box.Height/h));
    if(c.A>=180) b.SetPixel(left+x,top+y,Match(c));
   }
   // Normalize silhouette edge to the required ink outline, removing alpha fringes.
   using(Bitmap before=(Bitmap)b.Clone())for(int y=1;y<79;y++)for(int x=1;x<319;x++){
    if(before.GetPixel(x,y).A==0)continue;
    if(before.GetPixel(x-1,y).A==0||before.GetPixel(x+1,y).A==0||before.GetPixel(x,y-1).A==0||before.GetPixel(x,y+1).A==0)b.SetPixel(x,y,pal[0]);
   }
   // Remove isolated opaque pixels, retaining intentional connected highlights.
   using(Bitmap before=(Bitmap)b.Clone())for(int y=1;y<79;y++)for(int x=1;x<319;x++){
    if(before.GetPixel(x,y).A==0)continue; int n=0;
    for(int dy=-1;dy<=1;dy++)for(int dx=-1;dx<=1;dx++)if((dx!=0||dy!=0)&&before.GetPixel(x+dx,y+dy).A>0)n++;
    if(n==0)b.SetPixel(x,y,Color.Transparent);
   }
   return b;
  }
 }
 public static void Draw(Graphics g,Bitmap b,int x,int y,int scale){g.InterpolationMode=InterpolationMode.NearestNeighbor;g.PixelOffsetMode=PixelOffsetMode.Half;g.DrawImage(b,new Rectangle(x,y,b.Width*scale,b.Height*scale),0,0,b.Width,b.Height,GraphicsUnit.Pixel);}
 public static void Run(string dir){
  Bitmap[] opts=new Bitmap[3]; string[] ids={"a","b","c"}; string[] names={"A  /  CELADON SLAB","B  /  CHAMFERED CERAMIC","C  /  IVORY SLAB"};
  using(Bitmap sheet=new Bitmap(1080,770)) using(Graphics g=Graphics.FromImage(sheet))using(Font font=new Font("Arial",12)){
   g.Clear(ColorTranslator.FromHtml("#10101c"));
   for(int i=0;i<3;i++) {opts[i]=Process(Path.Combine(dir,"source-"+ids[i]+".png"));opts[i].Save(Path.Combine(dir,"option-"+ids[i]+".png"));int y=20+i*250;g.DrawString(names[i],font,Brushes.Wheat,20,y);Draw(g,opts[i],20,y+40,2);Draw(g,opts[i],730,y+75,1);g.DrawString("2x",font,Brushes.Gray,20,y+210);g.DrawString("1x",font,Brushes.Gray,730,y+170);}
   sheet.Save(Path.Combine(dir,"logo_options.png"));
  }
  foreach(Bitmap b in opts)b.Dispose();
 }
}
'@
[LogoPrep]::Run($PSScriptRoot)
