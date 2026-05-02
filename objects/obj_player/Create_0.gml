#region Efeitos

inicia_efeito_squash();

inicia_efeito_brilho();

#endregion



#region Variáveis

//Variáveis de movimento
velh      = 0;
max_velh  = 1;
velv      = 0;
max_velv  = 4;
grav      = 0.2;

velh_corrida = 2;
velh_normal  = 1;


//Lista de sprites
lista_sprites = [spr_player_parando, spr_player_idle];
indice_sprite = 0;

//Variáveis de level
chao = false;
chao_tinta = false;

qtd_pulos = 2;
qtd_pulos_atuais = qtd_pulos;

coyote_tempo = game_get_speed(gamespeed_fps) * 0.1;
coyote_timer = coyote_tempo;

pulo_tempo = game_get_speed(gamespeed_fps) * 0.1;
pulo_timer = 0;

corner_pixels = 20;

//lista de colisões
var _colisao = layer_tilemap_get_id("tl_level");
colisoes = [obj_colisao, _colisao];

//Variáveis de inputs
right = false;
left  = false;
jump  = false;
paint = false;

//Variáveis de estado
estado = noone;

//Olhando para a direção certa
dir = 1;

//Variável de chave
chaves = 0;

//Variável de powerup
powerup_tinta = false;
tileset_tinta = layer_tilemap_get_id("Tl_tinta");


#endregion


#region Métodos
 
//Método trocar sprite
troca_sprite = function(_sprite = spr_colisao)
{
    if (sprite_index != _sprite)
    {
        sprite_index = _sprite;
        image_index = 0;
    }
}

//Método acabou a animação
acabou_animacao = function()
{
    var _spd = sprite_get_speed(sprite_index) / FPS;
    if (image_index + _spd >= image_number)
    {
        return true;
    }
}

transicao_sprites = function()
{
    troca_sprite(lista_sprites[indice_sprite]);
    
    if (acabou_animacao())
    {
        var _qtd = array_length(lista_sprites) - 1;
        
        if (indice_sprite < _qtd)
        {
            indice_sprite++;
        }
    }
}

transicao_estados = function(_estado, _lista)
{
    estado = _estado;
    indice_sprite = 0;
    lista_sprites =_lista;
    
}


coyote_jump = function()
{
    checa_chao();
    
    if (!chao)
    {
        coyote_timer--;
    }
    else
    {
        coyote_timer = coyote_tempo;
    }
}

buffer_pulo = function()
{
    checa_chao();
    pega_input();
    
    if (!chao)
    {
        if (jump) pulo_timer = pulo_tempo;
            
        pulo_timer--;
    }
}
//Métodos de movimento

correr = function()
{
    if (corrida and velh != 0)
    {
        max_velh = velh_corrida;
    }
    
    else
    {
        max_velh = velh_normal;
    }
}

//Estado do jogador parado
estado_parado = function()
{
    velh = 0;
    if (pulo_timer == 0) velv = 0;
    aplica_velocidade();
    
    //troca_sprite(spr_player_idle);
    
    transicao_sprites();
    
    abre_porta();
    
    if (right xor left)
    {
        transicao_estados(estado_movendo, [spr_player_iniciando_movimento, spr_player_move]);
        //indice_sprite = 0;
        //lista_sprites = [spr_player_iniciando_movimento, spr_player_move];
    }
    
    if (jump or pulo_timer)
    {
        transicao_estados(estado_pulo, [spr_player_jump_inicia, spr_player_jump_cima]);
        instance_create_depth(x, y, depth - 1, obj_pulo_particula);
        efeito_squash(0.5, 1.7);
    }
    
    if (!chao)
    {
        estado = estado_pulo;
    }
    
    if (paint and powerup_tinta and chao_tinta)
    {
        estado = estado_tinta_entrar;
    }
    
    
    
}

//Estado do jogador se movendo
estado_movendo = function()
{
    aplica_velocidade();
    
    troca_sprite(spr_player_move);
    
    abre_porta();
    
    
    if (velh == 0)
    {
        transicao_estados(estado_parado, [spr_player_parando, spr_player_idle]);
        //indice_sprite = 0;
        //lista_sprites = [spr_player_parando, spr_player_idle];
    }
    
    if (jump)
    {
        transicao_estados(estado_pulo, [spr_player_jump_inicia, spr_player_jump_cima]);
        instance_create_depth(x, y, depth - 1, obj_pulo_particula);
        efeito_squash(0.5, 1.7);
    }
    
    if (!chao)
    {
        estado = estado_pulo;
    }
    
    if (paint and powerup_tinta and chao_tinta)
    {
        estado = estado_tinta_entrar;
    }
    
    
}

