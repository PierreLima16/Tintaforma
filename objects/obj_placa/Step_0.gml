var _player = place_meeting(x, y, obj_player);

if (_player)
{
    if (!instance_exists(minha_caixa_dialogo))
    {
        minha_caixa_dialogo = instance_create_layer(x, y - 10, "Dialogo", obj_caixa_dialogo);
        minha_caixa_dialogo.texto = texto_caixa;
    }
    
}

else
{
    if (instance_exists(minha_caixa_dialogo))
    {
        minha_caixa_dialogo.me_destruir = true;
        
        
    }
}
