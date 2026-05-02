pega_input();
checa_chao();
ajusta_escala();
movimento();
ativa_debug();
removendo_colisao_oneway();

retorna_squash(0.1)

retorna_efeito_brilho(0, 0.06);

coyote_jump();
buffer_pulo();
correr();

estado();


////Se eu pressionar a tecla R
//if (keyboard_check_pressed(ord("R"))) cor_brilho = c_red; //Me coloro de vermelho
//
////Se eu pressionar a tecla G
//if (keyboard_check_pressed(ord("G"))) cor_brilho = c_green; //Me coloro de verde
//
////Se eu pressionar a tecla B
//if (keyboard_check_pressed(ord("B"))) cor_brilho = c_blue; //Me coloro de azul
//
//if (keyboard_check_pressed(ord("K"))) aplica_efeito_brilho();


//if (keyboard_check_pressed(ord("U")))
//{
    //cria_transicao_inicia(rm_tutorial_2);
//}

if (keyboard_check_pressed(ord("R")))
{
    cria_transicao_inicia(room);    
}    

if (keyboard_check_pressed(vk_f11))
{
    var _full = window_get_fullscreen();
    window_set_fullscreen(!_full);
}
