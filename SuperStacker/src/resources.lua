return {
    sounds = {
        conedrop = love.audio.newSource("assets/sounds/conedrop.ogg", "static");
        conefall = love.audio.newSource("assets/sounds/conefall.ogg", "static");
        win = love.audio.newSource("assets/sounds/win.ogg", "static");
        gold = love.audio.newSource("assets/sounds/gold.wav", "static");
        red = love.audio.newSource("assets/sounds/red.wav", "static");
    },
    fonts = {
        regular20px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 20);
        regular40px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 40);
        regular60px = love.graphics.newFont("assets/fonts/Acme 9 Regular.ttf", 60);
    },
    sprites = {
        cone = love.graphics.newImage("assets/sprites/icon.png");
        classic = love.graphics.newImage("assets/sprites/icons/classic.png");
        arcade = love.graphics.newImage("assets/sprites/icons/arcade.png");
        duels = love.graphics.newImage("assets/sprites/icons/duels.png");
        threeway = love.graphics.newImage("assets/sprites/icons/threeway.png");
        fourway = love.graphics.newImage("assets/sprites/icons/fourway.png");
        royale = love.graphics.newImage("assets/sprites/icons/royale.png");
        keys = {
            ["'"] = love.graphics.newImage("assets/sprites/keys/keyboard_apostrophe_outline.png");
            ["return"] = love.graphics.newImage("assets/sprites/keys/keyboard_numpad_enter_outline.png");
            backspace = love.graphics.newImage("assets/sprites/keys/keyboard_backspace_outline.png");
            lshift = love.graphics.newImage("assets/sprites/keys/keyboard_shift_outline.png");
            space = love.graphics.newImage("assets/sprites/keys/keyboard_space_outline.png");
            tab = love.graphics.newImage("assets/sprites/keys/keyboard_tab_outline.png");
            a = love.graphics.newImage("assets/sprites/keys/keyboard_a_outline.png");
            d = love.graphics.newImage("assets/sprites/keys/keyboard_d_outline.png");
            g = love.graphics.newImage("assets/sprites/keys/keyboard_g_outline.png");
            j = love.graphics.newImage("assets/sprites/keys/keyboard_j_outline.png");
            l = love.graphics.newImage("assets/sprites/keys/keyboard_l_outline.png");
            q = love.graphics.newImage("assets/sprites/keys/keyboard_q_outline.png");
            e = love.graphics.newImage("assets/sprites/keys/keyboard_e_outline.png");
            t = love.graphics.newImage("assets/sprites/keys/keyboard_t_outline.png");
            u = love.graphics.newImage("assets/sprites/keys/keyboard_u_outline.png");
            o = love.graphics.newImage("assets/sprites/keys/keyboard_o_outline.png");
            s = love.graphics.newImage("assets/sprites/keys/keyboard_s_outline.png");
            f = love.graphics.newImage("assets/sprites/keys/keyboard_f_outline.png");
            h = love.graphics.newImage("assets/sprites/keys/keyboard_h_outline.png");
            k = love.graphics.newImage("assets/sprites/keys/keyboard_k_outline.png");
            x = love.graphics.newImage("assets/sprites/keys/keyboard_x_outline.png");
            v = love.graphics.newImage("assets/sprites/keys/keyboard_v_outline.png");
            n = love.graphics.newImage("assets/sprites/keys/keyboard_n_outline.png");
        };
    },
    models = {
        cone = "assets/models/cone.obj";
        redcone = "assets/models/redcone.obj";
        base = "assets/models/base.obj";
    },
    textures = {
        trafficcone = "assets/textures/trafficcone.png";
        redcone = "assets/textures/redcone.png";
        yellowcone = "assets/textures/yellowcone.png";
        orangecone = "assets/textures/orangecone.png";
        goldcone = "assets/textures/goldcone.png";
        bluecone = "assets/textures/bluecone.png";
        base = "assets/textures/base.png";
    }
}