//Estado do jogador pulando
estado_pulo = function()
{
    
    static _inicio_pulo = true;
    
    if (_inicio_pulo)
    {
        qtd_pulos_atuais--;
        
        _inicio_pulo = false;
    }
    
    aplica_velocidade();
    
    if (coyote_timer > 0 and jump)
    {
        velv = -max_velv;
        instance_create_depth(x, y, depth - 1, obj_pulo_particula);
        efeito_squash(0.5, 1.7);
        coyote_timer = 0;
    }
    
    
    
    var _tile = layer_tilemap_get_id("Tl_level");
    var _colisao = [obj_colisao, _tile];
    var _cond = false;
    
    if (place_meeting(x, y + sign(velv), _colisao))
    {
        
        if (velv < 0)
        {
            //Conrner correction DIREITA
            if (velh >= 0)
            {
                for (var i = 0; i < corner_pixels; i++)
                {
                    var _livre = !place_meeting(x + i, y + velv, _colisao);
                    _cond = false;
                    
                    if (_livre)
                    {
                        x += i;
                        _cond = true;
                        
                        break;
                        
                        
                    }
                }
            }
            
            //Corner correction ESQUERDA
            if (velh <= 0) 
            {
                for (var i = 0; i < corner_pixels; i++)
                {
                    var _livre = !place_meeting(x - i, y + velv, _colisao);
                    _cond = false;
                    
                    if (_livre)
                    {
                        x -= i;
                        _cond = true;
                        
                        break;
                    }
                }
            }
            
            if (!_cond) velv = 0; 
        }
    }
        
    
            
    
    //Estou pulando/subindo
    if (velv < 0)
    {
        transicao_sprites();
        
        if (array_contains(colisoes, obj_colisao_one_way))
        {
            var _ind = array_get_index(colisoes, obj_colisao_one_way);
            
            array_delete(colisoes, _ind, 1);
        }
        
        if (jump_r)
        {
            velv *= 0.5;
        }
    }
    
    //Estou caindo
    else
    {
        lista_sprites = [spr_player_jump_queda, spr_player_jump_baixo];
        transicao_sprites();
        
        if (!place_meeting(x, y, obj_colisao_one_way))
        {
            if (!array_contains(colisoes, obj_colisao_one_way))
            {
                array_push(colisoes, obj_colisao_one_way);
            }
            
        }
    }
    
    /*
    if (jump and qtd_pulos_atuais > 0)
    {
        
        lista_sprites = [spr_player_jump_inicia, spr_player_jump_cima];
        
        velv = -max_velv;
        if (qtd_pulos_atuais != 0) qtd_pulos_atuais--;
    }
    */
    
    //Estou no chao
    if (chao)
    {
        _inicio_pulo = true;
        qtd_pulos_atuais = qtd_pulos;
        
        transicao_estados(estado_parado, [spr_player_pousando, spr_player_idle]);
        instance_create_depth(x, y, depth - 1, obj_pouso_particula);
        efeito_squash(1.2, 0.5);
    }
}



//Pegando o powerup
estado_pega_powerup = function()
{
    estado = estado_powerup_inicio;
}

//iniciando o powerup
estado_powerup_inicio = function()
{
    velh = 0;
    velv = 0;
    
    troca_sprite(spr_player_powerup_inicio);
    
    //indo para o meio da animação
    if (acabou_animacao())
    {
        estado = estado_powerup_meio;
    }
}

//meio do powerup
estado_powerup_meio = function()
{
    troca_sprite(spr_player_powerup_meio);
    
    //indo para o fim da animação
    if (!instance_exists(obj_part_powerup))
    {
        estado = estado_powerup_fim;
    }
    
}

//fim do powerup
estado_powerup_fim = function()
{
    troca_sprite(spr_player_powerup_fim);
    
    //voltando a ficar parado
    if (acabou_animacao())
    {
        transicao_estados(estado_parado, [spr_player_idle]);
    }
}

//Estado de entrar na tinta
estado_tinta_entrar = function()
{
    
    velh = 0;
    
    troca_sprite(spr_player_tinta_entrar);
    
    
    if (!instance_exists(obj_tinta_entrar_particula))
    {
        instance_create_depth(x, y, depth - 1, obj_tinta_entrar_particula);
    }
    
    if (acabou_animacao())
    {
        transicao_estados(estado_tinta_loop, [spr_player_tinta_inicia, spr_player_tinta_loop]);
    }
    
}

