return {
    sounds = {
        conedrop = love.audio.newSource("assets/sounds/conedrop.ogg", "static");
        conefall = love.audio.newSource("assets/sounds/conefall.ogg", "static");
    },
    fonts = {
        regular20px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 20);
        regular40px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 40);
        regular60px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 60);
    },
    sprites = {
        cone = love.graphics.newImage("assets/icon.png");
        keys = {
            ["'"] = love.graphics.newImage("assets/sprites/keyboard_apostrophe_outline.png");
            ["return"] = love.graphics.newImage("assets/sprites/keyboard_numpad_enter_outline.png");
            backspace = love.graphics.newImage("assets/sprites/keyboard_backspace_outline.png");
            lshift = love.graphics.newImage("assets/sprites/keyboard_shift_outline.png");
            space = love.graphics.newImage("assets/sprites/keyboard_space_outline.png");
            tab = love.graphics.newImage("assets/sprites/keyboard_tab_outline.png");
            a = love.graphics.newImage("assets/sprites/keyboard_a_outline.png");
            d = love.graphics.newImage("assets/sprites/keyboard_d_outline.png");
            g = love.graphics.newImage("assets/sprites/keyboard_g_outline.png");
            j = love.graphics.newImage("assets/sprites/keyboard_j_outline.png");
            l = love.graphics.newImage("assets/sprites/keyboard_l_outline.png");
            q = love.graphics.newImage("assets/sprites/keyboard_q_outline.png");
            e = love.graphics.newImage("assets/sprites/keyboard_e_outline.png");
            t = love.graphics.newImage("assets/sprites/keyboard_t_outline.png");
            u = love.graphics.newImage("assets/sprites/keyboard_u_outline.png");
            o = love.graphics.newImage("assets/sprites/keyboard_o_outline.png");
            s = love.graphics.newImage("assets/sprites/keyboard_s_outline.png");
            f = love.graphics.newImage("assets/sprites/keyboard_f_outline.png");
            h = love.graphics.newImage("assets/sprites/keyboard_h_outline.png");
            k = love.graphics.newImage("assets/sprites/keyboard_k_outline.png");
            x = love.graphics.newImage("assets/sprites/keyboard_x_outline.png");
            v = love.graphics.newImage("assets/sprites/keyboard_v_outline.png");
            n = love.graphics.newImage("assets/sprites/keyboard_n_outline.png");
        };
    },
    models = {
        cone = "assets/models/cone.obj";
        base = "assets/models/base.obj";
    },
    textures = {
        trafficcone = "assets/textures/trafficcone.png";
        base = "assets/textures/base.png";
    },
}