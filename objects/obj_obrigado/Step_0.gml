
 if (!instance_exists(minha_caixa_dialogo))
{
    minha_caixa_dialogo = instance_create_layer(x, y - 10, "Dialogo", obj_caixa_dialogo);
    minha_caixa_dialogo.texto = texto_caixa;
}
