## Script to produce the hex_plot

library(hexSticker)

# png picture under CC http://www.pngall.com/canada-leaf-png/download/14302

sticker("inst/canada.png",
        p_color = "#CB4335", p_y = 1.45,
        package="rgovcan", p_size=8, 
        s_x=1, s_y=.75, s_width=.5, s_height = 0.5,
        h_fill="#D6EAF8", h_color="#2E4053",
        filename="inst/rgovcan_hex.png", dpi=1000)
