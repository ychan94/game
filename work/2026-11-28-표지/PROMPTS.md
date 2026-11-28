# 생성 방식

내장 image_gen 사용. 이후 PowerShell/C# System.Drawing으로 704×400 최근접 축소, 공통 팔레트 제한, 알파 이진화, 외톨이 어두운 픽셀 정리.

## far

Use case: stylized-concept. Create the FAR BACKGROUND ONLY for a three-layer Korean pixel-art game title illustration. This is one continuous scene, canvas aspect 704:400 (wide 1.76:1), preferably render 1408x800 with an actual 704x400 pixel grid. No text, logo, interface, border or signature.
Art direction follows the viewed references: restrained ink/navy and clay colors, crisp intentional pixel clusters, hand-crafted 1px contours when relevant, no blur, noise, dithering or painterly texture. This layer is entirely OPAQUE.
Scene: quiet Korean night sky, just 8 tiny dim stars away from central area, a small pale cool moon at x560 y64 in 704x400 coordinates, one narrow cloud band beside the moon, two distant rolling mountain silhouettes across lower half. First mountains muted deep navy, nearer mountains almost black ink. Bottom third dark mountain shadow. Center x200..440 y40..230 must be extremely dark, simple, and visually quiet for later title/buttons. Mountain ridges near y230..270. No buildings, kiln, fire, soldiers, plants, ground details or goblins in this layer.
Palette shared across all later layers: ink #120e16 #1c1622 #282322, navy #171c2b #252d3d #354354, slate #536675 #6f7f87, weak moon #b0b8c0 #dfe6ee. Flat discrete shadow steps, at most 64 colors. Lunar light is weak blue ambient fill; the eventual main orange light will come from an offscreen kiln on the right at x560,y250. This background stays subtle, atmospheric and almost still. Make sophisticated broad shapes, not a generic starry wallpaper.

## mid

Use case: stylized-concept. Generate the MIDGROUND layer of the same Korean pixel art title scene as the immediately preceding generated night sky. Only midground objects, on genuine TRANSPARENT background. Canvas wide 704:400 proportions, coordinates below on a 704x400 pixel grid. Do not include sky, moon, mountains, characters, words, borders, logos, or checkerboard. Preserve empty transparent space, do not crop to objects.
Scene construction: in lower LEFT x0..205 a small Korean hamlet of 4 thatched/curved tiled hanok homes, connected stone walls and gate. Silhouettes begin near y200, foundations y270. Only a few warm lit paper windows; most roofs are dark neutral. On RIGHT a traditional wood-fired rounded brick pottery kiln sitting on a small hill, kiln bounds roughly x520..625 y190..270, flame visible in its arched open mouth near x567 y250, chimney above right side and a narrow, restrained dark smoke ribbon to x615 y145. A winding earthen path connects village to kiln across y265..365. Dark continuous earth fills from uneven ground line y265..280 to bottom edge all across width; sparse stones, broad coherent clusters rather than speckled texture. Center x200..440 y0..230 stays 100% transparent for UI and the underlying empty sky.
Lighting: unified main orange light from kiln at right x565 y250, warm pools on its brick doorstep and path to its left; weak blue moon fill from upper right. No second sun, no daylight. Pixel illustration at least as designed and legible as the viewed merchant, clean 1px dark ink-brown contours, crisp pixel edges. Three flat shadow steps, no blur, no gradients, no noise, no decorative clutter.
Use this fixed palette: #120e16 #1c1622 #282322 #171c2b #252d3d #354354 #536675 #6f7f87 #5a4630 #7a5a44 #8a6a48 #b98a5e #6f6c66 #b0b8c0 #e8dcb8 #f2e6c8 #a8862e #e8c35a #fff1c4 #ff9a3c #b8463a #7a2a24. Inky desaturated night with fire/windows as the only high-chroma accents. The generated background above is the compositional and palette reference only, do NOT paint it into this transparent layer.

## front

undefined

