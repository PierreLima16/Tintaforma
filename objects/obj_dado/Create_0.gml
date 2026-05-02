//Variáveis
estado = noone;


timer = tempo_troca;


//contador timer (quando o timer chegar ou passar de zero) ele muda de estado e reseta o timer
contador_timer = function(_estado = estado_setinha)
{
    timer--;
    
    if (timer <= 0)
    {
        timer = tempo_troca;
        estado = _estado;
    }
}


//Métodos

//estado do dado na seta para cima
estado_setinha = function()
{
    image_index = 0;
    
    mask_index = sprite_index;
    
    contador_timer(estado_seta_para_xis);
}

//estado transição da seta para o xis
estado_seta_para_xis = function()
{
    if (image_index >= 8)
    {
        estado = estado_xis;
    }
}

//estado do dado no xis
estado_xis = function()
{
    image_index = 8; 
    
    mask_index = spr_vazio;
    
    contador_timer(estado_xis_para_seta);
}

//estado transição do xis para seta
estado_xis_para_seta = function()
{
    if (image_index >= image_number - 1)
    {
        estado = estado_setinha;
    }
    
}




estado = estado_setinha;

if (estado_inicial == "estado_xis")
{
    estado = estado_xis;
}