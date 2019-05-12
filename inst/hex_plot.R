## Script to produce the hex_plot

library(hexSticker)

# png picture under CC http://www.pngall.com/canada-leaf-png/download/14302

sticker("canada.png",
        p_color = "#CB4335", p_y = 1.45,
        package="ropencan", p_size=8, s_x=1, s_y=.75, s_width=.5,
        h_fill="#D6EAF8", h_color="#2E4053",
        s_height = 0.5,
        filename="inst/ropencan_hex.png", dpi=1000)