//Estado estou na tinta (loop)
estado_tinta_loop = function()
{
    transicao_sprites();
       
    aplica_velocidade();
    
    velv = 0;
    
    mask_index = spr_player_tinta_loop;
    
    //Variável temporária para parar o jogador no estado de tinta
    var _parar = !place_meeting(x + (velh * 21), y + 1, tileset_tinta);
    
    //Se não tem chão na minha frente ou embaixo de mim
    if (_parar)
    {
        //eu zero minha velocidade(horizontal)
        velh = 0;
    }
    
    //Se eu apertar para entrar na tinta e já estar dentro dele,
    if (paint)
    {
        //eu saio da tinta
        transicao_estados(estado_tinta_sair, [spr_player_tinta_fim, spr_player_tinta_sair]);
    }
    
}

//Estado de sair da tinta
estado_tinta_sair = function()
{
    velh = 0;
    
    mask_index = spr_player_idle;
    
    /*
    if (!instance_exists(obj_tinta_sair_particula))
    {
        instance_create_depth(x, y, depth - 1, obj_tinta_sair_particula);
    }
    */
    
    var _qtd = array_length(lista_sprites) - 1;
    if (acabou_animacao() and indice_sprite >= _qtd)
    {
        transicao_estados(estado_parado, [spr_player_idle]);
    }
    
    transicao_sprites();
}

removendo_colisao_oneway = function()
{
    if (instance_place(x, y, obj_colisao_one_way))
    {
        if (array_contains(colisoes, obj_colisao_one_way))
        {
            var _ind = array_get_index(colisoes, obj_colisao_one_way);
            array_delete(colisoes, _ind, 1);
        }
    }
}

//pegando os controles para o player    
pega_input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("D"));
    left  = keyboard_check(vk_left) or keyboard_check(ord("A"));
    jump  = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("W"));
    jump_r = keyboard_check_released(vk_space) or keyboard_check_released(ord("W"));
    paint = keyboard_check_pressed(vk_shift);
    
    corrida = keyboard_check(vk_shift);
}

checa_chao = function()
{
    chao = place_meeting(x, y + 1, colisoes);
    
    chao_tinta = place_meeting(x, y + 1, tileset_tinta);
}

//Método abrindo a porta
abre_porta = function()
{
    var _porta = instance_place(x + velh, y, obj_porta)
    
    if (_porta)
    {
        if (chaves > 0 and _porta.estado == "fechada")
        {
            _porta.estado = "abrindo";
            
            //instance_destroy(_porta);
            chaves--;
        }
    }
}

//Método pegando a chave
pega_chave = function()
{
    chaves++;
}

//Método movimento
aplica_velocidade = function()
{
    //checando se estou no chao
    checa_chao();
    
    //Pegando a velocidade
    velh = (right - left) * max_velh;
    
    //Não estou no chão
    if (!chao)
    {
        velv += grav;
    }
    else //Estou no chão
    {
        velv = 0;
        
        y = round(y);
        
        if (jump or pulo_timer)
        {
            velv = -max_velv;
            
            pulo_timer = 0;
        }
    }
    
    
    //Limitando a velocidade de cair do jogador
    velv = clamp(velv, -max_velv, max_velv);
    
    
}

//Ajustando para onde o player olha
ajusta_escala = function()
{
    //Se meu velh for diferente de zero
    if (velh != 0) dir = sign(velh);
}


movimento = function()
{
    //Aplicando a velocidade Horizontal
    move_and_collide(velh, 0, colisoes, 4);
        
    //Aplicando a velocidade Vertical
    move_and_collide(0, velv, colisoes, 24);
}

#endregion

#region Debugs

view_player = noone;

roda_debug = function()
{
    //if (!global.debug) return;
    
    show_debug_overlay(1);
    
    view_player = dbg_view("View player", 1, 40, 100, 300, 400);
    
    var _ref_velv = ref_create(id, "velv");
    
    dbg_watch(_ref_velv, "velv");
    
    dbg_slider(ref_create(id, "max_velv"), 0, 10, "max_velv", 0.1);
    
    dbg_slider(ref_create(id, "grav"), 0, 1, "gravidade", 0.01);
}

ativa_debug = function()
{
    if (!DEBUG_MODE) return;
    
    if (keyboard_check_pressed(vk_tab))
    {
        global.debug = !global.debug;
        
        if (global.debug)
        {
            roda_debug();
        }
        else 
        {
            show_debug_overlay(0);
            
            if (dbg_view_exists(view_player))
            {
                dbg_view_delete(view_player);
            }
        }  
        
        
    }
    
    
}



#endregion


estado = estado_parado;
