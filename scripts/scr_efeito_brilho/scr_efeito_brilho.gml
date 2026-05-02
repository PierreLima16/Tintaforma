//EFEITO DE BRILHO

//USADO NO EVENTO "CREATE"
//Iniciando efeito de brilho
//Você usa essa função para iniciar as variáveis necessárias para efeito brilho
function inicia_efeito_brilho()
{
    xscale  = 1;
    yscale  = 1;
    dir     = 0;
    
    alpha_brilho    = 0;
    cor_brilho      = c_white;
    
}

//USADO QUANDO QUER QUE O EFEITO SEJA APLICADO
//Aplicando o efeito de brilho
//Você usa essa função para aplicar o efeito de brilho[
//Você pode mudar a cor do brilho
//Você pode mudar a  intensidade do brilho ( 0 = Mínimo de força, 1 = Máximo de força)
function aplica_efeito_brilho(_cor = c_white, _valor = 1)
{
    alpha_brilho    = _valor;
    cor_brilho      = _cor;
}

//USADO NO EVENTO "STEP"
//Retornando o efeito de brilho
//Você usa essa função para retornar o brilho
//Você pode alterar o valor para qual irá voltar
//Você pode alterar qual a velocidade que irá voltar
function retorna_efeito_brilho(_voltar = 0, _velocidade = 0.1)
{
    alpha_brilho = lerp(alpha_brilho, _voltar, _velocidade);
}

//USADO NO EVENTO "DRAW" DEPOIS DE DESENHAR A SUA SPRITE
//Desenhando o efeito de brilho
//Você usa essa função para desenhar o efeito de brilho
function desenha_efeito_brilho()
{
    if (alpha_brilho <= 0.01) return;
    
    shader_set(sh_muda_cor);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, cor_brilho, alpha_brilho);
    shader_reset();
}






